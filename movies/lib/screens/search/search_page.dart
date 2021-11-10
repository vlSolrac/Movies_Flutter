import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/resource/img.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        splashRadius: 1,
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.keyboard_arrow_left_rounded,
        size: 30,
      ),
      splashRadius: 1,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 200,
        ),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.sugestionsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.movie_creation_outlined,
              color: Colors.black38,
              size: 200,
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchItem(data: snapshot.data![index]);
            },
          ),
        );
      },
    );
  }
}

class SearchItem extends StatelessWidget {
  final Movie data;
  const SearchItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "details", arguments: data),
      child: ListTile(
        title: Text(data.title),
        subtitle: Text(data.originalTitle),
        trailing: const Icon(Icons.arrow_right),
        leading: FadeInImage(
          placeholder: noImage,
          image: NetworkImage(data.fullPosterImg),
          height: 100,
          width: 45,
        ),
      ),
    );
  }
}
