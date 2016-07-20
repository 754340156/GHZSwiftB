//
//  UIDevice+Extension.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
extension UIDevice
{
    class func currentDeviceScreenMeasurement() -> CGFloat {
        var deviceScree: CGFloat = 3.5
        if ((568 == GHZScreenHeight && 320 == GHZScreenWidth) || (1136 == GHZScreenHeight && 640 == GHZScreenWidth)) {
            deviceScree = 4.0;
        } else if ((667 == GHZScreenHeight && 375 == GHZScreenWidth) || (1334 == GHZScreenHeight && 750 == GHZScreenWidth)) {
            deviceScree = 4.7;
        } else if ((736 == GHZScreenHeight && 414 == GHZScreenWidth) || (2208 == GHZScreenHeight && 1242 == GHZScreenWidth)) {
            deviceScree = 5.5;
        }
        
        return deviceScree
    }
}
