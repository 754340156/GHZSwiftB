//
//  String+Extension.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import Foundation

extension String
{
    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {
        
        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSMakeRange(offset, 1))
            if s.isEqual(to: "0") || s.isEqual(to: ".") {
                offset -= 1
            } else {
                break
            }
        }
        return newStr.substring(to: offset + 1)
    }
}
