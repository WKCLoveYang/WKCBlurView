Pod::Spec.new do |s|
s.name         = "WKCBlurView"
s.version      = "1.1.1"
s.summary      = "模糊视图"
s.homepage     = "https://github.com/WKCLoveYang/WKCBlurView.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCBlurView.git", :tag => "1.1.1" }
s.source_files  = "WKCBlurView/**/*.{h,m}"
s.public_header_files = "WKCBlurView/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true
end
