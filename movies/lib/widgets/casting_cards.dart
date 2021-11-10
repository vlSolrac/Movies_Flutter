import 'package:flutter/material.dart';
import 'package:movies/data/models/cast.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/resource/img.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int idData;
  const CastingCards({
    Key? key,
    required this.idData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider =
        Provider.of<MoviesProvider>(context, listen: false /*No redibujar*/);
    return FutureBuilder(
      future: moviesProvider.getCastMovie(idData),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: size.height * 0.26,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        final casts = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: size.height * 0.26,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: (_, int index) => CastCard(data: casts[index])),
        );
      },
    );
  }
}

class CastCard extends StatelessWidget {
  final Cast data;
  const CastCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 110,
      height: size.height * 0.26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: size.height * 0.2,
              fit: BoxFit.cover,
              placeholder: noImage,
              image: NetworkImage(data.fullprofileImg),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              data.name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
