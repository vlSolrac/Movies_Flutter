import 'package:flutter/material.dart';
import 'package:movies/routes/pages.dart';
import 'package:movies/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
      routes: Pages.routes,
    );
  }
}
