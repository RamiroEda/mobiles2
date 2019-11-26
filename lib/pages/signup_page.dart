import 'package:flutter/material.dart';
import 'package:mobiles2/data/database_helper.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  //final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordControllerR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Usuario'),
              keyboardType: TextInputType.emailAddress,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Por favor escriba un usuario';
                }
              },
            ),
            /*TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter your name';
                }
              },
            ),*/
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Escriba una contraseña';
                }
              },
            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Repite tu contraseña'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Escribe tu contraseña';
                }
                
              },
            ),
            RaisedButton(
              child: Text('Entrar'),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () {
if(passwordController.text == passwordControllerR.text){

                if (_formKey.currentState.validate()) {
                  InfoVal dbHelper = InfoVal();
                  dbHelper.guardarUsuario(
                    //nameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/login');
                  Navigator.pop(context);
                }
                }
else{
                return 'Contraseña incorrecta';
                }



              },
            ),
          ],
        ),
      ),
    );
  }
}
