import 'package:flutter/material.dart';
import 'package:mobiles2/model/user_model.dart';
import 'package:mobiles2/data/database_helper.dart';
import 'package:mobiles2/pages/agregar_aspirante.dart';
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
                title: Text('Agregar aspirante'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
              onPressed: (){
                setState(() {
                  _fragment = AgregarAspirante();
                });
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
            ListTile(
              title: Text('Sincronizar'),
              leading: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text('No sincronizados'),
              leading: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
                Navigator.pop(context);
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
}