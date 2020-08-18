Pod::Spec.new do |s|
  s.name         = "HQJToolManager"
  s.version      = "0.0.2"
  s.summary      = "个人使用的工具类"
  s.description  = <<-DESC
                      this project provide all kinds of categories for iOS developer
                   DESC
  s.homepage     = "https://github.com/xzw717/HQJToolManage"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "谢增文" => "xiezw94@126.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/xzw717/HQJToolManage.git", :tag => "0.0.2" }
  s.source_files  = "Classes", "HQJToolManager/Classes/Tool/*.{h,m}","HQJToolManager/Classes/View/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  #s.public_header_files = "iOS_Category/Classes/UIKit/UI_Categories.h""iOS_Category/Classes/Foundation/Foundation_Category.h"，"iOS_Category/Classes/**/*.h"
  s.requires_arc = true
  s.dependency 'Masonry'
end
