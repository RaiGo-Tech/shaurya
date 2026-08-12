import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shaurya Admin")),
      body: Center(child: Text("Welcome to Admin Panel")),
    );
  }
}
