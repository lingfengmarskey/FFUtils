//
//  FFSpeecher.swift
//  TestFlapping
//
//  Created by marskey on 2019/3/28.
//  Copyright © 2019 Marskey. All rights reserved.
//

import Foundation
import AVFoundation



public  enum FFSpeechRate:String {
    case low = "rate : 0.5"
    case normal = "rate : 1.0"
    case littleFast = "rate : 1.5"
    case fast = "fate : 2"
    
    var value:Float {
        switch self {
        case .low:
            return AVSpeechUtteranceDefaultSpeechRate - 0.1
        case .normal:
            return  AVSpeechUtteranceDefaultSpeechRate
        case .littleFast:
            return  AVSpeechUtteranceDefaultSpeechRate + 0.1
        case .fast:
            return  AVSpeechUtteranceDefaultSpeechRate + 0.2
        }
    }
}


public final class FFSpeecher: NSObject {
    
    public static let reader = FFSpeecher.init()
    
    public let rates:[FFSpeechRate] = [.low, .normal, .littleFast, .fast]
    
    public var readingModify = false
    
    public var curRate:FFSpeechRate = FFSpeechRate.normal {
        didSet{
            configRate(curRate)
        }
    }
    
    public var currentVoice = AVSpeechSynthesisVoice.init() {
        didSet {
            configVoice(currentVoice)
        }
    }
 
    
    public var currentLocation:Int = 0
    
    public var isReading:Bool {
        return speechSythesizer.isSpeaking
    }
    
    public var isPaused:Bool {
        return speechSythesizer.isPaused
    }
    
    public var voices:[AVSpeechSynthesisVoice] {
        return AVSpeechSynthesisVoice.speechVoices()
    }
    
    public var willSpeakLocation:((Int)->Void)?
    
    private var utterance:AVSpeechUtterance?
    private var speechSythesizer = AVSpeechSynthesizer.init()
    private var readContent:String = ""
    
    
    
    override init() {
        super.init()
        speechSythesizer.delegate = self
    }
    
    // MARK: Public Method
    
    /// speak start
    ///
    /// - Parameter content: String
    public func speak(_ content:String) {
        
        initlizeContent(content)
        
        speechSythesizer.speak(utterance!)
    }
    
    /// Pause immediately
    public func pause() -> Void {
        if isReading == false {return}
        speechSythesizer.pauseSpeaking(at: .immediate)
    }
    
    /// Continue if it's speaking
    public func continueSpeaking()  {
        if isReading == false {return}
        speechSythesizer.continueSpeaking()
    }
    
    /// Stop reading
    public func stop() {
        speechSythesizer.stopSpeaking(at: .immediate)
    }
    
    
    // MARK: PrivateMethod
    fileprivate func initlizeContent(_ content:String) -> Void {
        readContent = content
        
        utterance = AVSpeechUtterance.init(string: content)
        
        configuration()
    }
    
    fileprivate func configuration()  {
        utterance?.rate = curRate.value
        utterance?.voice = currentVoice
    }
    
    fileprivate func configRate(_ newValue:FFSpeechRate) -> Void {
        if isReading  {
            readingModify = true
            stop()
        }
        utterance?.rate = newValue.value
    }
    
    
    fileprivate func configVoice(_ newValue:AVSpeechSynthesisVoice) {
        if isReading {
            readingModify = true
            stop()
        }
        utterance?.voice = newValue
    }
    
    
}

extension FFSpeecher :AVSpeechSynthesizerDelegate {
    
    public  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        currentLocation = characterRange.location
        self.willSpeakLocation?(characterRange.location)
        
    }
    
    public  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        if readingModify == false {return}
        resumRead()
    }
    
    
    private func resumRead()  {
        let range = readContent.index(readContent.startIndex, offsetBy: currentLocation) ..< readContent.endIndex
        let substring = readContent[range]
        let curString = String(substring)
        speak(curString)
    }
    
    
}
