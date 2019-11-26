import 'package:flutter/material.dart';
import 'package:mobiles2/data/database_helper.dart';

class RegistroAsp extends StatefulWidget {
  @override
  _RegistroAspState createState() => _RegistroAspState();
}

class _RegistroAspState extends State < RegistroAsp > {
  final _formKey = GlobalKey < FormState > ();
  //final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordControllerR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Aspirante'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Column(
          children: < Widget > [

            TextFormField(
              //controller: emailController,
              decoration: InputDecoration(labelText: 'Nombre'),
              keyboardType: TextInputType.emailAddress,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Nombre';
                }

                return null;
              },
            ),
            TextFormField(
              //controller: nameController,
              decoration: InputDecoration(labelText: 'Apellidos'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'Apellidos';
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Edad'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Edad';
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Sexo'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Sexo';
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Correo'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Correo';
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Número de teléfono'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Número de Teléfono';
                }

                return null;
              },
            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Preparatoria'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Preparatoria';
                }

                return null;
              },
            ),
            TextField(

            ),
            TextFormField(
              controller: passwordControllerR,
              decoration: InputDecoration(labelText: 'Primera opción'),
              obscureText: true,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Sexo';
                }

                return null;
              },
            ),
            RaisedButton(
              child: Text('Entrar'),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () {
                if (passwordController.text == passwordControllerR.text) {

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
                } else {
                  return 'Contraseña incorrecta';
                }



              },
            ),
          ],
        ),
      ),
      )
    );
  }
}