import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherScanScreen extends StatefulWidget {
  const TeacherScanScreen({super.key});

  @override
  _TeacherScanScreenState createState() => _TeacherScanScreenState();
}

class _TeacherScanScreenState extends State<TeacherScanScreen> {
  MobileScannerController cameraController = MobileScannerController();

  void _barcodeDetected(BarcodeCapture barcodeCapture) {
    final List<Barcode> barcodes = barcodeCapture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final String qrCode = barcode.rawValue!;
        _handleQRCodeScanned(qrCode);
        break; // Handle only the first barcode detected
      }
    }
  }

  void _handleQRCodeScanned(String qrCode) async {
    QuerySnapshot studentQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('matricula', isEqualTo: qrCode)
        .limit(1)
        .get();

    if (studentQuery.docs.isNotEmpty) {
      DocumentSnapshot studentDoc = studentQuery.docs.first;
      Map<String, dynamic> studentData = studentDoc.data() as Map<String, dynamic>;
      String userId = studentDoc.id;
      DateTime now = DateTime.now();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('attendance')
          .add({'timestamp': now});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR Code de ${studentData['nome']} escaneado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluno não encontrado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            color: Colors.white,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            color: Colors.white,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _barcodeDetected,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register_student');
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
