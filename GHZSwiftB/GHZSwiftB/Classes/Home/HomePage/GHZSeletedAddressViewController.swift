//
//  GHZSeletedAddressViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZSeletedAddressViewController: GHZAnimationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if GHZUserInfo.sharedUserInfo.hasDefaultAdress() {
            let titleView = GHZAddressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            titleView.setTitle(title: (GHZUserInfo.sharedUserInfo.defaultAdress()?.address)!)
            titleView.frame = CGRect(x: 0, y: 0, width: titleView.addressTitleViewWidth, height: 30)
            navigationItem.titleView = titleView
            let tap = UITapGestureRecognizer(target: self, action: #selector(clickTitleView))
            navigationItem.titleView?.addGestureRecognizer(tap)
        }
    }
    private func setNavigation()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: UIColor.black(), image: #imageLiteral(resourceName: "icon_black_scancode"), highLightImage: UIImage(), target: self, action: #selector(clickScanCode), type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜索", titleColor: UIColor.black(), image: #imageLiteral(resourceName: "icon_search"), highLightImage: UIImage(), target: self, action: #selector(clickSearch), type: ItemButtonType.Right)
        let titleView = GHZAddressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        titleView.frame = CGRect(x: 0, y: 0, width: titleView.addressTitleViewWidth, height: 30)
        navigationItem.titleView = titleView
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTitleView))
        navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    //FIXME: 没写完
    func clickScanCode()  {
        let QRCodeVC = GHZQRCodeViewController()
        navigationController?.pushViewController(QRCodeVC, animated: true)
  
    }
    func clickSearch()  {
        let searchProductVC = GHZSearchProductViewController()
        navigationController?.pushViewController(searchProductVC, animated: false)
    }
    func clickTitleView()  {
        let myAddressVC = GHZMyAddressViewController()
        navigationController?.pushViewController(myAddressVC, animated: true)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
