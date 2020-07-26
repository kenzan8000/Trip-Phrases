platform :ios, "12.0"

target_name = 'Travel Conversation'

use_frameworks!
project target_name

target target_name do
  # user interface
  pod 'QBFlatButton'
  pod 'SwipeView'
  pod 'TTTAttributedLabel'
  # Font
  pod 'ionicons'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end

