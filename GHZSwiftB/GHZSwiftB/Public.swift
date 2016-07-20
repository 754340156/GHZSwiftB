//
//  Public.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

// MRRK: 基本属性
public let GHZScreenBounds: CGRect = UIScreen.main().bounds
public let GHZScreenWidth: CGFloat = UIScreen.main().bounds.size.width
public let GHZScreenHeight: CGFloat = UIScreen.main().bounds.size.height
public let GHZNavigationHeight: CGFloat = 64
public let ShopCarRedDotAnimationDuration: TimeInterval = 0.2

// MARK: - 常用颜色
public let GHZGlobalBackgroundColor = UIColor.customColorWithFloat(r: 239, g: 239, b: 239, a: 1.0)
public let GHZNavigationYellowColor = UIColor.customColorWithFloat(r: 253, g: 212, b: 49, a: 1.0)
public let GHZTextGreyColol = UIColor.customColorWithFloat(r: 130, g: 130, b: 130, a: 1.0)
public let GHZTextBlackColor = UIColor.customColorWithFloat(r: 50, g: 50, b: 50, a: 1.0)
public let GHZWebViewBackColor = UIColor.customColorWithFloat(r: 230, g: 230, b: 230, a: 1.0)
public let GHZNavBarWhiteBackColor = UIColor.customColorWithFloat(r: 249, g: 250, b: 253, a: 1.0)


// MARK: - HomePage 属性
public let HotViewMargin: CGFloat = 10
public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFont(ofSize: 14)
public let HomeCollectionCellAnimationDuration: TimeInterval = 1.0

// MARK: 通知
/// 首页headView高度改变
public let HomeHeadViewHeightDidChange : String = "HomeHeadViewHeightDidChange"
// 商品不足
public let GHZHomeShopsInventory : String = "GHZHomeShopsInventory"
// 广告通知
public let ADImageLoadSecussed : String = "ADImageLoadSecussed"
public let ADImageLoadFail: String = "ADImageLoadFail"
//购物车商品数量改变
public let GHZShopCartProductNumberDidChange:String = "GHZShopCartProductNumberDidChange"
//价格发生改变
public let GHZShopCartProductPriceDidChange:String = "GHZShopCartProductPriceDidChange"
//购物车移除了
public let GHZShopCartDidRemoveProduct:String = "GHZShopCartDidRemoveProduct"

public let GHZSearchViewControllerDeinit:String =  "GHZSearchViewControllerDeinit"



public let GHZSearchViewControllerHistorySearchArray = "GHZSearchViewControllerHistorySearchArray"
























