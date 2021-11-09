import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/resource/img.dart';
import 'package:movies/widgets/container_empty.dart';

class SliderVertical extends StatefulWidget {
  final List<Movie> data;
  final Function onNextPage;
  const SliderVertical({
    Key? key,
    required this.data,
    required this.onNextPage,
  }) : super(key: key);

  @override
  State<SliderVertical> createState() => _SliderVerticalState();
}

class _SliderVerticalState extends State<SliderVertical> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        setState(() {
          widget.onNextPage();
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
        ? const ContainerEmpty()
        : Container(
            margin: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.data.length,
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, int index) =>
                  _PosterSliderVertical(data: widget.data[index]),
            ),
          );
  }
}

class _PosterSliderVertical extends StatelessWidget {
  final Movie data;
  const _PosterSliderVertical({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 10),
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      height: size.height * 0.28,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "details", arguments: data),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                width: 150,
                height: size.height * 0.28,
                placeholder: noImage,
                image: NetworkImage(data.fullPosterImg),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text("${data.voteAverage}"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.overview,
                    textAlign: TextAlign.left,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "details", arguments: data),
                splashRadius: 1,
                icon: const Icon(Icons.arrow_right)),
          ],
        ),
      ),
    );
  }
}
