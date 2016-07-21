//
//  GHZEditAddressViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
import SVProgressHUD
enum GHZEditAdressViewControllerType: Int {
    case add
    case edit
}

class GHZEditAddressViewController: GHZBaseViewController {
    
    private let deleteView = UIView()
    private let scrollView = UIScrollView()
    private let adressView = UIView()
    private var contactsTextField: UITextField?
    private var phoneNumberTextField: UITextField?
    private var cityTextField: UITextField?
    private var areaTextField: UITextField?
    private var adressTextField: UITextField?
    private var manButton: LeftImageRightTextButton?
    private var womenButton: LeftImageRightTextButton?
    private var selectCityPickView: UIPickerView?
    private var currentSelectedCityIndex = -1
    weak var topVC: GHZMyAddressViewController?
    var vcType: GHZEditAdressViewControllerType?
    var currentAdressRow: Int = -1
    
    private lazy var cityArray: [String]? = {
        let array = ["北京市", "上海市", "天津市", "广州市", "佛山市", "深圳市", "廊坊市", "武汉市", "苏州市", "无锡市"]
        return array
    }()
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildScrollView()
        
        buildAdressView()
        
        buildDeleteAdressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
        
        if currentAdressRow != -1 && vcType == .edit {
            let address = topVC!.addresses![currentAdressRow]
            contactsTextField?.text = address.accept_name
            if address.telphone?.characters.count == 11 {
                let telphone = address.telphone! as NSString
                phoneNumberTextField?.text = telphone.substring(with: NSMakeRange(0, 3)) + " " + telphone.substring(with: NSMakeRange(3, 4)) + " " + telphone.substring(with: NSMakeRange(7, 4))
            }
            
            if address.telphone?.characters.count == 13 {
                phoneNumberTextField?.text = address.telphone
            }
            
            if address.gender == "1" {
                manButton?.isSelected = true
            } else {
                womenButton?.isSelected = true
            }
            cityTextField?.text = address.city_name
            let range = (address.address! as NSString).range(of: " ")
            areaTextField?.text = (address.address! as NSString).substring(to: range.location)
            adressTextField?.text = (address.address! as NSString).substring(from: range.location + 1)
            
            deleteView.isHidden = false
        }
        
    }
    
    // MARK: - Method
    private func buildNavigationItem() {
        
        navigationItem.title = "修改地址"
        
        let rightItemButton = UIBarButtonItem.barButton(title: "保存", titleColor: UIColor.lightGray(), targer: self, action: #selector(GHZEditAddressViewController.saveButtonClick))
        navigationItem.rightBarButtonItem = rightItemButton
    }
    
    private func buildDeleteAdressView() {
        deleteView.frame = CGRect(x: 0, y: adressView.frame.maxY + 10, width: view.width, height: 50)
        deleteView.backgroundColor = UIColor.white()
        scrollView.addSubview(deleteView)
        
        let deleteLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        deleteLabel.text = "删除当前地址"
        deleteLabel.textAlignment = NSTextAlignment.center
        deleteLabel.font = UIFont.systemFont(ofSize: 15)
        deleteView.addSubview(deleteLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GHZEditAddressViewController.deleteViewClick))
        deleteView.addGestureRecognizer(tap)
        deleteView.isHidden = true
    }
    
    private func buildScrollView() {
        scrollView.frame = view.bounds
        scrollView.backgroundColor = UIColor.clear()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func buildAdressView() {
        adressView.frame = CGRect(x: 0, y: 10, width: view.width, height: 300)
        adressView.backgroundColor = UIColor.white()
        scrollView.addSubview(adressView)
        
        let viewHeight: CGFloat = 50
        let leftMargin: CGFloat = 15
        let labelWidth: CGFloat = 70
        buildUnchangedLabel(CGRect(x: leftMargin, y: 0, width: labelWidth, height: viewHeight), text: "联系人")
        buildUnchangedLabel(CGRect(x: leftMargin, y: 2 * viewHeight, width: labelWidth, height: viewHeight), text: "手机号码")
        buildUnchangedLabel(CGRect(x: leftMargin, y: 3 * viewHeight, width: labelWidth, height: viewHeight), text: "所在城市")
        buildUnchangedLabel(CGRect(x: leftMargin, y: 4 * viewHeight, width: labelWidth, height: viewHeight), text: "所在地区")
        buildUnchangedLabel(CGRect(x: leftMargin, y: 5 * viewHeight, width: labelWidth, height: viewHeight), text: "详细地址")
        
        let lineView = UIView(frame: CGRect(x: leftMargin, y: 49, width: view.width - 10, height: 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGray()
        adressView.addSubview(lineView)
        
        let textFieldWidth = view.width * 0.6
        let x = leftMargin + labelWidth + 10
        contactsTextField = UITextField()
        buildTextField(contactsTextField!, frame: CGRect(x: x, y: 0, width: textFieldWidth, height: viewHeight), placeholder: "收货人姓名", tag: 1)
        
        phoneNumberTextField = UITextField()
        buildTextField(phoneNumberTextField!, frame: CGRect(x: x, y: 2 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "鲜蜂侠联系你的电话", tag: 2)
        
        cityTextField = UITextField()
        buildTextField(cityTextField!, frame: CGRect(x: x, y: 3 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "请选择城市", tag: 3)
        
        areaTextField = UITextField()
        buildTextField(areaTextField!, frame: CGRect(x: x, y: 4 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "请选择你的住宅,大厦或学校", tag: 4)
        
        adressTextField = UITextField()
        buildTextField(adressTextField!, frame: CGRect(x: x, y: 5 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "请输入楼号门牌号等详细信息", tag: 5)
        
        manButton = LeftImageRightTextButton()
        buildGenderButton(manButton!, frame: CGRect(x: phoneNumberTextField!.frame.minX, y: 50, width: 100, height: 50), title: "先生", tag: 101)
        
        womenButton = LeftImageRightTextButton()
        buildGenderButton(womenButton!, frame: CGRect(x: manButton!.frame.maxX + 10, y: 50, width: 100, height: 50), title: "女士", tag: 102)
    }
    
    private func buildUnchangedLabel(_ frame: CGRect, text: String) {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = GHZTextBlackColor
        adressView.addSubview(label)
        
        let lineView = UIView(frame: CGRect(x: 15, y: frame.origin.y - 1, width: view.width - 10, height: 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGray()
        adressView.addSubview(lineView)
    }
    
    private func buildTextField(_ textField: UITextField, frame: CGRect, placeholder: String, tag: Int) {
        textField.frame = frame
        
        if 2 == tag {
            textField.keyboardType = UIKeyboardType.numberPad
        }
        
        if 3 == tag {
            selectCityPickView = UIPickerView()
            selectCityPickView!.delegate = self
            selectCityPickView!.dataSource = self
            textField.inputView = selectCityPickView
            textField.inputAccessoryView = buildInputView()
        }
        
        textField.tag = tag
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.delegate = self
        textField.textColor = GHZTextBlackColor
        adressView.addSubview(textField)
    }
    
    private func buildInputView() -> UIView {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 40))
        toolBar.backgroundColor = UIColor.white()
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 1))
        lineView.backgroundColor = UIColor.black()
        lineView.alpha = 0.1
        toolBar.addSubview(lineView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.lightGray()
        titleLabel.alpha = 0.8
        titleLabel.text = "选择城市"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.width, height: toolBar.height)
        toolBar.addSubview(titleLabel)
        
        let cancleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: toolBar.height))
        cancleButton.tag = 10
        cancleButton.addTarget(self, action: #selector(GHZEditAddressViewController.selectedCityTextFieldDidChange(_:)), for: .touchUpInside)
        cancleButton.setTitle("取消", for: UIControlState())
        cancleButton.setTitleColor(UIColor.customColorWithFloat(r: 82, g: 188, b: 248, a: 1.0), for: UIControlState())
        toolBar.addSubview(cancleButton)
        
        let determineButton = UIButton(frame: CGRect(x: view.width - 80, y: 0, width: 80, height: toolBar.height))
        determineButton.tag = 11
        determineButton.addTarget(self, action: #selector(GHZEditAddressViewController.selectedCityTextFieldDidChange(_:)), for: .touchUpInside)
        determineButton.setTitleColor(UIColor.customColorWithFloat(r: 82, g: 188, b: 248, a: 1.0), for: UIControlState())
        determineButton.setTitle("确定", for: UIControlState())
        toolBar.addSubview(determineButton)
        
        return toolBar
    }
    
    private func buildGenderButton(_ button: LeftImageRightTextButton, frame: CGRect, title: String, tag: Int) {
        button.tag = tag
        button.setImage(#imageLiteral(resourceName: "v2_noselected"), for: UIControlState())
        button.setImage(#imageLiteral(resourceName: "v2_selected"), for: UIControlState.selected)
        button.addTarget(self, action: #selector(GHZEditAddressViewController.genderButtonClick(_:)), for: .touchUpInside)
        button.setTitle(title, for: UIControlState())
        button.frame = frame
        button.setTitleColor(GHZTextBlackColor, for: UIControlState())
        adressView.addSubview(button)
    }
    
    // MARK: - Action
    func saveButtonClick() {
        if contactsTextField?.text?.characters.count <= 1 {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入名字")
            return
        }
        
        if !manButton!.isSelected && !womenButton!.isSelected {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入性别")
            return
        }
        
        if phoneNumberTextField!.text?.characters.count != 13 {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入电话")
            return
        }
        
        if cityTextField?.text?.characters.count <= 0 {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入城市")
            return
        }
        
        if areaTextField?.text?.characters.count <= 2 {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入区域位置")
            return
        }
        
        if adressTextField?.text?.characters.count <= 2 {
            SVProgressHUD.show(#imageLiteral(resourceName: "v2_orderSuccess"), status: "请输入地址")
            return
        }
        
        if vcType == .add {
            let address = Address()
            setAddressModel(address)
            if topVC?.addresses?.count == 0 || topVC?.addresses == nil {
                topVC?.addresses = []
            }
            
            topVC!.addresses!.insert(address, at: 0)
        }
        
        if vcType == .edit {
            let address = topVC!.addresses![currentAdressRow]
            setAddressModel(address)
        }
        
        navigationController?.popViewController(animated: true)
        topVC?.addressTableView?.reloadData()
    }
    
    private func setAddressModel(_ address: Address) {
        address.accept_name = contactsTextField!.text
        address.telphone = phoneNumberTextField!.text
        address.gender = manButton!.isSelected ? "1" : "2"
        address.city_name = cityTextField!.text
        address.address = areaTextField!.text! + " " + adressTextField!.text!
    }
    
    func genderButtonClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
            manButton?.isSelected = true
            womenButton?.isSelected = false
            break
        case 102:
            manButton?.isSelected = false
            womenButton?.isSelected = true
            break
        default:
            break
        }
    }
    
    func selectedCityTextFieldDidChange(_ sender: UIButton) {
        
        if sender.tag == 11 {
            if currentSelectedCityIndex != -1 {
                cityTextField?.text = cityArray![currentSelectedCityIndex]
            }
        }
        cityTextField!.endEditing(true)
    }
    
    func deleteViewClick() {
        topVC!.addresses!.remove(at: currentAdressRow)
        navigationController?.popViewController(animated: true)
        topVC?.addressTableView?.reloadData()
    }
}


extension GHZEditAddressViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 2 {
            if textField.text?.characters.count == 13 {
                
                return false
                
            } else {
                
                if textField.text?.characters.count == 3 || textField.text?.characters.count == 8 {
                    textField.text = textField.text! + " "
                }
                
                return true
            }
        }
        
        return true
    }
    
}
extension GHZEditAddressViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedCityIndex = row
    }
    
}

