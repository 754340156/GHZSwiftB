//
//  GHZCycleScrollView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit
class GHZCycleScrollView: UIView {
    private var scrollView:UIScrollView
    private var pageControl:UIPageControl
    private var timer:Timer?
    
    private let maxCount = 3
    private var placeholderImage:UIImage
    var clickImageView:((index:Int)->())?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScrollView()
        setPageControll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: CGFloat(maxCount) * width, height: 0)
        for i in 0...maxCount - 1 {
            let imageView = scrollView.subviews[i]
            imageView.frame = CGRect(x: scrollView.width * CGFloat(i), y: 0, width: scrollView.width, height: scrollView.height)
            
        }
        pageControl.frame = CGRect(x: scrollView.width - 80, y: scrollView.height - 20, width: 80, height: 20)
        
        
        upDateScrollView()
    }
    private func upDateScrollView(){
        
    }
    
    //开启定时器
    private func startTimer()
    {
        timer = Timer(timeInterval: 3.0, target: self, selector: Selector(("next")), userInfo: nil, repeats: true)
    }
    //关闭定时器
    private func stopTimer()
    {
        timer?.invalidate()
        timer = nil
    }
    //定时器方法
    private func next()
    {
        scrollView.setContentOffset(CGPoint(x: 2.0 * scrollView.frame.size.width, y: 0), animated: true)
    }
    //点击图片回调
    private func clickImageView(tap:UITapGestureRecognizer)
    {
        if clickImageView != nil{
            clickImageView!(index:(tap.view?.tag)!)
        }
    }
    
    //set or get
    private func setScrollView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        addSubview(scrollView)
        
        
        for _ in 0..<maxCount {
            let imageView:UIImageView = UIImageView()
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("clickImageView:")))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            addSubview(imageView)
        }
    }
    
    private func setPageControll()
    {
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_normal")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_selected")!)
        addSubview(pageControl)
        
    }
  
}


extension GHZCycleScrollView:UIScrollViewDelegate
{
    
}
