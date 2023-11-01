import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';

// ignore: must_be_immutable
class RoomWidget extends StatelessWidget {
  RoomWidget({
    Key? key,
    this.onTapProperty,
  }) : super(
          key: key,
        );

  VoidCallback? onTapProperty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(104),
      child: GestureDetector(
        onTap: () {
          onTapProperty?.call();
        },
        child: Container(
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
                        // color: Color.fromARGB(0, 212, 209, 209),
                        border: Border.all(color: Colors.orange),
                        imagePath: ImageConstant.imgRectangleBedRoom,
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
                  child: Text(translation(context).manage_rooms,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.headlineSmallPrimary1,
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
