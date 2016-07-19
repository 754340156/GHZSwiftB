//
//  GHZAddressData.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZAddressData: NSObject,GHZ_ExtensionProtocol {
    var code: Int = -1
    var msg: String?
    var data: [Address]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Address.self)"]
    }
    
    class func loadMyAdressData(completion:(data: GHZAddressData?, error: NSError?) -> Void) {
        let path = Bundle.main().pathForResource("MyAdress", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            let modelTool = GHZ_Extension.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: GHZAddressData.self) as? GHZAddressData
            completion(data: data, error: nil)
        }
    }
}


class Address: NSObject {
    
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
}
