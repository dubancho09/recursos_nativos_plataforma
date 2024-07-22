package com.example.redeban_qr

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
            }

        }
    }

    private suspend fun initializeLibrary(): String {
        val resultDeferred = CompletableDeferred<String>()
        manPresenter = QrManagerImp(this@MainActivity)
        manPresenter.initializeLibrary(
            "base_url",
            "public_key",
            "license",
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

    override fun checkInitializeScan(start: Boolean) {
        // Inicialización exitosa
    }

    override fun onErrorShow(errorType: Int, message: String?) {
        // Manejar error
    }

    override fun onScanResponse(qrData: String, qrEntity: QrEntity, objectEmvqrOrRbm: Any?) {
        // Manejar respuesta del escaneo
    }
}
