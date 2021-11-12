import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/resource/img.dart';

class CustomAppBar extends StatelessWidget {
  final Movie data;
  const CustomAppBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      expandedHeight: 220.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black45,
          child: Text(data.title, textAlign: TextAlign.center),
        ),
        background: FadeInImage(
            placeholder: noImage,
            image: NetworkImage(data.fullBackdropImg),
            fit: BoxFit.cover),
      ),
    );
  }
}
