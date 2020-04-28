# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def google_utilites
  pod 'GoogleUtilities/AppDelegateSwizzler'
  pod 'GoogleUtilities/Environment'
  pod 'GoogleUtilities/ISASwizzler'
  pod 'GoogleUtilities/Logger'
  pod 'GoogleUtilities/MethodSwizzler'
  pod 'GoogleUtilities/NSData+zlib'
  pod 'GoogleUtilities/Network'
  pod 'GoogleUtilities/Reachability'
  pod 'GoogleUtilities/UserDefaults'
end
target 'CoronaCare' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # use_modular_headers!
  
  pod 'ConcentricOnboarding'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'SDWebImage', '~> 5.0'
  pod 'Hero'
  pod 'Stellar', :git => 'https://github.com/AugustRush/Stellar.git'
  pod 'CBFlashyTabBarController'
  pod 'lottie-ios'
  pod 'Permission/Notifications'
  pod 'Permission/Location'
  pod 'Cards'
  pod 'SDWebImage'
  pod 'BEKMultiCellTable', :git => 'https://github.com/behrad-kzm/BEKMultiCellTable.git'
  pod 'HGCircularSlider'
  pod 'StepSlider'
  pod "SwiftRater"
  pod 'SemiModalViewController'
  pod 'Google-Mobile-Ads-SDK'
  pod 'Siren', :git => 'https://github.com/ArtSabintsev/Siren.git', :branch => 'swift5.0' # Swift 5.0
  google_utilites
  # Pods for CoronaCare
  
  target 'LocationManager' do
    
    target 'LocationManagerTests' do
      pod 'Nimble'
    end
    
  end
  target 'NotificationPlatform' do
    pod 'SwiftLocalNotification'
  end
  
  target 'AnalyticPlatform' do
    pod 'Firebase'
    pod 'Firebase/Analytics'
    pod 'Firebase/Crashlytics'
    pod 'FCUUID'
    google_utilites
  end
  
end
