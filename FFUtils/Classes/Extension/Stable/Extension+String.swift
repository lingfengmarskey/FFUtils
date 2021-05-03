//
//  Extension+String.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2020/1/3.
//  Copyright © 2020 MarcosMang. All rights reserved.
//

import Foundation
public extension String {
    func makeLabelAttributeString() -> NSAttributedString {
        let content = " Sustained : "
        let attributeStringContent = NSMutableAttributedString(string: content)
        attributeStringContent.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], range: NSRange(0 ..< content.count))

        let attributeStringNum = NSMutableAttributedString(string: self)
        attributeStringNum.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.backgroundColor: UIColor.green, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], range: NSRange(0 ..< count))

        attributeStringContent.append(attributeStringNum)
        return attributeStringContent
    }

    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }

        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size

        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing, spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }

        return size
    }

    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }

        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }

        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight * CGFloat(lines) + currentLineSpacing * CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }

        return size
    }

    /// String to [String: Any]
    func toDictionary() throws -> [String: Any]? {
        guard let data = self.data(using: String.Encoding.utf8),
            let dict = try JSONSerialization.jsonObject(with: data,
                                                        options: .mutableContainers) as? [String: Any]
        else { return nil }
        return dict
    }
}

import typealias CommonCrypto.CC_LONG
import func CommonCrypto.CC_MD5
import var CommonCrypto.CC_MD5_DIGEST_LENGTH

public extension String {
    func MD5() -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }

    func md5Hex() -> String {
        MD5().map { String(format: "%02hhx", $0) }.joined()
    }

    func md5Base64() -> String {
        MD5().base64EncodedString()
    }
}
