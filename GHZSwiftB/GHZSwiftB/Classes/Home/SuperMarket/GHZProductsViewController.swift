//
//  GHZProductsViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
//GHZProductsViewControllerDelegate
@objc protocol GHZProductsViewControllerDelegate: NSObjectProtocol {
    @objc optional func didEndDisplayingHeaderView(_ section: Int)
    @objc optional func willDisplayHeaderView(_ section: Int)
}
class GHZProductsViewController: GHZAnimationViewController {

    private let headViewIdentifier  = "supermarketHeadView"
    private var lastOffsetY: CGFloat = 0
    private var isScrollDown = false
    var productsTableView: GHZCustomTableView?
    weak var delegate: GHZProductsViewControllerDelegate?
    var refreshUpPull:(() -> ())?
    
    private var shops: [[Shops]]? {
        didSet {
            productsTableView?.reloadData()
        }
    }
    
    var supermarketData: GHZSupermarketModel? {
        didSet {
            self.shops = GHZSupermarketModel.searchCategoryMatchProducts(supermarketData!.data!)
        }
    }
    
    var categortsSelectedIndexPath: IndexPath? {
        didSet {
            productsTableView?.selectRow(at: IndexPath(row: 0, section: categortsSelectedIndexPath!.row), animated: true, scrollPosition: .top)
        }
    }
    
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default().addObserver(self, selector: #selector(GHZProductsViewController.shopCarBuyProductNumberDidChange), name: GHZShopCartProductNumberDidChange, object: nil)
        
        view = UIView(frame: CGRect(x: GHZScreenWidth * 0.25, y: 0, width: GHZScreenWidth * 0.75, height: GHZScreenHeight - GHZNavigationHeight))
        buildProductsTableView()
    }
    
    deinit {
        NotificationCenter.default().removeObserver(self)
    }
    
    // MARK: - Build UI
    private func buildProductsTableView() {
        productsTableView = GHZCustomTableView(frame: view.bounds, style: .plain)
        productsTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        productsTableView?.backgroundColor = GHZGlobalBackgroundColor
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.register(GHZSupermarketHeaderView.self, forHeaderFooterViewReuseIdentifier: headViewIdentifier)
        productsTableView?.tableFooterView = buildProductsTableViewTableFooterView()
        
        let headView = GHZRefreshHeader(refreshingTarget: self, refreshingAction: #selector(GHZProductsViewController.startRefreshUpPull))
        productsTableView?.mj_header = headView
        
        view.addSubview(productsTableView!)
    }
    
    private func buildProductsTableViewTableFooterView() -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: productsTableView!.width, height: 70))
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage(named: "v2_common_footer")
        return imageView
    }
    
    // MARK: - 上拉刷新
    func startRefreshUpPull() {
        if refreshUpPull != nil {
            refreshUpPull!()
        }
    }
    
    // MARK: - Action
    func shopCarBuyProductNumberDidChange() {
        productsTableView?.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension GHZProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shops?.count > 0 {
            return shops![section].count ?? 0
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GHZProductTableViewCell.cellWithTableView(tableView)
        let shopsArray = shops![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.shops = shopsArray
        
        weak var weakSelf = self
        cell.addProductClick = { (imageView) -> () in
            weakSelf?.addProductsAnimation(imageView)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headViewIdentifier) as! GHZSupermarketHeaderView
        if supermarketData?.data?.categories?.count > 0 && supermarketData!.data!.categories![section].name != nil {
            headView.titleLabel.text = supermarketData!.data!.categories![section].name
        }
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if delegate != nil && delegate!.responds(to: #selector(GHZProductsViewControllerDelegate.didEndDisplayingHeaderView(_:))) && isScrollDown {
            delegate!.didEndDisplayingHeaderView!(section)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && delegate!.responds(to: #selector(GHZProductsViewControllerDelegate.willDisplayHeaderView(_:))) && !isScrollDown {
            delegate!.willDisplayHeaderView!(section)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = shops![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        let productDetailVC = GHZProductDetailViewController(shops: shop)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
// MARK: - UIScrollViewDelegate
extension GHZProductsViewController:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animationLayerArray?.count > 0 {
            let transitionLayer = animationLayerArray![0]
            transitionLayer.isHidden = true
        }
        
        isScrollDown = lastOffsetY < scrollView.contentOffset.y
        lastOffsetY = scrollView.contentOffset.y
    }
}
