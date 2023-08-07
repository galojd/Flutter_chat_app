import 'package:flutter/material.dart';

class Boton_Azul extends StatelessWidget {
  final String texto;
  final Function()? onpressed;
  const Boton_Azul({Key? key, required this.texto, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.blue,
          elevation: 2,
        ),
        onPressed: onpressed,
        child: Container(
            width: double.infinity,
            height: 55,
            child: Center(child: Text(texto))));
  }
}
