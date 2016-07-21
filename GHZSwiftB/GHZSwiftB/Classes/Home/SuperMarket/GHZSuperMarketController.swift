//
//  GHZSuperMarketController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
import SVProgressHUD
class GHZSuperMarketController: GHZSeletedAddressViewController {

    private var supermarketData: GHZSupermarketModel?
    private var categoryTableView: GHZCustomTableView!
    private var productsVC: GHZProductsViewController!
    
    // flag
    private var categoryTableViewIsLoadFinish = false
    private var productTableViewIsLoadFinish  = false
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        
        showProgressHUD()
        
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }
        
        NotificationCenter.default().post(name: Notification.Name(rawValue: "LFBSearchViewControllerDeinit"), object: nil)
        navigationController?.navigationBar.barTintColor = GHZNavigationYellowColor
    }
    
    deinit {
        NotificationCenter.default().removeObserver(self)
    }
    
    private func addNotification() {
        NotificationCenter.default().addObserver(self, selector: #selector(GHZSuperMarketController.shopCarBuyProductNumberDidChange), name: GHZShopCartProductNumberDidChange, object: nil)
    }
    
    func shopCarBuyProductNumberDidChange() {
        if productsVC.productsTableView != nil {
            productsVC.productsTableView!.reloadData()
        }
    }
    
    // MARK:- Creat UI
    private func bulidCategoryTableView() {
        categoryTableView = GHZCustomTableView(frame: CGRect(x: 0, y: 0, width: GHZScreenWidth * 0.25, height: GHZScreenHeight), style: .plain)
        categoryTableView.backgroundColor = GHZGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: GHZNavigationHeight, right: 0)
        categoryTableView.isHidden = true;
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController() {
        productsVC = GHZProductsViewController()
        productsVC.delegate = self
        productsVC.view.isHidden = true
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var weakSelf = self
        productsVC.refreshUpPull = {
            let time = DispatchTime.now() + Double(Int64(1.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.after(when: time, execute: {
                GHZSupermarketModel.loadSupermarketData { (data, error) -> Void in
                    if error == nil {
                        weakSelf!.supermarketData = data
                        weakSelf!.productsVC.supermarketData = data
                        weakSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        weakSelf!.categoryTableView.reloadData()
                        weakSelf!.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
                    }
                }
            })
        }
    }
    
    private func loadSupermarketData() {
        let time = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        weak var weakSelf = self
        DispatchQueue.main.after(when: time ,execute: {
            GHZSupermarketModel.loadSupermarketData { (data, error) -> Void in
                if error == nil {
                    weakSelf!.supermarketData = data
                    weakSelf!.categoryTableView.reloadData()
                    weakSelf!.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
                    weakSelf!.productsVC.supermarketData = data
                    weakSelf!.categoryTableViewIsLoadFinish = true
                    weakSelf!.productTableViewIsLoadFinish = true
                    if weakSelf!.categoryTableViewIsLoadFinish && weakSelf!.productTableViewIsLoadFinish {
                        weakSelf!.categoryTableView.isHidden = false
                        weakSelf!.productsVC.productsTableView!.isHidden = false
                        weakSelf!.productsVC.view.isHidden = false
                        weakSelf!.categoryTableView.isHidden = false
                        SVProgressHUD.dismiss()
                        weakSelf!.view.backgroundColor = GHZGlobalBackgroundColor
                    }
                }
            }
        })
    }
    
    // MARK: - Private Method
    private func showProgressHUD() {
        SVProgressHUD.setBackgroundColor(UIColor.customColorWithFloat(r: 230, g: 230, b: 230, a: 1.0))
        view.backgroundColor = UIColor.white()
        if !SVProgressHUD.isVisible() {
            SVProgressHUD.show(withStatus: "正在加载中")
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension GHZSuperMarketController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GHZCategoryCell.cellWithTableView(tableView)
        cell.categorie = supermarketData!.data!.categories![(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
        }
    }
    
}

// MARK: - SupermarketViewController
extension GHZSuperMarketController: GHZProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(_ section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    
    func willDisplayHeaderView(_ section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
}
