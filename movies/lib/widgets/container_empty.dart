import 'package:flutter/material.dart';

class ContainerEmpty extends StatelessWidget {
  const ContainerEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return const SizedBox(
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
