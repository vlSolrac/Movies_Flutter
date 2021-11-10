import 'package:flutter/material.dart';
import 'package:movies/resource/texts.dart';
import 'package:movies/screens/home/components/body_home.dart';
import 'package:movies/screens/search/search_page.dart';

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
            onPressed: () =>  showSearch(context: context, delegate: MovieSearchDelegate()),
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}
