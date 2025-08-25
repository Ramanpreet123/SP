#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
#      target.build_configurations.each do |config|
#          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
#      end
#    end
#  end
#end

post_install do |installer|
  # fix xcode 15 DT_TOOLCHAIN_DIR - remove after fix oficially - https://github.com/CocoaPods/CocoaPods/issues/12065
  installer.aggregate_targets.each do |target|
      target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
  end

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
          xcconfig_path = config.base_configuration_reference.real_path
          IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
  end
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target 'SearchPoint' do

pod 'AKSideMenu'
pod 'Alamofire', '~> 5.0.0-rc.2'
pod 'FirebaseCore'
pod 'Firebase/Crashlytics'
pod 'Firebase/Messaging'
pod 'FirebaseAnalytics'
pod 'GoogleMLKit/BarcodeScanning'
pod 'GoogleMLKit/TextRecognition'
pod 'FirebaseStorage'
pod 'FirebaseFirestore'
pod 'FirebaseAuth'
pod 'ProgressHUD'
pod 'Swift_PageMenu'
pod 'CropViewController'
pod 'JNKeychain'
pod 'MBProgressHUD', '~> 1.1.0'
pod 'IQKeyboardManagerSwift'
pod 'DropDown', '2.3.2'
pod 'Toast-Swift', '~> 5.0.1'
pod 'Gigya' , :inhibit_warnings => true
pod 'GigyaTfa' , :inhibit_warnings => true
pod 'GigyaAuth' , :inhibit_warnings => true
end

