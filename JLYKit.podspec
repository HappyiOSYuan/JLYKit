Pod::Spec.new do |s|

s.name = 'JLYKit'
s.version = '0.5.7'
s.license = 'MIT'
s.summary = 'A simple framework on iOS.'
s.homepage = 'https://github.com/HappyiOSYuan/JLYKit'
s.authors = { '宁袁' => '1294752518@qq.com' }
s.source = { :git => 'https://github.com/HappyiOSYuan/JLYKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.platform = :ios
s.ios.deployment_target = "8.0"
s.frameworks = 'UIKit','ImageIO','QuartzCore','Security','CoreGraphics','Foundation','SystemConfiguration'

s.subspec 'Config' do |config|
    config.source_files = 'JLYKit/Classes/Config/**/*.{h,m}'
    config.dependency 'Reachability'
    config.dependency 'MLInputDodger', '~>1.4.0'
	config.dependency 'SDAutoLayout'
	config.dependency 'Masonry'
	config.dependency 'SVProgressHUD'
    config.dependency 'JDStatusBarNotification'
    config.dependency 'JLYKit/UIExtensions'
    config.dependency 'JLYKit/Vender'
    config.dependency 'JLYKit/AppUtils'
    config.dependency 'JLYKit/JLYLaunchAnimation'
    config.dependency 'JLYKit/JLYVIPER'
  end
  
s.subspec 'AppDelegate' do |appDelegate|
    appDelegate.source_files = 'JLYKit/Classes/AppDelegate/**/*.{h,m}'
    appDelegate.dependency 'Reachability'
  end
  
s.subspec 'JLYBaseKit' do |baseKit|
    baseKit.source_files = 'JLYKit/Classes/JLYBaseKit/{BaseTableViewCell,BaseTableViewDataSource,BaseViewController}/**/*.{h,m}'
    baseKit.dependency 'MJRefresh'
    baseKit.dependency 'JLYKit/Config'
    baseKit.dependency 'JLYKit/JLYVIPER'
    baseKit.dependency 'JLYKit/UIExtensions'
    baseKit.dependency 'JLYKit/FoundationExtensions'
	baseKit.dependency 'DGActivityIndicatorView'
  end 
  
s.subspec 'JLYVIPER' do |viper|
    viper.source_files = 'JLYKit/Classes/JLYVIPER/**/*.{h,m}'
    viper.dependency 'JLYKit/JLYURLRouter'
    viper.dependency 'JLYKit/UIExtensions'
    viper.dependency 'JLYKit/AppDelegate'
  end  
 
s.subspec 'JLYBaseViewModel' do |viewmodel|
    viewmodel.source_files = 'JLYKit/Classes/JLYBaseViewModel/**/*.{h,m}'
    viewmodel.dependency 'JLYKit/JLYURLRouter'
  end
  
s.subspec 'JLYNetworking' do |networking|
    networking.source_files = 'JLYKit/Classes/JLYNetworking/**/*.{h,m}'
    networking.dependency 'AFNetworking'
    networking.dependency 'JLYKit/FoundationExtensions'
  end 
 
s.subspec 'UIExtensions' do |ui|
    ui.source_files = 'JLYKit/Classes/UIExtensions/**/*.{h,m}'
    ui.dependency 'JDStatusBarNotification'
    ui.dependency 'JLYKit/FoundationExtensions'
    ui.dependency 'SVProgressHUD'
  end

s.subspec 'FoundationExtensions' do |foundation|
    foundation.source_files = 'JLYKit/Classes/FoundationExtensions/**/*.{h,m}'
  end

s.subspec 'JLYURLRouter' do |router|
    router.source_files = 'JLYKit/Classes/JLYURLRouter/**/*.{h,m}'
  end 
  
s.subspec 'Vender' do |vender|
    vender.source_files = 'JLYKit/Classes/Vender/{JLYAlert,JLYCountDownButton,JLYForm,JLYGrowingTextView,JLYMaterialTextFeild,JLYPopMenu,RMActionController,JLYNavigationSubtitleView}/**/*.{h,m}'
    vender.dependency 'SDAutoLayout'
  end
  
s.subspec 'JLYLaunchAnimation' do |animation|
    animation.source_files = 'JLYKit/Classes/JLYLaunchAnimation/**/*.{h,m}'
  end 
  
s.subspec 'YYModel' do |model|
    model.source_files = 'JLYKit/Classes/YYModel/**/*.{h,m}'
  end
  
s.subspec 'AppUtils' do |utils|
    utils.source_files = 'JLYKit/Classes/AppUtils/**/*.{h,m}'
    utils.dependency 'JLYKit/FoundationExtensions'
    utils.dependency 'JLYKit/UIExtensions'
    utils.dependency 'SVProgressHUD'
  end  
  
s.dependency 'SDWebImage'
s.dependency 'ISHPermissionKit'

end
