platform :ios, "7.0"
xcodeproj 'Travel Conversation.xcodeproj'
# user interface
pod 'QBFlatButton'
pod 'SwipeView'
pod 'TTTAttributedLabel'
# Font
pod 'ionicons'

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Pods-acknowledgements.plist', 'Travel Conversation/Resources/Plists/acknowledgements.plist', :remove_destination => true)
end
