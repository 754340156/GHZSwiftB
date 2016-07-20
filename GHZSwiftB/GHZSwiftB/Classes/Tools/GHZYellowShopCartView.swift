//
//  GHZYellowShopCartView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZYellowShopCartView: UIView {
    private var shopViewClick:(() -> ())?
    private let yellowImageView = UIImageView()
    private let redDot = GHZShopCarRedDotView.sharedRedDotView
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 61, height: 61))
        clipsToBounds = false
        
        yellowImageView.image = #imageLiteral(resourceName: "v2_shopNoBorder")
        yellowImageView.frame = CGRect(x: 0, y: 0, width: 61, height: 61)
        addSubview(yellowImageView)
        
        let shopCarImageView = UIImageView(image: #imageLiteral(resourceName: "v2_whiteShopBig"))
        shopCarImageView.frame =  CGRect(x: 8, y: 8, width: 45, height: 45)
        addSubview(shopCarImageView)
        
        redDot.frame = CGRect(x: frame.size.width - 20, y: 0, width: 20, height: 20)
        addSubview(redDot)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, shopViewClick:(() -> ())) {
        self.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GHZYellowShopCartView.shopViewShowShopCar))
        addGestureRecognizer(tap)
        
        self.shopViewClick = shopViewClick
    }
    func shopViewShowShopCar() {
        if shopViewClick != nil {
            shopViewClick!()
        }
    }


}
