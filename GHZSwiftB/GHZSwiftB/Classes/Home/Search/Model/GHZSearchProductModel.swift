//
//  GHZSearchProductModel.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZSearchProductModel: NSObject,GHZ_ExtensionProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Shops]?
    
    class func loadSearchData(completion:((data: GHZSearchProductModel?, error: NSError?) -> Void)) {
        let path = Bundle.main().pathForResource("促销", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            let modelTool = GHZ_Extension.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: GHZSearchProductModel.self) as? GHZSearchProductModel
            completion(data: data, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Shops.self)"]
    }
}
