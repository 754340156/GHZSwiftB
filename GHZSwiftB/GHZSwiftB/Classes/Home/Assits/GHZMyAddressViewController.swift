//
//  GHZMyAddressViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZMyAddressViewController: GHZBaseViewController {
    
    private var addAdressButton: UIButton?
    private var nullImageView = UIView()
    
    var selectedAdressCallback:((address: Address) -> ())?
    var isSelectVC = false
    var addressTableView: GHZCustomTableView?
    var addresses: [Address]? {
        didSet {
            if addresses?.count == 0 {
                nullImageView.isHidden = false
                addressTableView?.isHidden = true
            } else {
                nullImageView.isHidden = true
                addressTableView?.isHidden = false
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(selectedAdress: ((address:Address) -> ())) {
        self.init(nibName: nil, bundle: nil)
        selectedAdressCallback = selectedAdress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildAdressTableView()
        
        buildNullImageView()
        
        loadAdressData()
        
        buildBottomAddAdressButtom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
    }
    
    private func buildNavigationItem() {
        navigationItem.title = "我的收获地址"
    }
    
    private func buildAdressTableView() {
        addressTableView = GHZCustomTableView(frame: view.bounds, style: UITableViewStyle.plain)
        addressTableView?.frame.origin.y += 10;
        addressTableView?.backgroundColor = UIColor.clear()
        addressTableView?.rowHeight = 80
        addressTableView?.delegate = self
        addressTableView?.dataSource = self
        view.addSubview(addressTableView!)
    }
    
    private func buildNullImageView() {
        nullImageView.backgroundColor = UIColor.clear()
        nullImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 10, width: 200, height: 20))
        label.textColor = UIColor.lightGray()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "你还没有地址哦~"
        nullImageView.addSubview(label)
    }
    
    private func loadAdressData() {
        weak var weakSelf = self
        GHZAddressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count > 0 {
                    weakSelf!.addresses = data!.data
                    weakSelf!.addressTableView?.isHidden = false
                    weakSelf!.addressTableView?.reloadData()
                    weakSelf!.nullImageView.isHidden = true
                    GHZUserInfo.sharedUserInfo.setAllAdress(address: data!.data!)
                } else {
                    weakSelf!.addressTableView?.isHidden = true
                    weakSelf!.nullImageView.isHidden = false
                    GHZUserInfo.sharedUserInfo.cleanAllAdress()
                }
            }
        }
    }
    
    private func buildBottomAddAdressButtom() {
        let bottomView = UIView(frame: CGRect(x: 0, y: GHZScreenHeight - 60 - 64, width: GHZScreenWidth, height: 60))
        bottomView.backgroundColor = UIColor.white()
        view.addSubview(bottomView)
        
        addAdressButton = UIButton(frame: CGRect(x: GHZScreenWidth * 0.15, y: 12, width: GHZScreenWidth * 0.7, height: 60 - 12 * 2))
        addAdressButton?.backgroundColor = GHZNavigationYellowColor
        addAdressButton?.setTitle("+ 新增地址", for: UIControlState())
        addAdressButton?.setTitleColor(UIColor.black(), for: UIControlState())
        addAdressButton?.layer.masksToBounds = true
        addAdressButton?.layer.cornerRadius = 8
        addAdressButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addAdressButton?.addTarget(self, action: #selector(GHZMyAddressViewController.addAdressButtonClick), for: UIControlEvents.touchUpInside)
        bottomView.addSubview(addAdressButton!)
    }
    
    // MARK: - Action
    func addAdressButtonClick() {
        let editVC = GHZEditAddressViewController()
        editVC.topVC = self
        editVC.vcType = GHZEditAdressViewControllerType.add
        navigationController?.pushViewController(editVC, animated: true)
    }
}


extension GHZMyAddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        weak var tmpSelf = self
        let cell = GHZAddressTableViewCell.adressCell(tableView, indexPath: indexPath) { (cellIndexPathRow) -> Void in
            let editAdressVC = GHZEditAddressViewController()
            editAdressVC.topVC = tmpSelf
            editAdressVC.vcType = GHZEditAdressViewControllerType.edit
            editAdressVC.currentAdressRow = (indexPath as NSIndexPath).row
            tmpSelf!.navigationController?.pushViewController(editAdressVC, animated: true)
        }
        cell.address = addresses![(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectVC {
            if selectedAdressCallback != nil {
                selectedAdressCallback!(address: addresses![(indexPath as NSIndexPath).row])
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
