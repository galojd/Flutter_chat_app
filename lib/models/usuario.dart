// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String nombre;
  String correo;
  bool ponline;
  String uid;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.ponline,
    required this.uid,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        correo: json["correo"],
        ponline: json["ponline"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "ponline": ponline,
        "uid": uid,
      };
}
