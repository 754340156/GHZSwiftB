//
//  GHZProductTableViewCell.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZProductTableViewCell: UITableViewCell {

    static private let identifier = "GHZProductTableViewCell"
    
    //MARK: - 初始化子控件
    private lazy var shopsImageView: UIImageView = {
        let shopsImageView = UIImageView()
        return shopsImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = HomeCollectionTextFont
        nameLabel.textColor = UIColor.black()
        return nameLabel
    }()
    
    private lazy var fineImageView: UIImageView = {
        let fineImageView = UIImageView()
        fineImageView.image = #imageLiteral(resourceName: "jingxuan.png")
        return fineImageView
    }()
    
    private lazy var giveImageView: UIImageView = {
        let giveImageView = UIImageView()
        giveImageView.image = #imageLiteral(resourceName: "buyOne.png")
        return giveImageView
    }()
    
    private lazy var specificsLabel: UILabel = {
        let specificsLabel = UILabel()
        specificsLabel.textColor = UIColor.customColorWithFloat(r: 100, g: 100, b: 100, a: 1.0)
        specificsLabel.font = UIFont.systemFont(ofSize: 12)
        specificsLabel.textAlignment = .left
        return specificsLabel
    }()
    
    private lazy var buyView: GHZBuyView = {
        let buyView = GHZBuyView()
        return buyView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.customColorWithFloat(r: 100, g: 100, b: 100, a: 1.0)
        lineView.alpha = 0.05
        return lineView
    }()
    
    private var discountPriceView: GHZDiscountPriceView?
    
    var addProductClick:((imageView: UIImageView) -> ())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white()
        
        addSubview(shopsImageView)
        addSubview(lineView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        weak var weakSelf = self
        buyView.clickAddShopCart = {
            if weakSelf!.addProductClick != nil {
                weakSelf!.addProductClick!(imageView: weakSelf!.shopsImageView)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(_ tableView: UITableView) -> GHZProductTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GHZProductTableViewCell
        
        if cell == nil {
            cell = GHZProductTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    // MARK: - 模型set方法
    var shops: Shops? {
        didSet {
            shopsImageView.sd_setImage(with: URL(string: shops!.img!), placeholderImage:#imageLiteral(resourceName: "v2_placeholder_square"))
            nameLabel.text = shops?.name
            if shops!.pm_desc == "买一赠一" {
                giveImageView.isHidden = false
            } else {
                giveImageView.isHidden = true
            }
            
            if shops!.is_xf == 1 {
                fineImageView.isHidden = false
            } else {
                fineImageView.isHidden = true
            }
            
            if discountPriceView != nil {
                discountPriceView!.removeFromSuperview()
            }
            discountPriceView = GHZDiscountPriceView(price: shops?.price, marketPrice: shops?.market_price)
            addSubview(discountPriceView!)
            
            specificsLabel.text = shops?.specifics
            buyView.shops = shops
        }
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shopsImageView.frame = CGRect(x: 0, y: 0, width: height, height: height)
        fineImageView.frame = CGRect(x: shopsImageView.frame.maxX, y: HotViewMargin, width: 30, height: 16)
        
        if fineImageView.isHidden {
            nameLabel.frame = CGRect(x: shopsImageView.frame.maxX + 3, y: HotViewMargin - 2, width: width - shopsImageView.frame.maxX, height: 20)
        } else {
            nameLabel.frame = CGRect(x: fineImageView.frame.maxX + 3, y: HotViewMargin - 2, width: width - fineImageView.frame.maxX, height: 20)
        }
        
        giveImageView.frame = CGRect(x: shopsImageView.frame.maxX, y: nameLabel.frame.maxY, width: 35, height: 15)
        
        specificsLabel.frame = CGRect(x: shopsImageView.frame.maxX, y: giveImageView.frame.maxY, width: width, height: 20)
        discountPriceView?.frame = CGRect(x: shopsImageView.frame.maxX, y: specificsLabel.frame.maxY, width: 60, height: height - specificsLabel.frame.maxY)
        lineView.frame = CGRect(x: HotViewMargin, y: height - 1, width: width - HotViewMargin, height: 1)
        buyView.frame = CGRect(x: width - 85, y: height - 30, width: 80, height: 25)
    }

}
class GHZCategoryCell: UITableViewCell {
    private static let identifier = "GHZCategoryCell"
    
    // MARK: Lazy Property
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = GHZTextGreyColol
        nameLabel.highlightedTextColor = UIColor.black()
        nameLabel.backgroundColor = UIColor.clear()
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        return nameLabel
    }()
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = #imageLiteral(resourceName: "llll")
        backImageView.highlightedImage = #imageLiteral(resourceName: "kkkkkkk")
        return backImageView
    }()
    
    private lazy var yellowView: UIView = {
        let yellowView = UIView()
        yellowView.backgroundColor = GHZNavigationYellowColor
        
        return yellowView
    }()
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.customColorWithFloat(r: 225, g: 225, b: 225, a: 1.0)
        return lineView
    }()
    // MARK: 模型setter方法
    var categorie: Categorie? {
        didSet {
            nameLabel.text = categorie?.name
        }
    }
    
    // MARK: Method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backImageView)
        addSubview(lineView)
        addSubview(yellowView)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(_ tableView: UITableView) -> GHZCategoryCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GHZCategoryCell
        if cell == nil {
            cell = GHZCategoryCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLabel.isHighlighted = selected
        backImageView.isHighlighted = selected
        yellowView.isHidden = !selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = bounds
        backImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        yellowView.frame = CGRect(x: 0, y: height * 0.1, width: 5, height: height * 0.8)
        lineView.frame = CGRect(x: 0, y: height - 1, width: width, height: 1)
    }
}
