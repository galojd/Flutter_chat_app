import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proyecto_chat/global/environment.dart';
import 'package:proyecto_chat/models/login_response.dart';
import 'package:proyecto_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  //este  es para notificar cuando se este aitenticando
  bool _autenticando = false;
  // Se crea el storage para flutter_secure_storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters del token de forma estatica, usarlo donde quiera sin necesidad de provider
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  //Getters del token de forma estatica, usarlo donde quiera borrar sin necesidad de provider
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //Servicio para logearse
  Future<bool> login(String correo, String password) async {
    this._autenticando = true;

    final data = {'correo': correo, 'password': password};

    //lo convierto en uri al string
    final uri = Uri.parse('${Environment.apiUrl}/login/ingresar');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginresponse = loginResponseFromJson(resp.body);
      this.usuario = loginresponse.usuario;

      await this._guardartoken(loginresponse.token);
      return true;
    } else {
      return false;
    }
  }

  //Servicio para registrarse
  Future register(String nombre, String correo, String password) async {
    this._autenticando = true;

    final data = {'nombre': nombre, 'correo': correo, 'password': password};

    //lo convierto en uri al string
    final uri = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final registeresponse = loginResponseFromJson(resp.body);
      this.usuario = registeresponse.usuario;
      await this._guardartoken(registeresponse.token);
      return true;
    } else {
      //mapeo la respuesta de error con un jsondecode
      final respBody = jsonDecode(resp.body);
      //regresa el mensaje
      return respBody['msg'];
    }
  }

  //Con esta funcion verifico si el usuario tiene un token valido
  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token') ?? '';
    //print(token);
    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final registeresponse = loginResponseFromJson(resp.body);
      this.usuario = registeresponse.usuario;
      await this._guardartoken(registeresponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardartoken(String token) async {
    // Se escribe el valor en flutter_secure_storage
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Elimina el valor de flutter_secure_storage
    await _storage.delete(key: 'token');
  }
}
