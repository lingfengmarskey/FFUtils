Pod::Spec.new do |s|
  s.name             = 'FFUtils'
  s.version          = '0.1.0'
  s.summary          = '测试摘要'
  s.description      = <<-DESC
更多行的
摘要
                       DESC
  s.swift_version    = '4.2'
  s.homepage         = 'https://github.com/lingfengmarskey/FFUtils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lingfengmarskey' => 'martinorth713@gmail.com' }
  s.source           = { :git => 'https://github.com/lingfengmarskey/FFUtils.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'TestUtils/Utils.swift'
end