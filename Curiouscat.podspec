#
#  Be sure to run `pod spec lint Curiouscat.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "Curiouscat"
  s.version      = "0.0.1"
  s.summary      = "The GitHub README WebView."
  s.description  = <<-DESC
  Change the GitHub Markdown css style, to parse my theme.
                   DESC
  s.homepage     = "https://www.desgard.com"
  s.license      = "GPL-3.0"
  s.author             = { "Harry Duan" => "gua@desgard.com" }
  s.source       = { :git => "https://github.com/Sepicat/Curiouscat.git" }
  s.source_files  = "Curiouscat/Curiouscat/**/*.{swift}"
  s.resource = "Curiouscat/Curiouscat/**/*.{js}"
  s.dependency 'SnapKit', '~> 4.0.0'
  s.dependency 'KVOController', '~> 1.2.0'

end
