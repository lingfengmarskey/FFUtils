//
//  ViewController.swift
//  FFUtils
//
//  Created by Marcos Meng on 01/10/2020.
//  Copyright (c) 2024 Marcos Meng. All rights reserved.
//

import UIKit
import FFUtils

class ViewController: UIViewController {

    var flip:FlippingView?
    var texts = ["A", "B", "C", "D"]
    var idx:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createView()
    }
    
    func createView() {
        let v = FlippingView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 200))
        view.addSubview(v)
        v.text = "O"
        flip = v
    }
    
    func getIdx() -> String {
        if idx >= texts.count {
            idx = 0
        }
        let res = texts[idx]
        idx += 1
        return res
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        flip?.setTitle(getIdx())
        flip?.playSoundAction = {
            print("play sound")
        }
        present(UIAlertController.makeInputAlert(title: "title", message: "message", cancelTitle: "cancel", okTitle: "ok", completion: { result in
            print("result is \(result)")
        }), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

