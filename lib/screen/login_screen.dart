import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:room_manager/screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String username = '';
  
  Future<String?> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(const Duration(milliseconds: 3000), () {
      username = data.name;
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(const Duration(milliseconds: 3000), () {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: _authUser,
      onSignup: null,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Screen(username: username),
        ));
      },
      userValidator: defaultEmailValidator,
      passwordValidator: defaultPasswordValidator,
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'Usuario',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'INICIAR SESIÓN',
        forgotPasswordButton: '¿Olvidaste tu contraseña?',
        recoverPasswordButton: 'AYÚDAME',
        goBackButton: 'REGRESAR',
        confirmPasswordError: 'No coincide!',
        recoverPasswordDescription: 'Enviaremos tu contraseña a esta dirección de correo electronico.',
        recoverPasswordIntro: 'Recupera tu contraseña'
      ),
      
    );
  }
  
  static String? defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Correo inválido.';
    }
    return null;
  }

  static String? defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty || value.length <= 2) {
      return 'La contraseña es muy corta.';
    }
    return null;
  }
}
