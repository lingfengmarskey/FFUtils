#
# Be sure to run `pod lib lint FFUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFUtils'
  s.version          = '0.2.3.beta-1'
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

  s.source_files = 'FFUtils/Classes/**/*.swift'
  s.swift_version = '5.0'
  
#  spec.module_name   = 'Rich'

  s.subspec 'FlippingView' do |sp|
    sp.source_files   = 'FFUtils/Classes/CustomView/**/*.swift'
    sp.name = "CustomView"
  end
  
  s.subspec 'Extension' do |sp|
    sp.source_files   = 'FFUtils/Classes/Extension/**/*.swift'
    sp.name = "Extension"
  end
  
  s.subspec 'KeyBoard' do |sp|
    sp.source_files   = 'FFUtils/Classes/KeyBoard/**/*.swift'
    sp.name = "KeyBoard"
  end
  
  s.subspec 'Speecher' do |sp|
    sp.source_files   = 'FFUtils/Classes/Services/**/*.swift'
    sp.name = "Services"
  end
  
  s.subspec 'Utils' do |sp|
    sp.source_files   = 'FFUtils/Classes/Utils/**/*'
    sp.name = 'Utils'
    sp.dependency 'FFUtils/Extension'
  end
  
  # s.resource_bundles = {
  #   'FFUtils' => ['FFUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
