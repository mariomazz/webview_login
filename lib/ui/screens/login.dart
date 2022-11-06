import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/autentication/auth_provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pr = Provider.of<AuthProvider>(context, listen: false);
      if (pr.currentIsAuth == false) {
        await pr.login();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
