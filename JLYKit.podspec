Pod::Spec.new do |s|

s.name = 'JLYKit'
s.version = '0.3.0'
s.license = 'MIT'
s.summary = 'A simple framework on iOS.'
s.homepage = 'https://github.com/HappyiOSYuan/JLYKit'
s.authors = { '宁袁' => '1294752518@qq.com' }
s.source = { :git => 'https://github.com/HappyiOSYuan/JLYKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.platform = :ios
s.ios.deployment_target = "8.0"
s.source_files = 'JLYKit/Classes/**/*'
s.public_header_files = 'JLYKit/Classes/**/*.h'
s.frameworks = 'UIKit','ImageIO','QuartzCore','Security','CoreGraphics','Foundation','SystemConfiguration'

s.dependency 'AFNetworking'
s.dependency 'MLInputDodger', '~>1.4.0'
s.dependency 'Reachability'
s.dependency 'SDAutoLayout'
s.dependency 'SDWebImage'
s.dependency 'Masonry'
s.dependency 'DGActivityIndicatorView'
s.dependency 'ISHPermissionKit'
s.dependency 'SVProgressHUD'
s.dependency 'MJRefresh'
s.dependency 'JDStatusBarNotification'

end
