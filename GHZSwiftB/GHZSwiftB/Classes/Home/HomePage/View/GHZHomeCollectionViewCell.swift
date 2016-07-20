//
//  GHZHomeCollectionViewCell.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit


enum GHZHomeCollcetionCellType: Int
{
    case Horizontal = 0
    case Vertical = 1
}
class GHZHomeCollectionViewCell: UICollectionViewCell {

    var addButtonClick:((imageView: UIImageView) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
        shopsImageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        nameLabel.frame = CGRect (x: 5, y: width, width: width - 15, height: 20)
        fineImageView.frame = CGRect(x: 5, y: nameLabel.frame.maxX, width: 30, height: 15)
        giveImageView.frame = CGRect(x: fineImageView.frame.maxX + 3, y: fineImageView.y, width: 35, height: 15)
        specificsLabel.frame = CGRect (x: nameLabel.x, y: fineImageView.frame.maxY, width: width, height: 20)
        discountPriceView?.frame = CGRect (x: nameLabel.x, y: specificsLabel.frame.maxY, width: 60, height: height - specificsLabel.frame.maxY)
        buyView.frame = CGRect (x: width - 85, y: height - 80, width: 80, height: 25)
    }
    //初始化控件
    private lazy var backImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var shopsImageView:UIImageView = {
        let shopsImageView = UIImageView()
        shopsImageView.contentMode = UIViewContentMode.scaleAspectFit
        return shopsImageView
    }()
    private lazy var nameLabel :UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = UIColor.black()
        return nameLabel
    }()
    //精选图片
    private lazy var fineImageView :UIImageView = {
        let fineImageView = UIImageView()
        fineImageView.image = #imageLiteral(resourceName: "jingxuan.png")
        return fineImageView
    }()
    //买一送一
    private lazy var giveImageView:UIImageView = {
        let giveImageView = UIImageView()
        giveImageView.image = #imageLiteral(resourceName: "buyOne.png")
       return giveImageView
    }()
    private lazy var specificsLabel:UILabel = {
       let specificsLabel = UILabel()
        specificsLabel.textColor = UIColor.customColorWithFloat(r: 100, g: 100, b: 100, a: 1.0)
        specificsLabel.font = UIFont.systemFont(ofSize: 12)
        return specificsLabel
    }()
    private var discountPriceView: GHZDiscountPriceView?
    private lazy var buyView:GHZBuyView = {
        let buyView = GHZBuyView()
        return buyView
    }()
    private var type: GHZHomeCollcetionCellType? {
        didSet {
            backImageView.isHidden = !(type == GHZHomeCollcetionCellType.Horizontal)
            shopsImageView.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            nameLabel.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            fineImageView.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            giveImageView.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            specificsLabel.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            discountPriceView?.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
            buyView.isHidden = (type == GHZHomeCollcetionCellType.Horizontal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white()
        addSubview(backImageView)
        addSubview(shopsImageView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        weak var weakSelf = self
        buyView.clickAddShopCart = {()
            if weakSelf?.addButtonClick != nil {
                weakSelf!.addButtonClick!(imageView:weakSelf!.shopsImageView)
            }
        }
    }
    
    // MARK: - 模型set方法
    var activities: Activities? {
        didSet {
            self.type = .Horizontal
            backImageView.sd_setImage(with: URL(string: (activities?.img)!), placeholderImage: #imageLiteral(resourceName: "v2_placeholder_full_size"))

        }
    }
    
    var shops: Shops? {
        didSet {
            self.type = .Vertical
            shopsImageView.sd_setImage(with: URL(string: (shops?.img)!), placeholderImage: #imageLiteral(resourceName: "v2_placeholder_square"))
            nameLabel.text = shops?.name
            if shops!.pm_desc == "买一赠一" {
                giveImageView.isHidden = false
            } else {
                
                giveImageView.isHidden = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class GHZBuyView: UIView {
    var clickAddShopCart :(()->())?
    var isShopEmpty:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addShopsButton)
        addSubview(deleteShopsButton)
        addSubview(buyCountLabel)
        addSubview(supplementLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addShopsButton.frame = CGRect(x: width - height - 2, y: 0, width: height, height: height)
        deleteShopsButton.frame = CGRect(x: buyCountLabel.frame.minX - height, y: 0, width: height, height: height)
        buyCountLabel.frame = CGRect(x: addShopsButton.frame.minX - 25, y: 0, width: 25, height: height)
        supplementLabel.frame = CGRect(x: deleteShopsButton.frame.minX, y: 0, width: 2 * height + 25, height: height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //addShop
    private lazy var addShopsButton: UIButton = {
       let button = UIButton(type: UIButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "v2_increase"), for: UIControlState())
        button.addTarget(self, action: #selector(addShopsAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    //deleteShop
    private lazy var deleteShopsButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "v2_reduce"), for: UIControlState())
        button.addTarget(self, action: #selector(deleteShopsAction) , for: UIControlEvents.touchUpInside)
        return button
    }()
    //加入购物车的数量
    private lazy var buyCountLabel:UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "0"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black()
        return label
    }()
    // 库存不足
    private lazy var supplementLabel: UILabel = {
        let label = UILabel()
        label.text = "库存不足"
        label.isHidden = true
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.red()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private var buyNumber:Int = 0
        {
        willSet{
            if newValue > 0 {
                deleteShopsButton.isHidden = false
                buyCountLabel.text = String(newValue)
            }else
            {
                deleteShopsButton.isHidden = true
                buyCountLabel.text = String(newValue)
                buyCountLabel.isHidden = false
            }
        }
    }
    //转模型
    var shops:Shops?{
        didSet
        {
            buyNumber = (shops?.userBuyNumber)!
            if shops?.number <= 0{
                //库存不足
                showSupplementLabel()
            }else
            {
                //库存充足
                hideSupplementLabel()
            }
            if  buyNumber == 0 {
                deleteShopsButton.isHidden = true && !isShopEmpty
                buyCountLabel.isHidden = true && !isShopEmpty
            }else
            {
                deleteShopsButton.isHidden = false
                buyCountLabel.isHidden = false
            }
        }
    }
    //库存不足
    private func showSupplementLabel()
    {
        supplementLabel.isHidden = false
        addShopsButton.isHidden = true
        deleteShopsButton.isHidden = true
        buyCountLabel.isHidden = true
    }
    //库存充足
    private func hideSupplementLabel()
    {
        supplementLabel.isHidden = true
        addShopsButton.isHidden = false
        deleteShopsButton.isHidden = false
        buyCountLabel.isHidden = false
    }
    //按钮事件
    @objc private func addShopsAction()
    {
        if buyNumber >= shops?.number {
            NotificationCenter.default().post(name: NSNotification.Name(rawValue: GHZHomeShopsInventory), object: shops?.name)
            return
        }
        
        deleteShopsButton.isHidden = false
        buyNumber += 1
        shops?.userBuyNumber = buyNumber
        buyCountLabel.text = "\(buyNumber)"
        buyCountLabel.isHidden = false
        
        if clickAddShopCart != nil {
            clickAddShopCart!()
        }
        
        GHZShopCarRedDotView.sharedRedDotView.addProductToRedDotView(true)
        GHZUserShopCartTools.sharedUserShopCar.addSupermarkProductToShopCart(shops: shops!)
        NotificationCenter.default().post(name: NSNotification.Name(rawValue: GHZShopCartProductPriceDidChange), object: nil)
    }
    @objc private func deleteShopsAction()
    {
        if buyNumber <= 0 {
            return
        }
        buyNumber -= 1
        shops?.userBuyNumber = buyNumber
        if buyNumber == 0 {
            deleteShopsButton.isHidden = true && !isShopEmpty
            buyCountLabel.isHidden = true && !isShopEmpty
            buyCountLabel.text = isShopEmpty ? "0" : ""
            GHZUserShopCartTools.sharedUserShopCar.removeSupermarketProduct(shops: shops!)
        } else {
            buyCountLabel.text = "\(buyNumber)"
        }
        
        GHZShopCartRedDotView.sharedRedDotView.reduceProductToRedDotView(animation: true)
        NotificationCenter.default().post(name: NSNotification.Name(rawValue: GHZShopCartProductPriceDidChange), object: nil)
    }
}


class GHZDiscountPriceView: UIView {
    private var marketPriceLabel: UILabel?
    private var priceLabel: UILabel?
    private var lineView: UIView?
    private var hasMarketPrice = false
    
    var priceColor: UIColor? {
        didSet {
            if priceLabel != nil {
                priceLabel!.textColor = priceColor
            }
        }
    }
    var marketPriceColor: UIColor? {
        didSet {
            if marketPriceLabel != nil {
                marketPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                    lineView?.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        marketPriceLabel = UILabel()
        marketPriceLabel?.textColor = UIColor.customColorWithFloat(r: 80, g: 80, b: 80, a: 1.0)
        marketPriceLabel?.font = HomeCollectionTextFont
        addSubview(marketPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.customColorWithFloat(r: 80, g: 80, b: 80, a: 1.0)
        
        marketPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel?.font = HomeCollectionTextFont
        priceLabel!.textColor = UIColor.red()
        addSubview(priceLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(price: String?, marketPrice: String?) {
        self.init()
        
        if price != nil && price?.characters.count != 0 {
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        if marketPrice != nil && marketPrice?.characters.count  != 0 {
            marketPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            marketPriceLabel?.sizeToFit()
        } else {
            hasMarketPrice = false
        }
        if marketPrice == price {
            hasMarketPrice = false
        } else {
            hasMarketPrice = true
        }

        marketPriceLabel?.isHidden = !hasMarketPrice
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        priceLabel?.frame = CGRect (x: 0, y: 0, width: (priceLabel?.width)!, height: height)
        if hasMarketPrice {
            marketPriceLabel?.frame = CGRect(x: (priceLabel?.frame.maxX)! + 5, y: 0, width: (marketPriceLabel?.width)!, height: height)
            lineView?.frame = CGRect(x: 0, y: (marketPriceLabel?.height)! * 0.5 - 0.5, width: (marketPriceLabel?.width)!, height: 1)
        }
    }

}
