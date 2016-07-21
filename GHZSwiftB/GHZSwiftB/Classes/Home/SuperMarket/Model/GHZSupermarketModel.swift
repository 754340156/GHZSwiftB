//
//  GHZSupermarketModel.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZSupermarketModel: NSObject ,GHZ_ExtensionProtocol{

    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: GHZSupermarketResouce?
    
    class func loadSupermarketData(_ completion:(data: GHZSupermarketModel?, error: NSError?) -> Void) {
        let path = Bundle.main().pathForResource("supermarket", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
            let modelTool = GHZ_Extension.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: GHZSupermarketModel.self) as? GHZSupermarketModel
            completion(data: data, error: nil)
        }
    }
    
    class func searchCategoryMatchProducts(_ supermarketResouce: GHZSupermarketResouce) -> [[Shops]]? {
        var arr = [[Shops]]()
        
        let products = supermarketResouce.products
        for cate in supermarketResouce.categories! {
            let ShopsArr = products!.value(forKey: cate.id!) as! [Shops]
            arr.append(ShopsArr)
        }
        return arr
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(GHZSupermarketResouce.self)"]
    }
}

class GHZSupermarketResouce: NSObject {
    var categories: [Categorie]?
    var products: Products?
    var trackid: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["categories" : "\(Categorie.self)", "products" : "\(Products.self)"]
    }
}

class Categorie: NSObject {
    var id: String?
    var name: String?
    var sort: String?
}

class Products: NSObject, GHZ_ExtensionProtocol {
    var a82: [Shops]?
    var a96: [Shops]?
    var a99: [Shops]?
    var a106: [Shops]?
    var a134: [Shops]?
    var a135: [Shops]?
    var a136: [Shops]?
    var a137: [Shops]?
    var a141: [Shops]?
    var a143: [Shops]?
    var a147: [Shops]?
    var a151: [Shops]?
    var a152: [Shops]?
    var a158: [Shops]?
    
    static func customClassMapping() -> [String : String]? {
        return ["a82" : "\(Shops.self)", "a96" : "\(Shops.self)", "a99" : "\(Shops.self)", "a106" : "\(Shops.self)", "a134" : "\(Shops.self)", "a135" : "\(Shops.self)", "a136" : "\(Shops.self)", "a141" : "\(Shops.self)", "a143" : "\(Shops.self)", "a147" : "\(Shops.self)", "a151" : "\(Shops.self)", "a152" : "\(Shops.self)", "a158" : "\(Shops.self)", "a137" : "\(Shops.self)"]
    }
}
