//
//  GHZHomePageFreshHot.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomePageFreshHot: NSObject ,GHZ_ExtensionProtocol{
    var page :Int = -1
    var code :Int = -1
    var msg :String?
    var data : Array<Shops>?
    
    class func loadHomePageFreshHotData(completion:(data: GHZHomePageFreshHot,error:NSError?) -> Void) {
        let path = Bundle.main().pathForResource("首页焦点按钮", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil
        {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            let modelTool = GHZ_Extension.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: GHZHomePageFreshHot.self) as? GHZHomePageFreshHot
            completion(data: data!, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Shops.self)"]
    }
    
    
}
class Shops: NSObject {
    //*************************商品模型默认属性**********************************
    /// 商品ID
    var id: String?
    /// 商品姓名
    var name: String?
    var brand_id: String?
    /// 超市价格
    var market_price: String?
    var cid: String?
    var category_id: String?
    /// 当前价格
    var partner_price: String?
    var brand_name: String?
    var pre_img: String?
    
    var pre_imgs: String?
    /// 参数
    var specifics: String?
    var product_id: String?
    var dealer_id: String?
    /// 当前价格
    var price: String?
    /// 库存
    var number: Int = -1
    /// 买一赠一
    var pm_desc: String?
    var had_pm: Int = -1
    /// urlStr
    var img: String?
    /// 是不是精选 0 : 不是, 1 : 是
    var is_xf: Int = 0
    
    //*************************商品模型辅助属性**********************************
    // 记录用户对商品添加次数
    var userBuyNumber: Int = 0
}
