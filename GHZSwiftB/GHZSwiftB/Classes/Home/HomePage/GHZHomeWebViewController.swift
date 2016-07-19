//
//  GHZHomeWebViewController.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
class GHZHomeWebViewController: GHZBaseViewController {

    private var webView = UIWebView(frame: GHZScreenBounds)
    private var url:String?
    private let loadProgressView: GHZLoadProgressView = GHZLoadProgressView(frame: CGRect(x: 0, y: 0, width: GHZScreenWidth, height: 3))
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefreshItem()
        
        view.backgroundColor = GHZWebViewBackColor
        webView.backgroundColor = GHZWebViewBackColor
        webView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = GHZNavBarWhiteBackColor
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.addSubview(webView)
    }
    
    convenience init(navigationTitle: String, urlStr: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.loadRequest(URLRequest.init(url: URL(string: urlStr)!))
        url = urlStr
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setRefreshItem()
    {
        let refresh = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        refresh.setImage(#imageLiteral(resourceName: "v2_refresh"), for: UIControlState())
        refresh.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        refresh.addTarget(self, action: #selector(clickRefresh), for: .touchUpInside)
    }
    //点击刷新按钮
    @objc private func clickRefresh()
    {
        if url != nil && url?.characters.count > 1 {
            webView.loadRequest(URLRequest(url: URL(string: url!)!))
        }
    }
}
extension GHZHomeWebViewController:UIWebViewDelegate
{
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadProgressView.startLoadProgressView()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadProgressView.endLoadProgressView()
    }
    
}
