import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';

// ignore: must_be_immutable
class CheckavailabiliItemWidget extends StatelessWidget {
  CheckavailabiliItemWidget({
    Key? key,
    this.onTapCheckavailabili,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCheckavailabili;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(104),
      child: GestureDetector(
        onTap: () {
          onTapCheckavailabili?.call();
        },
        child: Container(
          height: getVerticalSize(169),
          width: getHorizontalSize(104),
          margin: getMargin(
            bottom: 2,
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: getVerticalSize(168),
                  width: getHorizontalSize(104),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomImageView(
                        color: Color.fromARGB(0, 212, 209, 209),
                        border: Border.all(color: Colors.orange),
                        imagePath: ImageConstant.imgRectangle11,
                        height: getVerticalSize(171),
                        width: getHorizontalSize(110),
                        radius: BorderRadius.circular(
                          getHorizontalSize(15),
                        ),
                        alignment: Alignment.center,

                      ),
                    
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: getPadding(
                    left: 12,
                    bottom: 10,
                  ),
                  child: Text(translation(context).check_availability,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displayLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
