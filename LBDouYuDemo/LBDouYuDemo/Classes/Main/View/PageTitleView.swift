//
//  PageTitleView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}

private let kScrollLinehH:CGFloat = 2

private let kNarmalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    private var titles:[String]
    
    private var currentIndex:Int = 0
    
    
    
    weak var delegate:PageTitleViewDelegate?
    
    private var titlesLabels:[UILabel] = [UILabel]()
        // 创建scrollView
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    // 创建滚动是底部的线条
    private lazy var scrollViewLine:UIView = {
        let scrollViewLine = UIView()
        scrollViewLine.backgroundColor = UIColor.orange
        return scrollViewLine
    }()
    
     init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension PageTitleView{
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加lable
        setupTitles()
        
        //设置底部线条
        setupLine()
        
    }
    
    private func setupLine(){
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottonLine)
        
        guard let firstLabel = titlesLabels.first else {return}
        firstLabel.textColor = UIColor(r:kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollView.addSubview(scrollViewLine)
        scrollViewLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLinehH, width: firstLabel.frame.width, height: kScrollLinehH)
        
        
        
        
    }
    
    private func setupTitles(){
        
        for(index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNarmalColor.0, g: kNarmalColor.1, b: kNarmalColor.2)
            label.textAlignment = .center
            
            let labelY :CGFloat = 0
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelH:CGFloat = frame.height - CGFloat(kScrollLinehH)
             let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titlesLabels.append(label)
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(titleLabelClick) )
            label.addGestureRecognizer(tapGes)
        }
        
    }
}

extension PageTitleView{
    @objc public func titleLabelClick(clickTap:UITapGestureRecognizer){
        
        
        //获取当前的llabel
        guard let currentLabel = clickTap.view as? UILabel else {return}
        //获取之前的label
        let oldLabel = titlesLabels[currentIndex]
        
        if(currentLabel.tag == currentIndex){
            return
        }
        
        currentLabel.textColor = UIColor(r:kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor =  UIColor(r: kNarmalColor.0, g: kNarmalColor.1, b: kNarmalColor.2)
        currentIndex = currentLabel.tag
        
        let positonX:CGFloat = CGFloat(currentLabel.tag) * scrollViewLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollViewLine.frame.origin.x = positonX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}
//对方暴露一个方法接收值
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,souceIndex:Int,targeIndex:Int){
        let souceLabel = titlesLabels[souceIndex]
        let targeLabel = titlesLabels[targeIndex]
        
        //处理滑块
        let moveTotalX = targeLabel.frame.origin.x - souceLabel.frame.origin.x
        
        let moveX = moveTotalX * progress
        scrollViewLine.frame.origin.x = souceLabel.frame.origin.x + moveX
        
        //处理颜色渐变
        let colorDelte = (kSelectColor.0 - kNarmalColor.0,kSelectColor.1 - kNarmalColor.1,kSelectColor.2 - kNarmalColor.2)
        
        souceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelte.0 * progress, g: kSelectColor.1 - colorDelte.1 * progress, b: kSelectColor.2 - colorDelte.2 * progress)
        
        targeLabel.textColor = UIColor(r: kNarmalColor.0 + colorDelte.0 * progress, g: kNarmalColor.1 + colorDelte.1 * progress, b: kNarmalColor.2 + colorDelte.2 * progress)
        
        currentIndex = targeIndex
    }
}
