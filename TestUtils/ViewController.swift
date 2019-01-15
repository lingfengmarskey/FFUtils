//
//  ViewController.swift
//  TestUtils
//
//  Created by YiZhuang_iOS on 2018/12/25.
//  Copyright © 2018 Marskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}

