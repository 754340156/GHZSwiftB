//
//  GHZProductDetailViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZProductDetailViewController: GHZBaseViewController {
    
    private let grayBackgroundColor = UIColor.customColorWithFloat(r: 248, g: 248, b: 248, a: 1.0)
    
    private var scrollView: UIScrollView?
    private var productImageView: UIImageView?
    private var titleNameLabel: UILabel?
    private var priceView: GHZDiscountPriceView?
    private var presentView: UIView?
    private var detailView: UIView?
    private var brandTitleLabel: UILabel?
    private var detailTitleLabel: UILabel?
    private var promptView: UIView?
    private let nameView = UIView()
    private var detailImageView: UIImageView?
    private var bottomView: UIView?
    private var yellowShopCar: GHZYellowShopCartView?
    private var shops: Shops?
    private var buyView: GHZBuyView?
    private let shareActionSheet: GHZActionSheet = GHZActionSheet()
    
    init () {
        super.init(nibName: nil, bundle: nil)
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.backgroundColor = UIColor.white()
        scrollView?.bounces = false
        view.addSubview(scrollView!)
        
        productImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: GHZScreenWidth, height: 400))
        productImageView?.contentMode = UIViewContentMode.scaleAspectFill
        scrollView!.addSubview(productImageView!)
        
        buildLineView(frame: CGRect(x: 0, y: (productImageView?.frame.maxX)! - 1, width: GHZScreenWidth, height: 1), addView: productImageView!)
        let leftMargin: CGFloat = 15
        
        nameView.frame = CGRect( x: 0, y: (productImageView?.frame.maxX)!, width: GHZScreenWidth, height: 80)
        nameView.backgroundColor = UIColor.white()
        scrollView!.addSubview(nameView)
        
        titleNameLabel = UILabel(frame: CGRect (x: leftMargin, y: 0, width: GHZScreenWidth, height: 60))
        titleNameLabel?.textColor = UIColor.black()
        titleNameLabel?.font = UIFont.systemFont(ofSize: 16)
        nameView.addSubview(titleNameLabel!)
        
        buildLineView(frame: CGRect(x: 0, y: 79, width: GHZScreenWidth, height: 1), addView: nameView)
        presentView = UIView(frame: CGRect (x: 0, y: nameView.frame.maxY, width: GHZScreenWidth, height: 50))
        presentView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(presentView!)
        
        let presentButton = UIButton(frame: CGRect (x: leftMargin, y: 13, width: 55, height: 24))
        presentButton.setTitle("促销", for: UIControlState())
        presentButton.backgroundColor = UIColor.customColorWithFloat(r: 252, g: 85, b: 88, a: 1.0)
        presentButton.layer.cornerRadius = 8
        presentButton.setTitleColor(UIColor.white(), for: UIControlState())
        presentView?.addSubview(presentButton)
        
        let presentLabel = UILabel(frame: CGRect(x: 100, y: 0, width: GHZScreenWidth * 0.7, height: 50))
        presentLabel.textColor = UIColor.black()
        presentLabel.font = UIFont.systemFont(ofSize: 14)
        presentLabel.text = "买一赠一 (赠品有限,赠完为止)"
        presentView?.addSubview(presentLabel)
        
        buildLineView(frame: CGRect (x: 0, y: 49, width: GHZScreenWidth, height: 1), addView: presentView!)
        detailView = UIView(frame: CGRect (x: 0, y: (presentView?.frame.maxY)!, width: GHZScreenWidth, height: 150))
        detailView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(detailView!)
        
        let brandLabel = UILabel(frame:CGRect (x: leftMargin, y: 0, width: 80, height: 50))
        brandLabel.textColor = UIColor.customColorWithFloat(r: 150, g: 150, b: 150, a: 1.0)
        brandLabel.text = "品       牌"
        brandLabel.font = UIFont.systemFont(ofSize: 14)
        detailView?.addSubview(brandLabel)
        
        brandTitleLabel = UILabel(frame: CGRect (x: 100, y: 0, width: GHZScreenWidth * 0.6, height: 50))
        brandTitleLabel?.textColor = UIColor.black()
        brandTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        detailView?.addSubview(brandTitleLabel!)
        
        buildLineView(frame: CGRect(x: 0, y: 50 - 1, width: GHZScreenWidth, height: 1), addView: detailView!)
        
        let detailLabel = UILabel(frame: CGRect(x: leftMargin,y: 50, width: 80, height: 50))
        detailLabel.text = "产品规格"
        detailLabel.textColor = brandLabel.textColor
        detailLabel.font = brandTitleLabel!.font
        detailView?.addSubview(detailLabel)
        
        detailTitleLabel = UILabel(frame: CGRect(x: 100, y: 50, width: GHZScreenWidth * 0.6, height: 50))
        detailTitleLabel?.textColor = brandTitleLabel!.textColor
        detailTitleLabel?.font = brandTitleLabel!.font
        detailView?.addSubview(detailTitleLabel!)
        
        buildLineView(frame: CGRect(x: 0, y: 99, width: GHZScreenWidth, height: 1), addView: detailView!)
        let textImageLabel = UILabel(frame: CGRect(x: leftMargin, y: 100, width: 80, height: 50))
        textImageLabel.textColor = brandLabel.textColor
        textImageLabel.font = brandLabel.font
        textImageLabel.text = "图文详情"
        detailView?.addSubview(textImageLabel)
        
        promptView = UIView(frame: CGRect (x: 0, y: (detailView?.frame.maxY)!, width: GHZScreenWidth, height: 80))
        promptView?.backgroundColor = UIColor.white()
        scrollView?.addSubview(promptView!)
        
        let promptLabel = UILabel(frame: CGRect (x: 15, y: 5, width: GHZScreenWidth, height: 20))
        promptLabel.text = "温馨提示:"
        promptLabel.textColor = UIColor.black()
        promptView?.addSubview(promptLabel)
        
        let promptDetailLabel = UILabel(frame:CGRect (x: 15, y: 20, width: GHZScreenWidth - 30, height: 60))
        promptDetailLabel.textColor = presentButton.backgroundColor
        promptDetailLabel.numberOfLines = 2
        promptDetailLabel.text = "商品签收后, 如有问题请您在24小时内联系4008484842,并将商品及包装保留好,拍照发给客服"
        promptDetailLabel.font = UIFont.systemFont(ofSize: 14)
        promptView?.addSubview(promptDetailLabel)
        
        buildLineView(frame: CGRect (x: 0, y: GHZScreenWidth - 51 - GHZNavigationHeight, width: GHZScreenWidth, height: 1), addView: view)
        bottomView = UIView(frame: CGRect (x: 0, y: GHZScreenWidth - 50 - GHZNavigationHeight, width: GHZScreenWidth , height: 50))
        bottomView?.backgroundColor = grayBackgroundColor
        view.addSubview(bottomView!)
        
        let addProductLabel = UILabel(frame: CGRect( x: 15, y: 0, width: 70, height: 50))
        addProductLabel.text = "添加商品:"
        addProductLabel.textColor = UIColor.black()
        addProductLabel.font = UIFont.systemFont(ofSize: 15)
        bottomView?.addSubview(addProductLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(shops: Shops) {
        self.init()
        self.shops = shops
        productImageView?.sd_setImage(with: URL(string: shops.img!), placeholderImage: #imageLiteral(resourceName: "v2_placeholder_square"))
        titleNameLabel?.text = shops.name
        priceView = GHZDiscountPriceView(price: shops.price, marketPrice: shops.market_price)
        priceView?.frame = CGRect(x: 15, y: 40, width: GHZScreenWidth * 0.6, height: 40)
        nameView.addSubview(priceView!)
        
        if shops.pm_desc == "买一赠一" {
            presentView?.frame.size.height = 50
            presentView?.isHidden = false
        } else {
            presentView?.frame.size.height = 0
            presentView?.isHidden = true
            detailView?.frame.origin.y -= 50
            promptView?.frame.origin.y -= 50
        }
        
        brandTitleLabel?.text = shops.brand_name
        detailTitleLabel?.text = shops.specifics
        
        detailImageView = UIImageView(image: UIImage(named: "aaaa"))
        let scale: CGFloat = 320.0 / GHZScreenWidth
        detailImageView?.frame = CGRect( x: 0, y: (promptView?.frame.maxY)!, width: GHZScreenWidth, height: (detailImageView?.height)! / scale)
        scrollView?.addSubview(detailImageView!)
        scrollView?.contentSize = CGSize(width: GHZScreenWidth, height: (detailImageView?.frame.maxY)! + 50 + GHZNavigationHeight)
        
        buildNavigationItem(titleText: shops.name!)
        
        buyView = GHZBuyView(frame: CGRect(x: 85, y: 12, width: 80, height: 25))
        buyView!.isShopEmpty = true
        buyView!.shops = shops
        bottomView?.addSubview(buyView!)
        
        weak var weakSelf = self
        yellowShopCar = GHZYellowShopCartView(frame: CGRect(x: GHZScreenWidth - 70, y: 101, width: 61, height: 61) , shopViewClick: { () -> () in
            let shopCarVC = GHZShopCartController()
            let nav = GHZNavViewController(rootViewController: shopCarVC)
            weakSelf!.present(nav, animated: true, completion: nil)
        })
        
        bottomView!.addSubview(yellowShopCar!)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default().post(name: NSNotification.Name(rawValue: GHZSearchViewControllerDeinit) , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
        
        if shops != nil {
            buyView?.shops = shops
        }
        
        (navigationController as! GHZNavViewController).isAnimation = true
    }
    
    // MARK: - Build UI
    private func buildLineView(frame: CGRect, addView: UIView) {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.black()
        lineView.alpha = 0.1
        addView.addSubview(lineView)
    }
    
    private func buildNavigationItem(titleText: String) {
        self.navigationItem.title = titleText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "分享", titleColor: UIColor.customColorWithFloat(r: 100, g: 100, b: 100, a: 1.0), targer: self, action: #selector(GHZProductDetailViewController.rightItemClick))
    }
    
    // MARK: - Action
    func rightItemClick() {
        shareActionSheet.showActionSheetViewShowInView(view) { (shareType) -> () in
            ShareManager.shareToShareType(shareType, vc: self)
        }
    }
}
