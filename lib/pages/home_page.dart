import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobiles2/model/user_model.dart';
import 'package:mobiles2/data/database_helper.dart';
import 'package:mobiles2/pages/agregar_aspirante.dart';
import 'package:http/http.dart' as http;
import 'package:mobiles2/pages/login_page.dart';



class HomePage extends StatefulWidget {
  final String emailController;
  final String passwordController;
   HomePage({Key key, this.emailController, this.passwordController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InfoVal dbHi = InfoVal();
  StatefulWidget _fragment = AgregarAspirante(); 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pagina Inicio'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
           UserAccountsDrawerHeader(
             accountEmail: FutureBuilder(
               future: dbHi.obtenerUsuario(widget.emailController, widget.passwordController),
               builder: (context, AsyncSnapshot<List<User>> snap){
                 if(snap.hasData){
                   return Text(snap.data[0].email);
                 }if(snap.hasError){
                   print(snap.error);
                 }
                 return Container();
               },
             ),
             accountName: Text('UPIIZ IPN'),
             currentAccountPicture: CircleAvatar(
               child: Icon(Icons.account_circle),
               
             ),
            ),
            RawMaterialButton(
              child: ListTile(
                title: Text('Sincronizar'),
                leading: Icon(
                  Icons.refresh,
                  color: Colors.redAccent,
                ),
              ),
              onPressed: (){
                _registrarAspirantes().then((v){
                    setState(() {
                      _fragment = AgregarAspirante();
                    });
                    _scaffoldKey.currentState.openEndDrawer();
                });
              },
            ),
            ListTile(
              title: Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      
      body: Container(
        child: _fragment
      ),
    );
  }


  Future _registrarAspirantes() async{
    final val = InfoVal();
    final aspirantes = await val.obtenerAspirantes();

    for(int i = 0 ; i< aspirantes.length ; i++){
      final response = await http.get("http://sistemas.upiiz.ipn.mx/isc/sira/api/actionAddAspiranteApp.php?nombre=${aspirantes[i].nombre+" "+aspirantes[i].apellidos}&movil=${aspirantes[i].tel}&email=${aspirantes[i].correo}&accion=agregar");
      final json = jsonDecode(response.body);
      print(response.body);
      if(json["estado"] == 1){
        await val.borrrarAspirante(aspirantes[i].id);
      }
    }

    return Future.value();
  }
}