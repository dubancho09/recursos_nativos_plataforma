package com.example.redeban_qr

import android.content.ContentValues.TAG
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.content.Context
import android.hardware.Camera
import android.os.Build
import android.util.Log
import co.com.rbm.sdkqrcode.data.QrEntity
import co.com.rbm.sdkqrcode.manager.QrManagerImp
import co.com.rbm.sdkqrcode.manager.QrManagerInterface
import co.com.rbm.sdkqrcode.result.QrLicenseCallback
import co.com.rbm.sdkqrcode.result.QrManagerCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext

class MainActivity: FlutterActivity(), QrManagerCallback, QrLicenseCallback {

    private lateinit var manPresenter: QrManagerInterface
    private val CHANNEL = "sample.flutter/readQR"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->

            if (call.method == "initializeLibrary"){
                GlobalScope.launch(Dispatchers.Main) {
                    val initResult = withContext(Dispatchers.IO) { initializeLibrary() }
                    result.success(initResult)
                }
            } else if (call.method == "startScan"){
                startScan()
                result.success(null)
            }

        }
    }

    private suspend fun initializeLibrary(): String {
        val resultDeferred = CompletableDeferred<String>()
        manPresenter = QrManagerImp(this@MainActivity)
        manPresenter.initializeLibrary(
            "https://lab-vssh2.validsolutions.com.br/api-gateway/",
            "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEp+dJu1XlF734dVisYtAD8FHymgtrGWV768D1qwNHnfzZMnj4aoDUd+w+xfqvMHzqpdjH8oRbFPRSXnzoMccI2FqqmTDOc6R95cEdmsyILXTo3EjWVqF5JtqRZrUmfO1wQ6OnGnnYRvl4X2Y7QMkY9r3NtNaAXN9OczHCtHbH7wIDAQAB",
            "db2f6bzzb853a42255179a2a61bc26dac9c9b5ba599556e8710aa8d01f579433b278fc9de33396ffac3f45820f06229895f2febce013fe1d28955384d8ccac82eab7a6cdd08500f057032ee1fe84411bd845395ddb12e41feec5a52d2af7c657ab93561a9c9f1df2321b176a0e18e710e27305b994b188bc4d32c27aba4a95ba2ade1043",
            object : QrLicenseCallback {
                override fun onErrorShow(errorCode: Int, errorMessage: String?) {
                    resultDeferred.complete("Error al iniciar SDK: $errorMessage")
                }

                override fun checkInitializeScan(isInitialized: Boolean) {
                    if (isInitialized) {
                        resultDeferred.complete("El SDK se inició correctamente")
                    } else {
                        resultDeferred.complete("Error al iniciar SDK")
                    }
                }
            })

        return resultDeferred.await()
    }

    fun startScan() {
        val cameraId = getRearCameraIdLegacy()
        //val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        manPresenter.startScan(cameraId, this, this)
    }

    @Suppress("DEPRECATION")
    private fun getRearCameraIdLegacy(): Int {
        try {
            val numberOfCameras = Camera.getNumberOfCameras()
            val cameraInfo = Camera.CameraInfo()
            for (i in 0 until numberOfCameras) {
                Camera.getCameraInfo(i, cameraInfo)
                if (cameraInfo.facing == Camera.CameraInfo.CAMERA_FACING_BACK) {
                    return i.toInt()
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return 0
    }




    override fun checkInitializeScan(start: Boolean) {
        // Inicialización exitosa
    }

    override fun onErrorShow(errorType: Int, message: String?) {
        Log.i(TAG, "Error: " + message)
    }

    override fun onScanResponse(qrData: String, qrEntity: QrEntity, objectEmvqrOrRbm: Any?) {
        Log.i(TAG, "onScanResponse: " + qrEntity);
    }


}
