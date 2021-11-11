import 'package:flutter/material.dart';
import 'package:movies/providers/providers.dart';
import 'package:movies/screens/home/components/widgets_home.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          CardSwiper(data: moviesProvider.nowPlayingMovies),
          const SizedBox(height: 30),
          SliderHorizontal(
            title: "Proximos Estrenos",
            data: moviesProvider.upcomingMovies,
            moviesProvider: moviesProvider.getUpcomingMovies(),
          ),
          const SizedBox(height: 30),
          SliderHorizontal(
            title: "Populares",
            data: moviesProvider.popularMovies,
            moviesProvider: moviesProvider.getPopularMovies(),
          ),
          const SizedBox(height: 30),
          SliderHorizontal(
            title: "Top Rated",
            data: moviesProvider.topRatedMovies,
            moviesProvider: moviesProvider.getTopRatedMovies(),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
