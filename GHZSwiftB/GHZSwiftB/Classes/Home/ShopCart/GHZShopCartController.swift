//
//  GHZShopCartController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZShopCartController: GHZBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }
    
    func setNavigationItem()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GHZShopCartController.action))
    }
    func action()
    {
        self.dismiss(animated: true, completion: nil)
    }
    


}
