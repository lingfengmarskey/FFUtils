//
//  ViewController.swift
//  TestUtils
//
//  Created by YiZhuang_iOS on 2018/12/25.
//  Copyright © 2018 Marskey. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate {

    let test:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test.frame = CGRect.init(origin: CGPoint.init(x: 100, y: 200), size: CGSize.init(width: 200, height: 200))
        
        test.backgroundColor = UIColor.red
        view.addSubview(test)
        
        // for test
        
//        let productid = ""
//        let proIdSet = Set.init([productid])
//        let request = SKProductsRequest.init(productIdentifiers: proIdSet)
//        request.delegate  = self
//        request.start()
//
//        let priceFormatter =  NumberFormatter.init()
//        priceFormatter.formatterBehavior = .behavior10_4
//        priceFormatter.numberStyle = .currency
//
//        let product = SKProduct.init()
//
//        priceFormatter.locale = product.priceLocale
        
//        guard let formattedPrice = priceFormatter.string(from: product.price) else{return}
//
//        print("formatedPrice--->\(formattedPrice)")
        
        //
//        let path = Bundle.main.resourcePath
//        print("--resourcePath:\(path)")
        Utils.FFLog("hello world")

    }
    
    func addApayment(pro:SKProduct)  {
        let  payment = SKMutablePayment.init(product: pro)
        payment.applicationUsername = "userIdUniqueAndOpaqueForAppleDetactingFraud"
        payment.quantity = 3
        SKPaymentQueue.default().add(payment)
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    
//        let invalidProducts = response.invalidProductIdentifiers
//        let products = response.products
        
    }
    
    
    
    
    @IBAction func changeIcon(_ sender: Any) {
        guard #available(iOS 10.3, *) else {
            return
        }
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        UIApplication.shared.setAlternateIconName("fox") { (error) in
//            print("===error===\(error)")
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
//            print("===error===\(error)")
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

