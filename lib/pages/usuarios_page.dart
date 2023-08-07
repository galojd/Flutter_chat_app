import 'package:flutter/material.dart';
import 'package:proyecto_chat/services/auth_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:proyecto_chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'jose', correo: 'galo@gmail.com', ponline: true),
    Usuario(
        uid: '2', nombre: 'Lujan', correo: 'galo1@gmail.com', ponline: true),
    Usuario(uid: '3', nombre: 'Pepe', correo: 'galo2@gmail.com', ponline: true),
    Usuario(
        uid: '4', nombre: 'Gerardo', correo: 'galo3@gmail.com', ponline: false),
    Usuario(
        uid: '5',
        nombre: 'El pensiones',
        correo: 'galo4@gmail.com',
        ponline: true),
    Usuario(
        uid: '6',
        nombre: 'El deudas',
        correo: 'galo5@gmail.com',
        ponline: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Aqui el usuario',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
                //Navigator.pushReplacementNamed(context, 'login');
              },
              icon: const Icon(Icons.exit_to_app),
              color: Colors.black54),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              /*
            child:Icon(
              Icons.offline_bolt,
              color: Colors.red)
            */
            )
          ],
        ),
        body: SmartRefresher(
          //esto sirve para cargar datos puedo acoplar peticiones para actualizar los datos en la pantalla
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarusuarios,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400]!,
          ),
          child: _ListViewUsuario(),
        ));
  }

  ListView _ListViewUsuario() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ((_, i) => _Lista_usuario(usuarios[i])),
        separatorBuilder: ((context, index) => Divider()),
        itemCount: usuarios.length);
  }

  ListTile _Lista_usuario(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre!),
      subtitle: Text(usuario.correo!),
      leading: CircleAvatar(
        child: Text(usuario.nombre!.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.ponline! ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarusuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
