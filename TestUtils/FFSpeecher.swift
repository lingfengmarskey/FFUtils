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


public class FFSpeecher: NSObject {
    
    static let reader = FFSpeecher.init()
    
    let rates:[FFSpeechRate] = [.low, .normal, .littleFast, .fast]
    
    var readingModify = false
    
    var curRate:FFSpeechRate = FFSpeechRate.normal {
        didSet{
            configRate(curRate)
        }
    }
    
    var currentVoice = AVSpeechSynthesisVoice.init() {
        didSet {
            configVoice(currentVoice)
        }
    }
 
    
    var currentLocation:Int = 0
    
    var isReading:Bool {
        return speechSythesizer.isSpeaking
    }
    
    var isPaused:Bool {
        return speechSythesizer.isPaused
    }
    
    var voices:[AVSpeechSynthesisVoice] {
        return AVSpeechSynthesisVoice.speechVoices()
    }
    
    var willSpeakLocation:((Int)->Void)?
    
    private var utterance:AVSpeechUtterance?
    private var speechSythesizer = AVSpeechSynthesizer.init()
    private var readContent:String = ""
    
    
    
    override init() {
        super.init()
        speechSythesizer.delegate = self
    }
    
    // MARK: Public Method
    
    public func speak(_ content:String) {
        
        initlizeContent(content)
        
        speechSythesizer.speak(utterance!)
    }
    
    public func pause() -> Void {
        speechSythesizer.pauseSpeaking(at: .immediate)
    }
    
    public func continueSpeaking()  {
        speechSythesizer.continueSpeaking()
    }
    
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
    
    private  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        currentLocation = characterRange.location
        self.willSpeakLocation?(characterRange.location)
        
    }
    
    private  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
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
