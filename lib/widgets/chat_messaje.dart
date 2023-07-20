import 'package:flutter/material.dart';

class ChatMessaje extends StatelessWidget {
  final String texto;
  final String uid;
  //esto es para agregar una animacion al enviar el mensaje en el chat, ignorar si no se desea hacerlo
  final AnimationController animationController;

  const ChatMessaje(
      {super.key,
      required this.texto,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      //esto siver para ayudar al cambio de opacidad de la animacion
      opacity: animationController,
      child: SizeTransition(
        //me aayuda a transformar el tamaño del widget
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == '123' ? _MyMessaje() : _NotMyMessaje(),
        ),
      ),
    );
  }

  Widget _MyMessaje() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 8, bottom: 5, left: 50),
        child: Text(
          texto,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _NotMyMessaje() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 50, bottom: 5, left: 8),
        child: Text(
          texto,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
