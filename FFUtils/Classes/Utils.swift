//
//  Utils.swift
//  TestUtils
//
//  Created by marskey on 2018/12/25.
//  Copyright © 2018 Marskey. All rights reserved.
//

import Foundation
import UIKit

public class Utils {

    /// Log Method
    ///
    /// - Parameters:
    ///   - message: Customized Message
    ///   - file: fileName
    ///   - method: methodName
    ///   - line: code line Number
    public static func FFLog<T>(_ message: T,
                         file: String = #file,
                         method: String = #function,
                         line: Int = #line)
    {
        #if DEBUG
        
        print(">>>>>>>>   FFLOG:   \((file as NSString).lastPathComponent)[\(line)], \(method)   \n \(message)   <<<<<<<<")
        
        
        #endif
    }
    /// 验证合法URL String
    ///
    /// - Parameter urlstring: String validating
    /// - Returns: isValidate
    public static func validateUrl(_ urlstring:String) -> Bool {
        guard let url = URL.init(string: urlstring) else{return false}
        if url.host == nil { return false }
        if url.scheme == nil { return false }
        return true
    }
    
}

extension Utils {
    
    // 重新获取图片尺寸
    public static func resizeImage(image:UIImage, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        image.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 获取指定颜色的的图片
    ///
    /// - Parameters:
    ///   - rect: rectagle
    ///   - color: UIColor
    /// - Returns: UIImage Objc
    public static func getImage(_ rect:CGRect, from color:UIColor) -> UIImage?{
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
//    func getIsMuted() -> Bool {
//        let route:String = ""
////        let status =
////          UInt32 routeSize = sizeof(CFStringRef);
////
////          OSStatus status = AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &routeSize, &route);
////          if (status == kAudioSessionNoError)
////              {
////                    if (route == NULL || !CFStringGetLength(route))
////                      return TRUE;
////                  }
////
//          return false;
//    }
    
    @available(iOS 10.0, *)
    public class func impactOcor()  {
            let impactor  = UIImpactFeedbackGenerator.init(style: .light)
            impactor.impactOccurred()
    }
    
}



