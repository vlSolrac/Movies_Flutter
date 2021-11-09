import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies/data/models/models.dart';
import 'package:movies/resource/img.dart';
import 'package:movies/routes/routes.dart';
import 'package:movies/widgets/container_empty.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> data;

  const CardSwiper({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return data.isEmpty
        ? const ContainerEmpty()
        : Container(
            width: double.infinity,
            height: size.height * 0.5,
            margin: const EdgeInsets.only(top: 10),
            child: Swiper(
              itemCount: data.length,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.fraction),
              layout: SwiperLayout.DEFAULT,
              itemHeight: size.height * 0.5,
              itemWidth: size.width * 0.6,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.home,
                      arguments: data[index]),
                  child: ClipRRect(
                    child: FadeInImage(
                      placeholder: noImage,
                      image: data[index].fullPosterImg,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
