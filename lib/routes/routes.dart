import 'package:flutter/material.dart';
import 'package:proyecto_chat/pages/page.dart';

Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
