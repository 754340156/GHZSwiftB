//
//  GHZSearchView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZSearchView: UIView {

    private let searchLabel = UILabel()
    private var lastX: CGFloat = 0
    private var lastY: CGFloat = 35
    private var searchButtonClickCallback:((sender: UIButton) -> ())?
    var searchHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width - 30, height: 35)
        searchLabel.font = UIFont.systemFont(ofSize: 15)
        searchLabel.textColor = UIColor.customColorWithFloat(r: 140, g: 140, b: 140, a: 1.0)
        addSubview(searchLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, searchTitleText: String, searchButtonTitleTexts: [String], searchButtonClickCallback:((sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        searchLabel.text = searchTitleText
        
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        for i in 0..<searchButtonTitleTexts.count {
            let btn = UIButton()
            btn.setTitle(searchButtonTitleTexts[i], for: UIControlState())
            btn.setTitleColor(UIColor.black(), for: UIControlState())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.white()
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.customColorWithFloat(r: 200, g: 200, b: 200, a: 1.0).cgColor
            btn.addTarget(self, action: Selector(("searchButtonClick:")), for: UIControlEvents.touchUpInside)
            btnW = btn.titleLabel!.width + addW
            
            if frame.width - lastX > btnW {
                btn.frame = CGRect(x: lastX, y: lastY, width: btnW, height: btnH)
            } else {
                btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: btnW, height: btnH)
            }
            
            lastX = btn.frame.maxX + marginX
            lastY = btn.y
            searchHeight = btn.frame.maxY
            addSubview(btn)
        }
        
        self.searchButtonClickCallback = searchButtonClickCallback
    }
    
    func searchButtonClick(sender: UIButton) {
        if searchButtonClickCallback != nil {
            searchButtonClickCallback!(sender: sender)
        }
    }
}
class  NOSearchProductView: UIView {
    private let topBackView = UIView()
    private let searchLabel = UILabel()
    private let markImageView = UIImageView()
    private let productLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear()
        topBackView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        topBackView.backgroundColor = UIColor.customColorWithFloat(r: 249, g: 242, b: 216, a: 1.0)
        addSubview(topBackView)
        
        markImageView.contentMode = UIViewContentMode.scaleAspectFill
        markImageView.image = UIImage(named: "icon_exclamationmark")
        markImageView.frame = CGRect( x: 15, y: 23 / 2, width: 27, height: 27)
        addSubview(markImageView)
        
        productLabel.textColor = UIColor.customColorWithFloat(r: 148, g: 107, b: 81, a: 1.0)
        productLabel.font = UIFont.systemFont(ofSize: 14)
        productLabel.frame = CGRect(x: markImageView.frame.maxX + 10, y: 10, width: width * 0.7, height: 15)
        productLabel.text = "暂时没搜到〝星巴克〞相关商品"
        addSubview(productLabel)
        
        searchLabel.textColor = UIColor.customColorWithFloat(r: 252, g: 185, b: 47, a: 1.0)
        searchLabel.font = UIFont.systemFont(ofSize: 12)
        searchLabel.text = "换其他关键词试试看,"
        searchLabel.frame = CGRect( x: productLabel.x, y: productLabel.frame.maxY + 5, width: width * 0.7, height: 15)
        addSubview(searchLabel)
        
        titleLabel.textColor = UIColor.gray()
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.text = "大家都在买"
        titleLabel.frame = CGRect(x: 10, y: 60, width: 200, height: 15)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSearchProductLabelText(text: String) {
        productLabel.text = "暂时没搜到" + "〝" + text + "〞" + "相关商品"
    }
}
