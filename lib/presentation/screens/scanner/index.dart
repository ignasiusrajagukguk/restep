import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        ),
        body: MobileScanner(
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            final value = barcode.rawValue;
            if (value != null) {
              Navigator.of(context).pop(value); // return scanned value
            }
          },
        ),
      ),
    );
  }
}