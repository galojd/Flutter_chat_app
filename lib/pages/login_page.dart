import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_chat/helpers/mostrar_alerta.dart';
import 'package:proyecto_chat/services/auth_services.dart';

import '../widgets/widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    titulo: 'Messenger',
                  ),
                  _FormState(),
                  Labels(
                    rutas: 'register',
                    mensaje1: '¿No tienes cuenta?',
                    mensaje2: 'Crea una ahora!',
                  ),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _FormState extends StatefulWidget {
  @override
  State<_FormState> createState() => __FormStateState();
}

class __FormStateState extends State<_FormState> {
  final emailCtrl = TextEditingController();
  final contraCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_lock_outlined,
            placeholder: 'Correo',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomInput(
            icon: Icons.looks_5_outlined,
            placeholder: 'Contraseña',
            textController: contraCtrl,
            isPassword: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Boton_Azul(
            texto: 'Ingresar',
            onpressed: authService.autenticando
                ? null
                : () async {
                    //desaparece el teclado despues de escribir
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text, contraCtrl.text);

                    if (loginOk) {
                      //Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, 'Login Incorrecto',
                          'Revise sus credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
