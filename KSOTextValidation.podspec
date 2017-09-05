#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KSOTextValidation'
  s.version          = '0.3.3'
  s.summary          = 'KSOTextValidation is an iOS/tvOS framework for as the user types validation of textual input in UITextField.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KSOTextValidation is an iOS/tvOS framework for as the user types validation of textual input in `UITextField`. It provides a category method on UITextField and a protocol for objects conforming to the necessary text validation methods.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/KSOTextValidation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/KSOTextValidation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'

  s.source_files = 'KSOTextValidation/**/*.{h,m}'
  s.exclude_files = 'KSOTextValidation/KSOTextValidation-Info.h'
  
  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
  
  s.dependency 'Agamotto'
  s.dependency 'Ditko'
  s.dependency 'Stanley'
end
