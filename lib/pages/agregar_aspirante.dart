import 'package:flutter/material.dart';
import 'package:mobiles2/data/database_helper.dart';
import 'package:mobiles2/model/user_model.dart';
import 'package:mobiles2/pages/reg_aspirante.dart';

class AgregarAspirante extends StatefulWidget {
  AgregarAspirante({Key key}) : super(key: key);

  @override
  _AgregarAspiranteState createState() => _AgregarAspiranteState();
}

class _AgregarAspiranteState extends State<AgregarAspirante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: InfoVal().obtenerAspirantes(),
              builder: (context, AsyncSnapshot<List<Aspirante>> snap){
                if(snap.hasData){
                  return DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text("Nombre")),
                      DataColumn(label: Text("Apellidos")),
                      DataColumn(label: Text("Edad")),
                      DataColumn(label: Text("Sexo")),
                      DataColumn(label: Text("Correo")),
                      DataColumn(label: Text("Tel.")),
                      DataColumn(label: Text("Prepa.")),
                      DataColumn(label: Text("Primera opcion")),
                      DataColumn(label: Text("Segunda opcion")),
                      DataColumn(label: Text("Tercera opcion")),
                      DataColumn(label: Text("Borrar")),
                    ],
                    rows: snap.data.map((data)=>data.getRow(() {
                      final val = InfoVal();
                      val.borrrarAspirante(data.id).then((e){
                        setState(() {
                          
                        });
                      });
                    })).toList()
                  );
                }

                return Text("Sin datos");
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return Dialog(
                child: RegistroAsp(),
              );
            }

          ).then((v){
            setState(() {
              
            });
          });
        },
      ),
    );
  }
}