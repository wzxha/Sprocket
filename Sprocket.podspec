#
# Be sure to run `pod lib lint Sprocket.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Sprocket'
  s.version          = '0.1.0'
  s.summary          = 'State machine on swift'
  s.description      = <<-DESC
Sprocket is State machine on Swift4.0
                       DESC

  s.homepage         = 'https://github.com/Wzxhaha/Sprocket'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wzxhaha' => 'wzxjiang@foxmail.com' }
  s.source           = { :git => 'https://github.com/Wzxhaha/Sprocket.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sprocket/Classes/**/*'
end
