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
            "https://lab-vssh2.validsolutions.com.br/api-gateway/",
            publicKey: "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEp+dJu1XlF734dVisYtAD8FHymgtrGWV768D1qwNHnfzZMnj4aoDUd+w+xfqvMHzqpdjH8oRbFPRSXnzoMccI2FqqmTDOc6R95cEdmsyILXTo3EjWVqF5JtqRZrUmfO1wQ6OnGnnYRvl4X2Y7QMkY9r3NtNaAXN9OczHCtHbH7wIDAQAB",
            license: "db2f6bzzb853a42255179a2a61bc26dac9c9b5ba599556e8710aa8d01f579433b278fc9de33396ffac3f45820f06229895f2febce013fe1d28955384d8ccac82eab7a6cdd08500f057032ee1fe84411bd845395ddb12e41feec5a52d2af7c657ab93561a9c9f1df2321b176a0e18e710e27305b994b188bc4d32c27aba4a95ba2ade1043",
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