import 'package:flutter/material.dart';
import 'package:movies/widgets/slider_vertical.dart';

class ViewMorePage extends StatefulWidget {
  const ViewMorePage({
    Key? key,
  }) : super(key: key);

  @override
  _ViewMorePageState createState() => _ViewMorePageState();
}

class _ViewMorePageState extends State<ViewMorePage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data["title"]),
      ),
      body: SliderVertical(
        data: data["data"],
        onNextPage: () {
          setState(() {
            data["moviesProvider"];
          });
        },
      ),
    );
  }
}
