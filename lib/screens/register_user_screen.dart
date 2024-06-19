import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController turmaController = TextEditingController();
  final TextEditingController turnoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  String userRole = '';

  Future<void> registerUser() async {
    if (codigoController.text == 'cs-aluno') {
      userRole = 'aluno';
    } else if (codigoController.text == 'cs-professor') {
      userRole = 'professor';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido')),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: senhaController.text,
      );
      User? user = userCredential.user;

      if (user != null) {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        await users.doc(user.uid).set({
          'nome': nomeController.text,
          'email': emailController.text,
          'userId': user.uid,
          'role': userRole,
          if (userRole == 'aluno') 'matricula': matriculaController.text,
          if (userRole == 'aluno') 'turma': turmaController.text,
          if (userRole == 'aluno') 'turno': turnoController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso')),
        );
        nomeController.clear();
        matriculaController.clear();
        turmaController.clear();
        turnoController.clear();
        emailController.clear();
        senhaController.clear();
        codigoController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao registrar usuário: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            if (userRole == 'aluno')
              TextField(
                controller: matriculaController,
                decoration: const InputDecoration(labelText: 'Matrícula'),
              ),
            if (userRole == 'aluno')
              TextField(
                controller: turmaController,
                decoration: const InputDecoration(labelText: 'Turma'),
              ),
            if (userRole == 'aluno')
              TextField(
                controller: turnoController,
                decoration: const InputDecoration(labelText: 'Turno'),
              ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(labelText: 'Código de Registro'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: const Text('Registrar Usuário'),
            ),
          ],
        ),
      ),
    );
  }
}
