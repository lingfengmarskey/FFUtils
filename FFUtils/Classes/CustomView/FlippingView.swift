//
//  FlippingView.swift
//  Counter
//
//  Created by marskey on 2019/3/2.
//  Copyright © 2019 Marskey. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
public class FlippingView:  UIView{

    public var text:String = "" {
        didSet{
            self.setText(text, false)
        }
    }
    
    typealias callback = ()->Void

    public var playSoundAction:(()->Void)?
    
    fileprivate var timer:Timer?
    fileprivate var bottomTimer:Timer?
    
    fileprivate var topCallback:callback?
    
    fileprivate var topText:HalfView = HalfView.init(type: .top)
    fileprivate var topTextc:HalfView = HalfView.init(type: .top)
    fileprivate var bottomText:HalfView = HalfView.init(type: .bottom)
    fileprivate var bottomTextc:HalfView = HalfView.init(type: .bottom)
    
    private static let topDuration:TimeInterval = 0.25
    private static let bottomDuration:TimeInterval = 0.1
    
    
    lazy var topAni:CABasicAnimation = {
        var start = CATransform3DIdentity
        start.m34 = 1 / -500
        let end = CATransform3DRotate(start, CGFloat.pi / -2, 1, 0, 0)
        let topAni = CABasicAnimation.init(keyPath: "transform")
        topAni.fromValue = NSValue.init(caTransform3D: start)
        topAni.toValue = NSValue.init(caTransform3D: end)
        topAni.duration = FlippingView.topDuration
//        topAni.fillMode = CAMediaTimingFillMode.forwards
//        topAni.fillMode = CAMediaTimingFillMode.forwards
//        topAni.timingFunction = CAMediaTimingFunction.init(name:CAMediaTimingFunctionName.easeIn)
        topAni.isRemovedOnCompletion = false
        return topAni
    }()
    
    lazy var bottomAni:CABasicAnimation = {
        var start = CATransform3DIdentity
        start.m34 = 1 / -500
        let endMidle = CATransform3DRotate(start, CGFloat.pi / 2, 1, 0, 0)
        let end = CATransform3DRotate(endMidle, CGFloat.pi / -2, 1, 0, 0)
        
        let bottomAni = CABasicAnimation.init(keyPath: "transform")
        bottomAni.fromValue = NSValue.init(caTransform3D: endMidle)
        bottomAni.toValue = NSValue.init(caTransform3D: end)
        bottomAni.duration = FlippingView.bottomDuration
//        bottomAni.fillMode = CAMediaTimingFillMode.forwards
//        bottomAni.timingFunction = CAMediaTimingFunction.init(name:CAMediaTimingFunctionName.easeOut)
        bottomAni.isRemovedOnCompletion = true
        return bottomAni
    }()
    
    fileprivate var isTopTiming = false
    fileprivate var isBottomTiming = false
    public var lastText:String = ""
    
    fileprivate let topTAnchor:CGPoint = CGPoint.init(x: 0.5, y: 1)
    fileprivate let bottomTAnchor = CGPoint.init(x: 0.5, y: 0)
    
    fileprivate var topTxts:[HalfView] = []
    fileprivate var bottomTxts:[HalfView] = []
    
    fileprivate let lenght:CGFloat
    fileprivate let h_lenght:CGFloat

    public override init(frame: CGRect) {
        lenght = frame.size.width
        h_lenght = frame.size.height
        super.init(frame: CGRect.init(origin: frame.origin, size: CGSize.init(width: lenght, height: h_lenght)))

        configSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configSubViews()  {
        addSubview(topText)
        addSubview(topTextc)
        
        addSubview(bottomText)
        addSubview(bottomTextc)
        
        configFrame()
        
        topTxts = [topText, topTextc]
        bottomTxts = [bottomText, bottomTextc]
    }
    
    
    private func configFrame()  {
        
        topText.layer.anchorPoint = topTAnchor
        topTextc.layer.anchorPoint = topTAnchor
        
        bottomText.layer.anchorPoint = bottomTAnchor
        bottomTextc.layer.anchorPoint = bottomTAnchor
        
        topText.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: lenght, height: h_lenght / 2.0))
        topTextc.frame = topText.frame
        
        bottomText.frame =  CGRect.init(origin: CGPoint.init(x: 0, y: h_lenght/2), size: CGSize.init(width: lenght, height: h_lenght / 2.0))
        bottomTextc.frame = bottomText.frame
    }
    
    
    // 开始头部动画
    private func startTopAnimate( completed:@escaping ()->Void) -> Void {
        let old = topTxts[1]
        old.layer.add(topAni, forKey: "topAni")
        isTopTiming = true
        timer = Timer.scheduledTimer(withTimeInterval: FlippingView.topDuration, repeats: false, block: {[weak self] (t) in
            self?.isTopTiming = false
            completed()
        })
    }
    
    @objc func topTimeAction(){
        
    }
    // 开始底部动画
    private func startBottomAnimte()  {
        let new = bottomTxts[0]
        // 1.view移动上面
        reloadNewBottom()
        // 2.开始view动画
        new.layer.add(bottomAni, forKey: "bottomAni")
        isBottomTiming = true
        
        bottomTimer = Timer.scheduledTimer(withTimeInterval: FlippingView.topDuration, repeats: false, block: {[weak self] (t) in
            self?.isBottomTiming = false;
        })
    }
    
    // 重置3d动画效果
    private func reset3DAnimateState(_ layer:CALayer) -> Void {
        layer.removeAllAnimations()
    }
    
    // 重置topview
    private func resetTopOldView()  {
        let old = topTxts[1];
        // 3.旧值视图移动到下面
        sendSubviewToBack(old)
        topTxts.remove(at: 1)
        topTxts.insert(old, at: 0)
        // 4.旧值视图恢复状态
        reset3DAnimateState(old.layer)
    }
    
    /// 顶部动画结束回调
    private func topAniCallback()  {
        resetTopOldView()
        startBottomAnimte()
    }
    
    func removeBottomAnimation()  {
        let new = bottomTxts[1]
        new.layer.removeAllAnimations()
    }
    
    public func setTitle(_ content:String) {
        if content != lastText {
            setText(content)
        }
    }
    
    private func playSound() {
        playSoundAction?()
//        guard let v = UserDefaults.standard.value(forKey: Constants.key.volum) as? Int else {
//            SoundManager.manager.playFlappingSound()
//            return
//        }
//        guard let type = SoundVolum.init(rawValue: v) else{
//            SoundManager.manager.playFlappingSound()
//            return
//        }
//        SoundManager.manager.playFlappingSound(type)
    }
    
    // 动态显示文字内容
    private func setText(_ content:String, _ animated:Bool = true) -> Void {
        if animated {
            playSound()
        }
        if isTopTiming {
            timer?.invalidate()
            isTopTiming = false
            setText(lastText, false)
        }
        if isBottomTiming {
            removeBottomAnimation()
            bottomTimer?.invalidate()
            isBottomTiming = false
            setText(lastText, false)
        }
        // 1.set newvavlue
        let new = topTxts[0]
        new.text = content;
        let newb = bottomTxts[0]
        newb.text = content
        
        if animated {
            // 2.old value
            startTopAnimate(completed:{[weak self] in
                self?.topAniCallback()
            })
        }else{
            loadNextText()
        }
        lastText = content
    }
    
    func loadNextText() {
        resetTopOldView()
        reloadNewBottom()
    }
    
    func reloadNewBottom()  {
        let new = bottomTxts[0]
        bringSubviewToFront(new)
        bottomTxts.remove(at: 0)
        bottomTxts.append(new)
    }
}

enum HalfViewType {
    case top, bottom
}

class HalfView: UIView {
    private var title:UILabel = UILabel()
    private var baseline:UIView = UIView()
    
    var text:String = "" {
        didSet{
            if text.count == 1 {
                title.text = text
                return
            }
            if let d = text.first {
               let c = String.init(d)
                title.text = c
            }
        }
    }
    
    var font:UIFont = UIFont.systemFont(ofSize: 50) {
        didSet{
            title.font = font
        }
    }
    
    var titleColor:UIColor = UIColor.white {
        didSet{
            title.textColor = titleColor
        }
    }
    
    var titleBackgroundColor:UIColor = UIColor.gray {
        didSet{
            title.backgroundColor = titleBackgroundColor
        }
    }
    
    var cornerRadius:CGFloat = 4 {
        didSet{
            if #available(iOS 11.0, *) {
                self.layer.cornerRadius = cornerRadius
            }
        }
    }
    
    let type:HalfViewType
    
    required init(type:HalfViewType) {
        self.type = type
        super.init(frame: CGRect.zero)
        configSubViews()
        configLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLine()  {
        addSubview(baseline)
        baseline.backgroundColor = self.titleBackgroundColor
    }
    
    func configCorner()  {
        self.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            if type == .top {
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }else{
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    func configIos11BeforeCorner(){
        if #available(iOS 11.0, *) { }else{
            let shap = CAShapeLayer.init()
            let path : UIBezierPath
            if type == .top {
                path = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
            }else{
                path = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
            }
            shap.path = path.cgPath
            self.layer.mask = shap
        }
    }
    
    fileprivate func colorRGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    fileprivate func configSubViews() {
        addSubview(title)
        title.font = UIFont.systemFont(ofSize: 80)
        title.textAlignment = .center
        self.layer.masksToBounds = true;
        titleBackgroundColor = colorRGBA(r: 26, g: 26, b: 26, a: 1)
        titleColor = UIColor.white
        
        configCorner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .top:
            title.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.bounds.size.width, height: self.bounds.size.height * 2))
            baseline.frame = CGRect.init(origin: CGPoint.init(x: 0, y: self.bounds.size.height - 2), size: CGSize.init(width: self.bounds.size.width, height: 2))
        default:
            title.frame = CGRect.init(origin: CGPoint.init(x: 0, y: -self.bounds.size.height), size: CGSize.init(width: self.bounds.size.width, height: self.bounds.size.height * 2))
            baseline.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.bounds.size.width, height: 2))
        }
        configIos11BeforeCorner()
    }
}

