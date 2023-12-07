# Flutter Basic App

Flutter Basic App

## Getting Started

Setup firebase project 
add all firebase login options needed

run fvm flutter pub get
run fvm flutter pub run build_runner build --delete-conflicting-outputs
flutterfire configure 
setup firebase Notification for Ios and Android (certficate)
uncomment the update FCM token function in home page after implementing the needed endpoint
setup ios and android spesific setting for google sign in if needed
setup ios and android spesific setting for facebook sign in if needed
setup ios and android spesific setting for apple sign in if needed
After implementing the sign in and sign up endpoints uncomment the endpoint function in Register And Login Page and in google , facebook , Apple sign in function.

remove dummy from config files and setup lib/utils/env.dart 
add baseUrl for api 
dev.config
production.config

Android spesific
remove dummy from key.properties and set the right properties

use Build sh files to build the project based on the enviroment needed
