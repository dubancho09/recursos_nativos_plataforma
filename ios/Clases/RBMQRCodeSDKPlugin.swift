import UIKit
import Flutter
import RBMQRCodeSDK
import AVFoundation


public class RBMQRCodeSDKPlugin: NSObject, FlutterPlugin, QrLicenseCallback {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "sample.flutter/readQR", binaryMessenger: registrar.messenger())
        let instance = RBMQRCodeSDKPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initializeLibrary":
            initializeLibrary(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func initializeLibrary(result: FlutterResult) {
        let manager = QrManagerImp()
        manager.initializeLibrary(
            "ejemplo",
            publicKey: "ejemplo",
            license: "ejemplo",
            callbackLicense: self
        )
        result("Library Initialized")
    }

    
    public func checkInitializeScan(_ start: Bool) {
        //!Unimplemented method
    }

    public func onErrorShow(_ errorType: Int, message: String) {
        //!Unimplemented method
    }
}