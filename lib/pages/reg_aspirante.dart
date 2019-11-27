import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:mobiles2/data/database_helper.dart';
import 'package:mobiles2/model/prepa_model.dart';

class RegistroAsp extends StatefulWidget {
  @override
  _RegistroAspState createState() => _RegistroAspState();
}

class _RegistroAspState extends State < RegistroAsp > {
  final _formKey = GlobalKey < FormState > ();
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final edadController = TextEditingController();
  final sexoController = TextEditingController();
  final correoController = TextEditingController();
  final telController = TextEditingController();
  final prepaController = TextEditingController();
  final primeraOpcionController = TextEditingController();
  final segundaOpcionController = TextEditingController();
  final terceraOpcionController = TextEditingController();
  final _autocompleteKey = GlobalKey<AutoCompleteTextFieldState<Prepa>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Aspirante'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
        key: _formKey,
        child: Column(
          children: < Widget > [

            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
              keyboardType: TextInputType.emailAddress,
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: apellidosController,
              decoration: InputDecoration(labelText: 'Apellidos'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: edadController,
              decoration: InputDecoration(labelText: 'Edad'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: sexoController,
              decoration: InputDecoration(labelText: 'Sexo'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: telController,
              decoration: InputDecoration(labelText: 'Número de teléfono'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            AutoCompleteTextField<Prepa>(
                key: _autocompleteKey,
                controller: prepaController,
                suggestions: prepas,
                itemBuilder: (context, item){
                  return ListTile(
                    title: Text(item.nombre),
                  );
                },
                itemFilter: (item, query){
                  return item.nombre.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (item, item2){
                  return item.id.compareTo(item2.id);
                },
                itemSubmitted: (item){
                  
                },
                decoration: InputDecoration(labelText: 'Preparatoria'),
                clearOnSubmit: false,

              ),
            TextFormField(
              controller: primeraOpcionController,
              decoration: InputDecoration(labelText: 'Primera opción'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: segundaOpcionController,
              decoration: InputDecoration(labelText: 'Segunda opción'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            TextFormField(
              controller: terceraOpcionController,
              decoration: InputDecoration(labelText: 'Tercera opción'),
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo esta vacio';
                }

                return null;
              },
            ),
            RaisedButton(
              child: Text('Agregar'),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async{
                if(_formKey.currentState.validate()){
                  final db = InfoVal();
                  db.initDB();
                  await db.guardarAspirante([
                    nombreController.text,
                    apellidosController.text,
                    edadController.text,
                    sexoController.text,
                    correoController.text,
                    telController.text,
                    prepaController.text,
                    primeraOpcionController.text,
                    segundaOpcionController.text,
                    terceraOpcionController.text
                  ]);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
        )
      )
    );
  }
}