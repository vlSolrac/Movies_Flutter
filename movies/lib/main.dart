import 'package:flutter/material.dart';
import 'package:movies/providers/providers.dart';
import 'package:movies/routes/pages.dart';
import 'package:movies/routes/routes.dart';


void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: Routes.home,
      routes: Pages.routes,
    );
  }
}
