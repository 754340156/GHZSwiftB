//
//  GHZHomePageController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomePageController: GHZAnimationViewController
{
    
    private var flag:Int = -1
    private var headerView :GHZHomeHeaderView!
    private var collectionView:GHZCustomCollectionView!
    private var isAnimation:Bool = true
    private var headData:GHZHeaderData?
    private var freshHotData: GHZHomePageFreshHot?
    private var lastContentOffsetY:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        setHeaderView()
        setNotificationCenter()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
        if collectionView != nil {
            collectionView.reloadData()
        }
        
        NotificationCenter.default().post(name: "GHZSearchViewControllerDeinit" as NSNotification.Name, object: nil)
    }
    deinit {
        NotificationCenter.default().removeObserver(self)
    }
    func setCollection() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        flowLayout.headerReferenceSize = CGSize(width: 0, height: HomeCollectionViewCellMargin)
        
        view.addSubview(self.collectionView)
        collectionView.register(GHZHomeHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(GHZHomeFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView")
        collectionView.register(GHZHomeCollectionViewCell.self, forCellWithReuseIdentifier: "GHZHomeCollectionViewCell")
    }
    func setHeaderView()  {
        weak var weakSelf = self
        headerView = GHZHomeHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), clickHotView: { (index, headerView) in
            if weakSelf?.headData?.data?.icons?.count > 0
            {
                let webVC = GHZHomeWebViewController(navigationTitle: (weakSelf?.headData?.data?.icons?[index].name)!, urlStr: (weakSelf?.headData?.data?.icons?[index].customURL)!)
                weakSelf?.navigationController?.pushViewController(webVC, animated: true)
            }
            
            }, clickCycleScrollView: { (index, headerView) in
                if weakSelf?.headData?.data?.focus?.count > 0
                {
                    let path = Bundle.main().pathForResource("FocusURL", ofType: "plist")
                    let array = NSArray.init(contentsOfFile: path!)
                    let webViewVC = GHZHomeWebViewController(navigationTitle: (weakSelf?.headData?.data?.focus![index].name)!, urlStr: array?[index] as! String)
                    weakSelf?.navigationController?.pushViewController(webViewVC, animated: true)
                }
                
        })
        
        //处理数据
        GHZHeaderData.loadHomeHeadData { (data, error) in
            if error != nil{
                self.headerView.headerData = data!
                self.headData = data
                self.collectionView.reloadData()
            }
        }
        //处理数据
        GHZHomePageFreshHot.loadHomePageFreshHotData { (data, error) in
            if error != nil
            {
                weakSelf?.freshHotData = data
                weakSelf?.collectionView.reloadData()
                weakSelf?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
            }
        }
    }
    func setNotificationCenter(){
        NotificationCenter.default().addObserver(self, selector: Selector(("HomeHeadViewHeightDidChange")), name: HomeHeadViewHeightDidChange, object: nil)
        NotificationCenter.default().addObserver(self, selector: Selector(("GHZHomeShopsInventory")), name: GHZHomeShopsInventory, object: nil)
        NotificationCenter.default().addObserver(self, selector: Selector(("GHZShopCartProductNumberDidChange")), name: GHZShopCartProductNumberDidChange, object: nil)
    }
    //通知方法
    //头视图高度发生改变
//    func HomeHeadViewHeightDidChange(noti:Notification)
//    {
//        
//    }
    //商品不足
//    func GHZHomeShopsInventory(noti:Notification)
//    {
//        
//    }
    //商品数量发生改变
//    func GHZShopCartProductNumberDidChange(noti:Notification) {
//        
//    }
    //TODO: 刷新没写
    
}

extension GHZHomePageController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if headData?.data?.activities?.count <= 0 || freshHotData?.data?.count <= 0 {
            return 0
        }
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if headData?.data?.activities?.count <= 0 || freshHotData?.data?.count <= 0 {
            return 0
        }
        if section  == 0 {
            return headData?.data?.activities?.count ?? 0
        }else if section == 1
        {
            return freshHotData?.data?.count ?? 0
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GHZHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GHZHomeCollectionViewCell", for: indexPath) as! GHZHomeCollectionViewCell
        cell.backgroundColor = UIColor.cyan()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize :CGSize = CGSize(width: 0, height: 0)
        if indexPath.section == 0 {
            itemSize = CGSize(width: GHZScreenWidth - HomeCollectionViewCellMargin * 2, height: 140)
            
        }else
        {
            itemSize = CGSize(width: (GHZScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, height: 250)
        }
        return itemSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: GHZScreenWidth, height: HomeCollectionViewCellMargin)
        }else if section == 0
        {
            return CGSize(width: GHZScreenWidth, height: HomeCollectionViewCellMargin * 2)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: GHZScreenWidth, height: HomeCollectionViewCellMargin)
        }else if section == 1
        {
            return CGSize(width: GHZScreenWidth, height: HomeCollectionViewCellMargin * 5)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
            return headerView
            
        }
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath)
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter{
            footerView.
        }else
        {
            footerView.
        }
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("ClickMoreShop")))
        footerView.addGestureRecognizer(tap)
        return footerView
        
    }
    //点击更多商品按钮
    private func ClickMoreShop(tap:UITapGestureRecognizer)
    {
        if tap.view?.tag == 100 {
            let tabbarController = UIApplication.shared().keyWindow?.rootViewController as! GHZTabBarViewController
            tabbarController.setSelectIndex(from: 0, to: 1)
        }
    }
    
    //加动画
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1) {
            return
        }
        if  isAnimation {
            startAnimation(view: cell, offset: 80, duration: 1.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if indexPath.section == 1 && headData != nil && freshHotData != nil && isAnimation {
            startAnimation(view: view, offset: 60, duration: 0.8)
        }
    }
    //动画
    private func startAnimation(view:UIView,offset:CGFloat,duration:TimeInterval)
    {
        
    }
 
    //ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animationLayerArray?.count  > 0{
            let transitionLayer = animationLayerArray?[0]
            transitionLayer?.isHidden = true
        }
        if scrollView.contentOffset.y <= scrollView.contentSize.height {
            isAnimation =  lastContentOffsetY < scrollView.contentOffset.y
            lastContentOffsetY = scrollView.contentOffset.y
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let webVC = GHZHomeWebViewController(navigationTitle: (headData?.data?.activities?[indexPath.row].name)!, urlStr: (headData?.data?.activities?[indexPath.row].customURL)!)
            navigationController?.pushViewController(webVC, animated: true)
        }else
        {
            let productVC = GHZ
            
        }
    }
    
}

