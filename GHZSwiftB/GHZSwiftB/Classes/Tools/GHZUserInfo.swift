//
//  GHZUserInfo.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZUserInfo: NSObject {

    private static let instance = GHZUserInfo()
    
    private var allAddress: [Address]?
    
    class var sharedUserInfo: GHZUserInfo {
        return instance
    }
    
    func hasDefaultAdress() -> Bool {
        
        if allAddress != nil {
            return true
        } else {
            return false
        }
    }
    
    func setAllAdress(address: [Address]) {
        allAddress = address
    }
    
    func cleanAllAdress() {
        allAddress = nil
    }
    
    func defaultAdress() -> Address? {
        if allAddress == nil {
            weak var tmpSelf = self
            
            GHZAddressData.loadMyAdressData { (data, error) -> Void in
                if data?.data?.count > 0 {
                    tmpSelf!.allAddress = data!.data!
                } else {
                    tmpSelf?.allAddress?.removeAll()
                }
            }
            
            return allAddress?.count > 1 ? allAddress![0] : nil
        } else {
            return allAddress![0]
        }
    }
    
    func setDefaultAdress(address: Address) {
        if allAddress != nil {
            allAddress?.insert(address, at: 0)
        } else {
            allAddress = [Address]()
            allAddress?.append(address)
        }
    }
}
