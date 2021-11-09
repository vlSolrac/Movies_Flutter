import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/resource/img.dart';
import 'package:movies/resource/texts.dart';
import 'package:movies/routes/routes.dart';

class SliderHorizontal extends StatelessWidget {
  final List<Movie> data;
  final String title;

  const SliderHorizontal({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title, style: text),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.viewMore, arguments: {
                  "title": title,
                  "data": data,
                }),
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(vieMore, style: text),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) {
                return _PosterSlider(data: data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterSlider extends StatelessWidget {
  final Movie data; 
  const _PosterSlider({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: 130,
      height: size.height * 0.35,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, "details", arguments: data),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height:  size.height * 0.25,
                fit: BoxFit.cover,
                placeholder: noImage,
                image: NetworkImage(data.fullPosterImg),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              data.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
