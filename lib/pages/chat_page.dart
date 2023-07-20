import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_chat/widgets/widget.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

//le agrego TickerProviderStateMixin para poder utilizar las varias animaciones al momento de enviar mensajesm , me permite acceder al this
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textcontroller = new TextEditingController();
  final _focusnode = new FocusNode();
  List<ChatMessaje> _messajes = [];

  bool _estaescribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Column(
              children: [
                CircleAvatar(
                  child: Text('ini', style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.blue[100],
                  maxRadius: 14,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Mario Castañeda',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                )
              ],
            ),
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messajes.length,
                itemBuilder: ((_, i) => _messajes[i]),
                reverse: true,
              )),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _InputChat(),
              )
            ],
          ),
        ));
  }

  Widget _InputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textcontroller,
            onSubmitted: _handlesubmit,
            onChanged: ((texto) {
              //TODO debe haber una condicional aqui, para poder postear cuadno hay un valor
              setState(() {
                if (texto.trim().isNotEmpty) {
                  _estaescribiendo = true;
                } else {
                  _estaescribiendo = false;
                }
              });
            }),
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusnode, //con esto puedo controlar el foco a voluntad
          )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaescribiendo
                          ? () => _handlesubmit(_textcontroller.text.trim())
                          : null)
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.blue[400],
                        ),
                        child: IconButton(
                            onPressed: _estaescribiendo
                                ? () =>
                                    _handlesubmit(_textcontroller.text.trim())
                                : null,
                            icon: Icon(
                              Icons.send,
                            )),
                      ),
                    ))
        ],
      ),
    ));
  }

  _handlesubmit(String texto) {
    if (texto.length == 0) return;
    print(texto);
    _textcontroller.clear(); //limpia la caja donde escribo
    _focusnode
        .requestFocus(); //deja centrado el foco en la caja para seguir escribiendo
    //creo una variable donde le pongo el obheto de chat messaje
    final newMessaje = new ChatMessaje(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    //Agrego el mensaje en el arreglo desde la posicion 0 para que sea lo ultimo en verse
    _messajes.insert(0, newMessaje);
    newMessaje.animationController
        .forward(); //con esto indico que se dispare la animacion

    setState(() {
      _estaescribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessaje messaje in _messajes) {
      messaje.animationController.dispose();
    }
    super.dispose();
  }
}
