import UIKit
import Flutter
import GoogleMaps  // Add this import
import FBSDKCoreKit  // appinio_social_share

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyBJwhcf6gJJFZ6gqRI63Py_F1PoMuUFLPM")

    FBSDKCoreKit.ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
        )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}