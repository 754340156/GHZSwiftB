//
//  GHZHomeHeaderView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZHomeHeaderView: UIView {
    
    private var scrollView: GHZCycleScrollView?
    private var hotView: GHZHomeHotView?
    var clickHotView:((index:Int,headerView:GHZHomeHeaderView) -> Void)?
    var clickCycleScrollView:((index:Int,headerView:GHZHomeHeaderView) -> Void)?
    var headerViewHeight:CGFloat = 0
        {
        willSet{
            NotificationCenter.default().post(name:  NSNotification.Name(rawValue: HomeHeadViewHeightDidChange), object: newValue)
            frame = CGRect(x: 0, y: -newValue, width: GHZScreenWidth, height: newValue)
        }
    }
    //模型赋值
    var headerData:GHZHeaderData?
    {
        didSet{
            scrollView?.headData = headerData!
            hotView?.headerData = headerData?.data
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setScrollView()
        setHotView()
    }
    convenience init(frame: CGRect , clickHotView:(index:Int,headerView:GHZHomeHeaderView) -> Void , clickCycleScrollView:(index:Int,headerView:GHZHomeHeaderView) -> Void) {
        self.init(frame:frame)
        self.clickCycleScrollView = clickCycleScrollView
        self.clickHotView = clickHotView
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScrollView() {
        scrollView = GHZCycleScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholder: #imageLiteral(resourceName: "v2_placeholder_full_size"), focusImageViewClick: { (index) in
            if self.clickCycleScrollView != nil
            {
                self.clickCycleScrollView!(index: index, headerView: self)
            }
        })
    }
    private func setHotView()
    {
        hotView = GHZHomeHotView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), clickIcon: { (index) in
            if self.clickHotView != nil
            {
                self.clickHotView!(index: index, headerView: self)
            }
        })
    }
    
    
}
