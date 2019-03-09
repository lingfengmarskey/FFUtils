//
//  ViewController.swift
//  TestUtils
//
//  Created by YiZhuang_iOS on 2018/12/25.
//  Copyright © 2018 Marskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let test:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test.frame = CGRect.init(origin: CGPoint.init(x: 100, y: 200), size: CGSize.init(width: 200, height: 200))
        
        test.backgroundColor = UIColor.red
        view.addSubview(test)
        
        
        
//        test.layer.
         let path = UIBezierPath.init(arcCenter: CGPoint.zero, radius: 100, startAngle: CGFloat.pi / -2, endAngle: CGFloat.pi / 2, clockwise: true)
        let layer = CALayer.init()

        
    }
    
    
    @IBAction func changeIcon(_ sender: Any) {
        guard #available(iOS 10.3, *) else {
            return
        }
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        UIApplication.shared.setAlternateIconName("fox") { (error) in
            print("===error===\(error)")
        }
    }
    

    @IBAction func changeIconGirl(_ sender: Any) {
        guard #available(iOS 10.3, *) else {
            return
        }
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        UIApplication.shared.setAlternateIconName("girl") { (error) in
            print("===error===\(error)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if #available(iOS 10.0, *) {
            Utils.impactOcor()
        } else {
            // Fallback on earlier versions
        }
    }
}

