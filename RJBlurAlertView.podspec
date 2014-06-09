#
#  Be sure to run `pod spec lint RJBlurAlertView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "RJBlurAlertView"
  s.version      = "0.0.1"
  s.summary      = "RJBlurAlertView is a custom alert view with a blurred background view.It can be showed as dropping or bounce."
  s.homepage     = "https://github.com/wuleijun/RJBlurAlertView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "rayjune" => "wuleijun8@gmail.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/wuleijun/RJBlurAlertView.git", :commit => 'e449aa1f1d8b011b0e0141d83765230b309b9e7e' }
  s.source_files  = "RJBlurAlertView/RJBlurAlertViews/**/*.{h,m}"
  s.requires_arc = true
  s.dependency 'GPUImage', '~> 0.1.4'
end
