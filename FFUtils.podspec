#
# Be sure to run `pod lib lint FFUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFUtils'
  s.version          = '0.2.4.alph-8'
  s.summary          = 'Common tools in ios development'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lingfengmarskey/FFUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcos Mang' => 'lingfengmarskey@gmail.com' }
  s.source           = { :git => 'https://github.com/lingfengmarskey/FFUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'FFUtils/Classes/*.swift'
  s.swift_version = '5.0'

  s.subspec 'FlippingView' do |sp|
    sp.source_files   = 'FFUtils/Classes/CustomView/**/*.swift'
    sp.name = "CustomView"
  end
  
  s.subspec 'Extension' do |sp|
    sp.source_files   = 'FFUtils/Classes/Extension/**/*.swift'
    sp.name = "Extension"
    
    sp.subspec '' do |ssp|
        ssp.source_files   = 'FFUtils/Classes/Extension/Stable/*.swift'
        ssp.name = "Stable"
    end
    sp.subspec '' do |ssp|
           ssp.source_files   = 'FFUtils/Classes/Extension/Main/*.swift'
           ssp.name = "Main"
       end
  end
  
  s.subspec 'KeyBoard' do |sp|
    sp.source_files   = 'FFUtils/Classes/KeyBoard/**/*.swift'
    sp.name = "KeyBoard"
  end
  
  s.subspec 'Speecher' do |sp|
    sp.source_files   = 'FFUtils/Classes/Services/**/*.swift'
    sp.name = "Services"
  end
  
  s.subspec 'AppIcon' do |sp|
    sp.source_files   = 'FFUtils/Classes/AppIcon/*.swift'
    sp.name = "AppIcon"
  end
  
  s.subspec 'Table' do |tb|
    tb.source_files = 'FFUtils/Classes/Table/*.swift'
    tb.name = "Table"
    tb.dependency 'FFUtils/Extension'
  end
  
  s.subspec 'Collection' do |ct|
    ct.source_files = 'FFUtils/Classes/Collection/*.swift'
    ct.name = "Collection"
  end

  s.default_subspecs = 'Extension', 'KeyBoard', 'Table', 'Collection'
end
