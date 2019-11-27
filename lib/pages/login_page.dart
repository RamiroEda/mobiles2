import 'package:flutter/material.dart';
import 'package:mobiles2/model/user_model.dart';
import 'package:mobiles2/data/database_helper.dart';
import 'package:mobiles2/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Usuario'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor escriba su usuario';
                }
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor escriba su contraseña';
                }
              },
            ),
            RaisedButton(
              child: Text('Entrar'),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: _validarUsuario,
            ),
            RaisedButton(
              child: Text('Registrar'),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () {
                emailController.text = "";
                passwordController.text = "";
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

  _validarUsuario() async {
    if (_formKey.currentState.validate()) {
      InfoVal dbHelper = InfoVal();
      dbHelper
          .obtenerUsuario(emailController.text, passwordController.text)
          .then((List<User> users) {
        if (users != null && users.length > 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(emailController: emailController.text, passwordController:passwordController.text)));
          print('[LoginPage] _validarUsuario: Success');
        } else {
          print('[LoginPage] _validarUsuario: Invalid credentials');
        }
      });
    }
  }
}
