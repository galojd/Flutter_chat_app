import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_chat/services/auth_services.dart';
import '../helpers/mostrar_alerta.dart';
import '../widgets/widget.dart';

class RegisterPage extends StatelessWidget {
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
                    titulo: 'Regitrate',
                  ),
                  _FormState(),
                  Labels(
                    rutas: 'login',
                    mensaje1: '¿Ya tienes cuenta?',
                    mensaje2: 'Ingresa ahora!',
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
  final nombreCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person,
            placeholder: 'Nombre',
            textController: nombreCtrl,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
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
            texto: 'Registrar',
            onpressed: authService.autenticando
                ? null
                : () async {
                    //desaparece el teclado despues de escribir
                    FocusScope.of(context).unfocus();
                    final registraOk = await authService.register(
                        nombreCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        contraCtrl.text.trim());

                    if (registraOk == true) {
                      //Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                      print('excente todo esta saliendo muy bien');
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, 'registro incorrecto', registraOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
