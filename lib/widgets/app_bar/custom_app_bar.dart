import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.leadingWidth,
    this.leading,
    this.automaticallyImplyLeading,
    this.title,
    this.centerTitle,
    this.actions,
    this.iconTheme,
  }) : super(
          key: key,
        );

  final double? height;

  final double? leadingWidth;

  final Widget? leading;

  final bool? automaticallyImplyLeading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;
  
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? getVerticalSize(56),
      automaticallyImplyLeading: true,
      // backgroundColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
      iconTheme: iconTheme,
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? getVerticalSize(56),
      );
}
