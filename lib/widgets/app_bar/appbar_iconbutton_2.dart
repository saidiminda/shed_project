import 'package:flutter/material.dart';

import '../custom_icon_button.dart';
import '../custom_image_view.dart';

// ignore: must_be_immutable
class AppbarIconbutton2 extends StatelessWidget {
  AppbarIconbutton2({this.imagePath, this.svgPath, this.margin, this.onTap});

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 48,
          width: 48,
          child: CustomImageView(
            svgPath: svgPath,
            imagePath: imagePath,
          ),
        ),
      ),
    );
  }
}
