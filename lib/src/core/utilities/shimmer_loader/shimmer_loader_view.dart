import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerLoaderView extends StatelessWidget {
  final bool one;
  final bool isClosingTheLoop;

  const ShimmerLoaderView({
    required this.one,
    required this.isClosingTheLoop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: one ? 1 : 10,
          itemBuilder: (context, index) {
            return Container();
          },
        ));
  }
}
