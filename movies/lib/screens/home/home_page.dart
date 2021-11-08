import 'package:flutter/material.dart';
import 'package:movies/resource/texts.dart';
import 'package:movies/screens/home/components/body_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(titleApp),
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 15,
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}
