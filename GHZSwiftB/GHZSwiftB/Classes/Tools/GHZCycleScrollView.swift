//
//  GHZCycleScrollView.swift
//  GHZSwiftB
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

import UIKit

class GHZCycleScrollView: UIView {
    private var contentScrollView:UIScrollView!
    private var pageControl:UIPageControl!
    private var timer:Timer?
    
    private let maxCount = 3
    private var placeholderImage:UIImage?
    private var clickImageView:((index:Int)->())?
    var headData:GHZHeaderData?  {
        didSet {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
            if headData?.data?.focus?.count >= 0{
                pageControl.numberOfPages = (headData?.data?.focus?.count)!
                pageControl.currentPage = 0
                upDateScrollView()
                startTimer()
            }
        }
    }
    
    
     override init (frame: CGRect) {
        super.init(frame: frame)
        setScrollView()
        setPageControll()
        
    }
    convenience init(frame: CGRect, placeholder: UIImage, focusImageViewClick:((index: Int) -> Void)) {
        self.init(frame: frame)
        placeholderImage = placeholder
        clickImageView = focusImageViewClick
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentScrollView.frame = bounds
        contentScrollView.contentSize = CGSize(width: CGFloat(maxCount) * width, height: 0)
        for i in 0...maxCount - 1 {
            let imageView = contentScrollView.subviews[i]
            imageView.frame = CGRect(x: contentScrollView.width * CGFloat(i), y: 0, width: contentScrollView.width, height: contentScrollView.height)
            
        }
        pageControl.frame = CGRect(x: contentScrollView.width - 80, y: contentScrollView.height - 20, width: 80, height: 20)
        
        
        upDateScrollView()
    }
    private func upDateScrollView(){
        
        
        for i in 0 ..< contentScrollView.subviews.count  {
            let imageView:UIImageView = contentScrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            
            if i == 0 {
                index -= 1
            }else if 2 == index{
                index += 1
            }
            if index < 0 {
                index = self.pageControl.numberOfPages - 1
            }else if index >= pageControl.numberOfPages
            {
                index = 0
            }
            
            imageView.tag = index
            if headData?.data?.focus?.count > 0 {
                imageView.sd_setImage(with: URL(string: (headData?.data?.focus?[index].img)!), placeholderImage: placeholderImage)
            }
            contentScrollView.contentOffset = CGPoint(x: contentScrollView.width, y: 0)
        }
    }
    
    //开启定时器
    private func startTimer()
    {
        timer = Timer(timeInterval: 3.0, target: self, selector: Selector(("next")), userInfo: nil, repeats: true)
        RunLoop.main().add(timer!, forMode: RunLoopMode.commonModes)
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
        contentScrollView.setContentOffset(CGPoint(x: 2.0 * contentScrollView.frame.size.width, y: 0), animated: true)
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
        contentScrollView = UIScrollView()
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        addSubview(contentScrollView)
        
        
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var count  = 0
        var minDistance = CGFloat(MAXFLOAT)
        
        for i in 0..<contentScrollView.subviews.count {
            let imageView = contentScrollView.subviews[i]
            let contentOffSet = abs(imageView.x - contentScrollView.contentOffset.x) as CGFloat
            
            if contentOffSet < minDistance
            {
                minDistance = contentOffSet
                count = imageView.tag
            }
            pageControl.currentPage = count
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stopTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        upDateScrollView()
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        upDateScrollView()
    }
    
    
}
    
