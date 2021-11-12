import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies/resource/img.dart';
import 'package:movies/routes/routes.dart';
import 'package:movies/widgets/container_empty.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> data;

  const CardSwiper({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return data.isEmpty
        ? const Center(child: ContainerEmpty())
        : Container(
            width: double.infinity,
            height: size.height * 0.5,
            margin: const EdgeInsets.only(top: 10),
            child: Swiper(
              itemCount: data.length,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.dots),
              layout: SwiperLayout.STACK,
              autoplay: true,
              itemHeight: size.height * 0.5,
              itemWidth: size.width * 0.6,
              itemBuilder: (_, index) {
                final d = data[index];

                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.details, arguments: d),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 500),
                      fit: BoxFit.cover,
                      placeholder: noImage,
                      image: NetworkImage(d.fullPosterImg),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
