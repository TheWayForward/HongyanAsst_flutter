import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {

  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key? key, required this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: Container(),
    );
  }
}
