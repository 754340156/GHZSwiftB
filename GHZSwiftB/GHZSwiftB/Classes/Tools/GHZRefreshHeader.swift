//
//  GHZRefreshHeader.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
import MJRefresh
class GHZRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        stateLabel?.isHidden = false
        lastUpdatedTimeLabel?.isHidden = true
        
        setImages([#imageLiteral(resourceName: "v2_pullRefresh1")], for: MJRefreshState.idle)
        setImages([#imageLiteral(resourceName: "v2_pullRefresh2")], for: MJRefreshState.pulling)
        setImages([#imageLiteral(resourceName: "v2_pullRefresh1"),#imageLiteral(resourceName: "v2_pullRefresh2")], for: MJRefreshState.refreshing)
        setTitle("下拉刷新", for: .idle)
        setTitle("松手开始刷新", for: .pulling)
        setTitle("正在刷新", for: .refreshing)
    }
}
