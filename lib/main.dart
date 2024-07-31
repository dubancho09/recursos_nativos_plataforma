import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  static const platform = MethodChannel('sample.flutter/readQR');
  String dataQr1 = '';
  String errorQR = 'Si errores';
  String dataEncrypted = '';
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeLibrary();
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> initializeLibrary() async{
    bool resultCall;

    try {
      resultCall = await platform.invokeMethod<bool>('initializeLibrary') ?? false;
      
    } catch (e) {
      resultCall = false;
    }

    setState(() {
      isInitialized = resultCall;
    });
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onScanResponse':
        String qrData = call.arguments;
        setState(() {
          dataQr1 = qrData;
        });
        break;
      case 'onErrorShow':
        String errorData = call.arguments;
        setState(() {
          errorQR = errorData;
        });
        break;

      default:
        throw MissingPluginException();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: isInitialized ? Column(
                  children: [
                    FilledButton(onPressed: readQrWithCamera, child: const Text('Leer con la cámara')),
                    FilledButton(onPressed: (){
                      
                    }, child: const Text('Leer desde una imagen')),
                    const SizedBox(height: 30,),
                    Text(dataQr1),
                  ],
                ) 
                :
                  const CircularProgressIndicator(),
              ),
            )
          )
        ),
      ),
    );
  }

  void readQrWithCamera() async {
    final data = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    setState(() {
      if (data != "-1") {
        dataEncrypted = data;
      } else {
        return;
      }
    });

    await platform
        .invokeMethod<bool>('transformData', {'qrData': dataEncrypted});
  }
}
