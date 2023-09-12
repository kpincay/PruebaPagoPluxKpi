import 'package:flutter/material.dart';
import 'package:prueba/home_screen.dart';
import 'package:prueba/utils/validaciones.dart';

class Login extends StatefulWidget {
  static const String routerName = 'LoginScreen';
  const Login({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String routerName = 'LoginScreen';
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Usuario"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su usuario';
                    }

                    String respt = ValidacionesUtils().validaCorreo(value);

                    if (respt.isEmpty) {
                      return 'Formato de correo incorrecto';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Contraseña"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    if (value.length < 5) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String _correo = emailController.text;
                        Future.microtask(() => Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  PrincipalScreen(correo: _correo),
                              transitionDuration: const Duration(seconds: 0),
                            )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Verifique los campos')),
                        );
                      }
                    },
                    child: const Text('Ingresar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
