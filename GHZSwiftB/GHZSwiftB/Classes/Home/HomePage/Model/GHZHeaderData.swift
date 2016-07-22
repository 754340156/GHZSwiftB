//
//  GHZHeaderData.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHeaderData: NSObject {
    var msg: String?
    var reqid: String?
    var data: HeadData?
    
    class func loadHomeHeadData(completion:(data: GHZHeaderData?, error: NSError?) -> Void) {
        let path = Bundle.main().pathForResource("首页焦点按钮", ofType: nil)
        let cudata = NSData(contentsOfFile: path!)
        if cudata != nil {
             let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: cudata! as Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            print(dict)
            let modelTool = GHZ_Extension.sharedManager
            
//            let data = modelTool.objectWithDictionary(dict: dict, cls: GHZHeaderData.self) as? GHZHeaderData
            let data = GHZHeaderData.mj_setKeyValues(dict)!
            completion(data: , error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(HeadData.self)"]
    }

}

class HeadData: NSObject, GHZ_ExtensionProtocol {
    var focus: Array<Activities>?
    var icons: Array<Activities>?
    var activities: Array<Activities>?
    
    static func customClassMapping() -> [String : String]? {
        return ["focus" : "\(Activities.self)", "icons" : "\(Activities.self)", "activities" : "\(Activities.self)"]
    }
}
class Activities: NSObject {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}
