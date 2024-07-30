import UIKit
import Flutter



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let registrar = self.registrar(forPlugin: "RBMQRCodeSDKPlugin") {
        RBMQRCodeSDKPlugin.register(with: registrar)
    } else {
        print("Error: Registrar not found for plugin RBMQRCodeSDKPlugin")
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
