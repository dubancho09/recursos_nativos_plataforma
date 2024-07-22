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

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(onPressed: initializeLibrary, child: const Text('Iniciar SDK')),
                    Text(_resultCall)
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
