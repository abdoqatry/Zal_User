# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Zal_User' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Zal_User


  pod 'Alamofire', '~> 5.2'
  pod 'SwiftyJSON', '~> 4.2'
  pod 'IQKeyboardManagerSwift', '6.5.5'
  pod 'RappleProgressHUD'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Cosmos'
  
 pod 'Kingfisher', '~> 7.0'
pod 'ImageSlideshow'
 pod "ImageSlideshow/Kingfisher"

pod 'DKImagePickerController', :subspecs => ['PhotoGallery', 'Camera', 'InlineCamera']

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
           config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
           config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end

end
