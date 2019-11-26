import 'package:flutter/material.dart';
import 'routes.dart';

void main() => runApp(mobiles2());

class mobiles2 extends StatelessWidget {
  final String _appName = 'mobiles2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
    );
  }
}
