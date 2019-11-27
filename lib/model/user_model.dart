import 'package:flutter/material.dart';
import 'package:mobiles2/data/database_helper.dart';

class User {
  String _id;
  String _email;
  String _password;

  User(
    this._id,
    this._email,
    this._password,
  );

  String get id => _id;
  String get email => _email;
  String get password => _password;
}

class Aspirante{
  final id;
  final nombre;
  final apellidos;
  final edad;
  final sexo;
  final correo;
  final tel;
  final prepa;
  final opcion1;
  final opcion2;
  final opcion3;

  Aspirante(this.id, this.nombre, this.apellidos, this.edad, this.sexo, this.correo, this.tel, this.prepa, this.opcion1, this.opcion2, this.opcion3);


  DataRow getRow(Function onPressed){
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(this.nombre)),
        DataCell(Text(this.apellidos)),
        DataCell(Text(this.edad)),
        DataCell(Text(this.sexo)),
        DataCell(Text(this.correo)),
        DataCell(Text(this.tel)),
        DataCell(Text(this.prepa)),
        DataCell(Text(this.opcion1)),
        DataCell(Text(this.opcion2)),
        DataCell(Text(this.opcion3)),
        DataCell(IconButton(
          icon: Icon(Icons.delete),
          onPressed: onPressed,
        ))
      ]
    );
  }
}