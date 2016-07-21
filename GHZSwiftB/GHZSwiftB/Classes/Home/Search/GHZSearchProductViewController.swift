//
//  GHZSearchProductViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
import SVProgressHUD
class GHZSearchProductViewController: GHZAnimationViewController {

    private let contentScrollView = UIScrollView(frame: GHZScreenBounds)
    private let searchBar = UISearchBar()
    private var hotSearchView: GHZSearchView?
    private var historySearchView: GHZSearchView?
    private let cleanHistoryButton: UIButton = UIButton()
    private var searchCollectionView: GHZCustomCollectionView?
    private var shops: [Shops]?
    private var collectionHeadView: NOSearchProductView?
    private var yellowShopCar: GHZYellowShopCartView?
    
    // MARK: - Lief Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildContentScrollView()
        
        buildSearchBar()
        
        buildCleanHistorySearchButton()
        
        loadHotSearchButtonData()
        
        loadHistorySearchButtonData()
        
        buildsearchCollectionView()
        
        buildYellowShopCar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
        
        if searchCollectionView != nil && shops?.count > 0 {
            searchCollectionView!.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default().post(name: "GHZSearchViewControllerDeinit" as NSNotification.Name, object: nil)
    }
    
    // MARK: - Build UI
    private func buildContentScrollView() {
        contentScrollView.backgroundColor = view.backgroundColor
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.delegate = self
        view.addSubview(contentScrollView)
    }
    
    private func buildSearchBar() {
        
        (navigationController as! GHZNavViewController).backBtn.frame = CGRect(x: 0, y: 0, width: 10, height: 40)
        let tmpView = UIView(frame:CGRect(x: 0, y: 0, width: GHZScreenWidth * 0.8, height: 30))
        tmpView.backgroundColor = UIColor.white()
        tmpView.layer.masksToBounds = true
        tmpView.layer.cornerRadius = 6
        tmpView.layer.borderColor = UIColor.customColorWithFloat(r: 100, g: 100, b: 100, a: 1.0).cgColor
        tmpView.layer.borderWidth = 0.2
        let image = UIImage.createImageFromView(view: tmpView)
        
        searchBar.frame = CGRect(x: 0, y: 0, width: GHZScreenWidth * 0.9, height: 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.barTintColor = UIColor.white()
        searchBar.keyboardType = UIKeyboardType.default
        searchBar.setSearchFieldBackgroundImage(image, for: UIControlState())
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        let navVC = navigationController as! GHZNavViewController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn!.addTarget(self, action: #selector(GHZSearchProductViewController.leftButtonClcik), for: UIControlEvents.touchUpInside)
        navVC.isAnimation = false
    }
    
    private func buildYellowShopCar() {
        
        weak var weakSelf = self
        
        yellowShopCar = GHZYellowShopCartView(frame: CGRect(x: GHZScreenWidth - 70, y: GHZScreenHeight - 70 - GHZNavigationHeight, width: 61, height: 61), shopViewClick: { () -> () in
            let shopCarVC = GHZShopCartController()
            let nav = GHZNavViewController(rootViewController: shopCarVC)
            weakSelf!.present(nav, animated: true, completion: nil)
        })
        yellowShopCar?.isHidden = true
        view.addSubview(yellowShopCar!)
    }
    
    private func loadHotSearchButtonData() {
        var array: [String]?
        var historySearch = UserDefaults.standard().object(forKey: GHZSearchViewControllerHistorySearchArray) as? [String]
        if historySearch == nil {
            historySearch = [String]()
            UserDefaults.standard().set(historySearch, forKey: GHZSearchViewControllerHistorySearchArray)
        }
        weak var tmpSelf = self
        let pathStr = Bundle.main().pathForResource("SearchProduct", ofType: nil)
        let data = NSData(contentsOfFile: pathStr!)
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            array = (dict.object(forKey: "data")! as! NSDictionary).object(forKey: "hotquery") as? [String]
            if array?.count > 0 {
                hotSearchView = GHZSearchView(frame: CGRect(x: 10, y: 20, width: GHZScreenWidth - 20, height: 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array!) { (sender) -> () in
                    let str = sender.title(for: UIControlState())
                    tmpSelf!.writeHistorySearchToUserDefault(str: str!)
                    tmpSelf!.searchBar.text = sender.title(for: UIControlState())
                    tmpSelf!.loadProductsWithKeyword(keyWord: sender.title(for: UIControlState())!)
                }
                hotSearchView!.frame.size.height = hotSearchView!.searchHeight
                
                contentScrollView.addSubview(hotSearchView!)
            }
        }
    }
    
    private func loadHistorySearchButtonData() {
        if historySearchView != nil {
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        
        weak var weakSelf = self
        let array = UserDefaults.standard().object(forKey: GHZSearchViewControllerHistorySearchArray) as? [String]
        if array?.count > 0 {
            historySearchView = GHZSearchView(frame:CGRect(x: 10, y: hotSearchView!.frame.maxY + 20, width: GHZScreenWidth - 20, height: 0), searchTitleText: "历史记录", searchButtonTitleTexts: array!, searchButtonClickCallback: { (sender) -> () in
                weakSelf!.searchBar.text = sender.title(for: UIControlState())
                weakSelf!.loadProductsWithKeyword(keyWord: sender.title(for: UIControlState())!)
            })
            historySearchView!.frame.size.height = historySearchView!.searchHeight
            
            contentScrollView.addSubview(historySearchView!)
            updateCleanHistoryButton(hidden: false)
        }
    }
    
    private func buildCleanHistorySearchButton() {
        cleanHistoryButton.setTitle("清 空 历 史", for: UIControlState())
        cleanHistoryButton.setTitleColor(UIColor.customColorWithFloat(r: 163, g: 163, b: 163, a: 1.0), for: UIControlState())
        cleanHistoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cleanHistoryButton.backgroundColor = view.backgroundColor
        cleanHistoryButton.layer.cornerRadius = 5
        cleanHistoryButton.layer.borderColor = UIColor.customColorWithFloat(r: 200, g: 200, b: 200, a: 1.0).cgColor
        cleanHistoryButton.layer.borderWidth = 0.5
        cleanHistoryButton.isHidden = true
        cleanHistoryButton.addTarget(self, action: #selector(GHZSearchProductViewController.cleanSearchHistorySearch), for: UIControlEvents.touchUpInside)
        contentScrollView.addSubview(cleanHistoryButton)
    }
    
    private func updateCleanHistoryButton(hidden: Bool) {
        if historySearchView != nil {
            cleanHistoryButton.frame = CGRect(x: GHZScreenWidth * 0.1, y: (historySearchView?.frame.maxY)! + 20, width: GHZScreenWidth * 0.8, height: 40)
        }
        cleanHistoryButton.isHidden = hidden
    }
    
    private func buildsearchCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSize(width: 0, height: HomeCollectionViewCellMargin)
        
        searchCollectionView = GHZCustomCollectionView(frame: CGRect(x: 0, y: 0, width: GHZScreenWidth, height: GHZScreenHeight - 64), collectionViewLayout: layout)
        searchCollectionView!.delegate = self
        searchCollectionView!.dataSource = self
        searchCollectionView!.backgroundColor = GHZGlobalBackgroundColor
        searchCollectionView!.register(GHZHomeCollectionViewCell.self, forCellWithReuseIdentifier: "GHZHomeCollectionViewCell")
        searchCollectionView?.isHidden = true
        collectionHeadView = NOSearchProductView(frame: CGRect(x: 0, y: -80, width: GHZScreenWidth, height: 80))
        searchCollectionView?.addSubview(collectionHeadView!)
        searchCollectionView?.contentInset = UIEdgeInsetsMake(80, 0, 30, 0)
        searchCollectionView?.register(GHZHomeFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        view.addSubview(searchCollectionView!)
    }
    
    // MARK: - Private Method
    private func writeHistorySearchToUserDefault(str: String) {
        var historySearch = UserDefaults.standard().object(forKey: GHZSearchViewControllerHistorySearchArray) as? [String]
        for text in historySearch! {
            if text == str {
                return
            }
        }
        historySearch!.append(str)
        UserDefaults.standard().set(historySearch, forKey: GHZSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
    }
    
    // MARK: - Action
    func cleanSearchHistorySearch() {
        var historySearch = UserDefaults.standard().object(forKey: GHZSearchViewControllerHistorySearchArray) as? [String]
        historySearch?.removeAll()
        UserDefaults.standard().set(historySearch, forKey: GHZSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
        updateCleanHistoryButton(hidden: true)
    }
    
    func leftButtonClcik() {
        searchBar.endEditing(false)
    }
    
    // MARK: - Private Method
    func loadProductsWithKeyword(keyWord: String?) {
        if keyWord == nil || keyWord?.characters.count == 0 {
            return
        }
        
        SVProgressHUD.setBackgroundColor(UIColor.white())
        SVProgressHUD .show(withStatus: "正在全力加载")
        
        weak var weakSelf = self
        let time = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.after(when: time) { 
            GHZSearchProductModel.loadSearchData { (data, error) -> Void in
                if data?.data?.count > 0 {
                    weakSelf?.shops = data!.data!
                    weakSelf?.searchCollectionView?.isHidden = false
                    weakSelf?.yellowShopCar?.isHidden = false
                    weakSelf?.searchCollectionView?.reloadData()
                    weakSelf?.collectionHeadView?.setSearchProductLabelText(text: keyWord!)
                    weakSelf?.searchCollectionView?.setContentOffset(CGPoint(x: 0, y: -80), animated: false)
                    SVProgressHUD.dismiss()
                }
            }
        }
    }


}
extension GHZSearchProductViewController
: UISearchBarDelegate, UIScrollViewDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count > 0 {
            
            writeHistorySearchToUserDefault(str: searchBar.text!)
            
            loadProductsWithKeyword(keyWord: searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(false)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            searchCollectionView?.isHidden = true
            yellowShopCar?.isHidden = true
        }
    }
}


extension GHZSearchProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shops?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GHZHomeCollectionViewCell", for: indexPath) as! GHZHomeCollectionViewCell
        cell.shops = shops![indexPath.row]
        weak var tmpSelf = self
        cell.addButtonClick = ({ (imageView) -> () in
            tmpSelf?.addProductsToBigShopCarAnimation(imageView: imageView)
        })
        
        return cell
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemSize = CGSize(width: (GHZScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, height: 250)
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if shops?.count <= 0 || shops == nil {
            return CGSize( width: 0, height: 0)
        }
        
        return CGSize(width: GHZScreenWidth, height: 30)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize( width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath) as! GHZHomeFooterView
            
            footerView.setFooterTitle(text: "无更多商品", textColor: UIColor.customColorWithFloat(r: 50, g: 50, b: 50, a: 1.0))
            
            return footerView
            
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = GHZProductDetailViewController(shops: shops![indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
