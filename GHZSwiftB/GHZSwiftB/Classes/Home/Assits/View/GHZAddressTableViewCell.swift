//
//  GHZAddressTableViewCell.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZAddressTableViewCell: UITableViewCell {

    private let nameLabel       = UILabel()
    private let phoneLabel      = UILabel()
    private let adressLabel     = UILabel()
    private let lineView        = UIView()
    private let modifyImageView = UIImageView()
    private let bottomView      = UIView()
    
    var modifyClickCallBack:((Int) -> Void)?
    
    var address: Address? {
        didSet {
            nameLabel.text = address!.accept_name
            phoneLabel.text = address!.telphone
            adressLabel.text = address!.address
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.none
        
        backgroundColor = UIColor.clear()
        contentView.backgroundColor = UIColor.white()
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = GHZTextBlackColor
        contentView.addSubview(nameLabel)
        
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = GHZTextBlackColor
        contentView.addSubview(phoneLabel)
        
        adressLabel.font = UIFont.systemFont(ofSize: 13)
        adressLabel.textColor = UIColor.lightGray()
        contentView.addSubview(adressLabel)
        
        lineView.backgroundColor = UIColor.lightGray()
        lineView.alpha = 0.2
        contentView.addSubview(lineView)
        
        modifyImageView.image = #imageLiteral(resourceName: "v2_address_edit_highlighted")
        modifyImageView.contentMode = UIViewContentMode.center
        contentView.addSubview(modifyImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GHZAddressTableViewCell.modifyImageViewClick(_:)))
        modifyImageView.isUserInteractionEnabled = true
        modifyImageView.addGestureRecognizer(tap)
        
        bottomView.backgroundColor = UIColor.lightGray()
        bottomView.alpha = 0.4
        contentView.addSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "GHZAddressTableViewCell"
    
    class func adressCell(_ tableView: UITableView, indexPath: IndexPath, modifyClickCallBack:((Int) -> Void)) -> GHZAddressTableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GHZAddressTableViewCell
        if cell == nil {
            cell = GHZAddressTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell?.modifyClickCallBack = modifyClickCallBack
        cell?.modifyImageView.tag = (indexPath as NSIndexPath).row
        
        return cell!
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 10, y: 15, width: 80, height: 20)
        phoneLabel.frame = CGRect(x: nameLabel.frame.maxX + 10, y: 15, width: 150, height: 20)
        adressLabel.frame = CGRect(x: 10, y: phoneLabel.frame.maxY + 10, width: width * 0.6, height: 20)
        lineView.frame = CGRect(x: width * 0.8, y: 10, width: 1, height: height - 20)
        modifyImageView.frame = CGRect(x: width * 0.8 + (width * 0.2 - 40) * 0.5, y: (height - 40) * 0.5, width: 40, height: 40)
        bottomView.frame = CGRect(x: 0, y: height - 1, width: width, height: 1)
    }
    
    // MARK: - Action
    func modifyImageViewClick(_ tap: UIGestureRecognizer) {
        if modifyClickCallBack != nil {
            modifyClickCallBack!(tap.view!.tag)
        }
    }
}
