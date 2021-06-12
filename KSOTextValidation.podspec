Pod::Spec.new do |s|
  s.name             = 'KSOTextValidation'
  s.version          = '2.0.1'
  s.summary          = 'KSOTextValidation is an iOS/tvOS framework for as the user types validation of textual input in UITextField.'
  s.description      = <<-DESC
KSOTextValidation is an iOS/tvOS framework for as the user types validation of textual input in `UITextField`. It provides a category method on UITextField and a protocol for objects conforming to the necessary text validation methods.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/KSOTextValidation'
  s.license          = { :type => 'Apache 2.0', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/KSOTextValidation.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'

  s.source_files = 'KSOTextValidation/**/*.{h,m}'
  s.exclude_files = 'KSOTextValidation/KSOTextValidation-Info.h'
  s.private_header_files = 'KSOTextValidation/Private/*.h'
  
  s.resource_bundles = {
    'KSOTextValidation' => ['KSOTextValidation/**/*.{xcassets,lproj}']
  }

  s.frameworks = 'UIKit'
  
  s.dependency 'Agamotto'
  s.dependency 'Ditko'
  s.dependency 'Stanley'
  
  s.ios.dependency 'KSOTooltip', '~> 3.0'
end
