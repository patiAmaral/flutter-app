import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  Future<List<Map<String, dynamic>>> _getAttendanceRecords() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('attendance')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => {
      'matricula': doc['matricula'],
      'timestamp': (doc['timestamp'] as Timestamp).toDate()
    })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros de Presença'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getAttendanceRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao buscar registros de presença'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum registro de presença encontrado'));
            } else {
              List<Map<String, dynamic>> attendanceRecords = snapshot.data!;
              return ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> record = attendanceRecords[index];
                  DateTime timestamp = record['timestamp'];
                  return ListTile(
                    title: Text('Matrícula: ${record['matricula']}'),
                    subtitle: Text('Data e Hora: ${timestamp.toString()}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
