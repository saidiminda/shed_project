import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextFieldShimmerWidget extends StatelessWidget {
  const TextFieldShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      period: const Duration(seconds: 1),
      baseColor: Colors.grey[300]!, 
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50.0,
        width: size.width,
        color: Colors.white,
      )
    );
  }
}