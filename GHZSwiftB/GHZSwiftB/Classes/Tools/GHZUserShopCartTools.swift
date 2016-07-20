//
//  GHZUserShopCartTools.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZUserShopCartTools: NSObject {
    private static let instance = GHZUserShopCartTools()
    
    private var supermarketProducts = [Shops]()
    
    class var sharedUserShopCar: GHZUserShopCartTools {
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return GHZShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return supermarketProducts.count == 0
    }
    
    func addSupermarkProductToShopCart(shops: Shops) {
        for everyShops in supermarketProducts {
            if everyShops.id == shops.id {
                return
            }
        }
        
        supermarketProducts.append(shops)
    }
    
    func getShopCartProducts() -> [Shops] {
        return supermarketProducts
    }
    
    func getShopCartProductsClassifNumber() -> Int {
        return supermarketProducts.count
    }
    
    func removeSupermarketProduct(shops: Shops) {
        for i in 0..<supermarketProducts.count {
            let everyShops = supermarketProducts[i]
            if everyShops.id == shops.id {
                supermarketProducts.remove(at: i)
                NotificationCenter.default().post(name: NSNotification.Name(rawValue: GHZShopCartDidRemoveProduct), object: nil)
                return
            }
        }
    }
    func getAllProductsPrice() -> String {
        var allPrice: Double = 0
        for goods in supermarketProducts {
            allPrice = allPrice + Double(goods.partner_price!)! * Double(goods.userBuyNumber)
        }
        
        return "\(allPrice)".cleanDecimalPointZear()
    }
}
