import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/resource/img.dart';
import 'package:movies/widgets/casting_cards.dart';
import 'package:movies/widgets/custom_app_bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie data = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(data: data),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(data: data),
                const SizedBox(height: 10),
                _Overview(data: data),
                const SizedBox(height: 10),
                CastingCards(idData: data.id),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie data;
  const _PosterAndTitle({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: noImage,
                image: NetworkImage(data.fullPosterImg),
                fit: BoxFit.cover,
                height: size.height * 0.28,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(),
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Text(
                  data.originalTitle,
                  style: TextStyle(),
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.star,
                      size: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "popularidad: ${data.voteAverage}",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie data;
  const _Overview({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            data.overview,
            textAlign: TextAlign.justify,
            style: TextStyle(
                height: 1.5,
                fontSize: 14,
                color: Colors.black.withOpacity(0.8)),
          )
        ],
      ),
    );
  }
}
