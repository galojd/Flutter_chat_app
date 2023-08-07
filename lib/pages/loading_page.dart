import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_chat/pages/page.dart';
import 'package:proyecto_chat/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ckeckLoginState(context),
      builder: (context, snapshot) {
        return Center(child: Text('Espere...'));
      },
    ));
  }

  Future ckeckLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticando = await authService.isLoggedIn();

    if (autenticando) {
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsuariosPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
