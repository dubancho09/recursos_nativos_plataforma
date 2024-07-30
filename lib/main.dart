import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _resultCall = 'SDK init';
  String dataQr1 = '';
  String errorQR = 'Si errores';

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> initializeLibrary() async{
    String resultCall;

    try {
      final result = await platform.invokeMethod<String>('initializeLibrary');
      resultCall = 'la plataforma respondió: $result';
    } catch (e) {
      resultCall = "La plataforma respondió el siguiente error: $e";
    }

    setState(() {
      _resultCall = resultCall;
    });
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onScanResponse':
        String qrData = call.arguments;
        print("QR Data: $qrData");
        setState(() {
          dataQr1 = qrData;
        });
        break;
      case 'onErrorShow':
        String errorData = call.arguments;
        // int errorType = errorData['errorType'];
        // String? message = errorData['message'];

        
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
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async{
          await platform.invokeMethod<String>('startScan');
        }),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(onPressed: initializeLibrary, child: const Text('Iniciar SDK')),
                    Text(_resultCall),
                    const SizedBox(height: 30,),
                    Text(dataQr1),
                    const SizedBox(height: 10,),
                    Text(errorQR)
                  ],
                ),
              ),
            )
          )
        ),
      ),
    );
  }
}
