import 'package:flutter/material.dart';

class ContainerEmpty extends StatelessWidget {
  const ContainerEmpty({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: double.infinity,
        height: size.height * 0.9,
        child: const Center(child: CircularProgressIndicator()),
    );
  }
}
