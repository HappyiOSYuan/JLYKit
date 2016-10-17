Pod::Spec.new do |s|

s.name = 'JLYKit'
s.version = '0.4.3'
s.license = 'MIT'
s.summary = 'A simple framework on iOS.'
s.homepage = 'https://github.com/HappyiOSYuan/JLYKit'
s.authors = { '宁袁' => '1294752518@qq.com' }
s.source = { :git => 'https://github.com/HappyiOSYuan/JLYKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.platform = :ios
s.ios.deployment_target = "8.0"
s.frameworks = 'UIKit','ImageIO','QuartzCore','Security','CoreGraphics','Foundation','SystemConfiguration'

s.subspec 'AppDelegate' do |appDelegate|
    appDelegate.source_files = 'JLYKit/Classes/AppDelegate/**/*.{h,m}'
    appDelegate.dependency 'Reachability'
    appDelegate.dependency 'MLInputDodger', '~>1.4.0'
	appDelegate.dependency 'SDAutoLayout'
	appDelegate.dependency 'Masonry'
	appDelegate.dependency 'SVProgressHUD'
    appDelegate.dependency 'JLYKit/JLYBaseKit'
  end
  
s.subspec 'JLYBaseKit' do |baseKit|
    baseKit.source_files = 'JLYKit/Classes/JLYBaseKit/{BaseTableViewCell,BaseTableViewDataSource,BaseViewController}/**/*.{h,m}'
    baseKit.dependency 'MJRefresh'
    baseKit.dependency 'MLInputDodger'
	baseKit.dependency 'DGActivityIndicatorView'
  end 
  
s.subspec 'JLYVIPER' do |viper|
    viper.source_files = 'JLYKit/Classes/JLYVIPER/**/*.{h,m}'
    viper.dependency 'JLYKit/JLYURLRouter'
  end  
 
s.subspec 'JLYBaseViewModel' do |viewmodel|
    viewmodel.source_files = 'JLYKit/Classes/JLYBaseViewModel/**/*.{h,m}'
  end
  
s.subspec 'JLYNetworking' do |networking|
    networking.source_files = 'JLYKit/Classes/JLYNetworking/**/*.{h,m}'
    networking.dependency 'AFNetworking'
  end 
 
s.subspec 'UIExtensions' do |ui|
    ui.source_files = 'JLYKit/Classes/UIExtensions/**/*.{h,m}'
    ui.dependency 'JDStatusBarNotification'
  end

s.subspec 'FoundationExtensions' do |foundation|
    foundation.source_files = 'JLYKit/Classes/FoundationExtensions/**/*.{h,m}'
  end

s.subspec 'JLYURLRouter' do |router|
    router.source_files = 'JLYKit/Classes/JLYURLRouter/**/*.{h,m}'
  end 
  
s.subspec 'Vender' do |vender|
    vender.source_files = 'JLYKit/Classes/Vender/{JLYAlert,JLYCountDownButton,JLYForm,JLYGrowingTextView,JLYMaterialTextFeild,JLYPopMenu,RMActionController}/**/*.{h,m}'
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
  end  
  
s.dependency 'SDWebImage'
s.dependency 'ISHPermissionKit'

end
