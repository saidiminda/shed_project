import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSearch,
      activeIcon: ImageConstant.imgSearch,
      type: BottomBarEnum.Search,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBookmark,
      activeIcon: ImageConstant.imgBookmark,
      type: BottomBarEnum.Bookmark,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.User,
    ), 
    // BottomMenuModel(
    //   icon: ImageConstant.imgCoffeecold1,
    //   activeIcon: ImageConstant.imgCoffeecold1,
    //   type: BottomBarEnum.Booking,
    // )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(61),
      margin: getMargin(
        left: 4,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              svgPath: bottomMenuList[index].icon,
              height: getSize(24),
              width: getSize(24),
              color: appTheme.blueGray800,
            ),
            activeIcon: SizedBox(
              height: getSize(37),
              width: getSize(37),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getSize(37),
                      width: getSize(37),
                      decoration: BoxDecoration(
                        color: appTheme.cyan300,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(10),
                        ),
                      ),
                    ),
                  ),
                  CustomImageView(
                    svgPath: bottomMenuList[index].activeIcon,
                    height: getSize(24),
                    width: getSize(24),
                    color: appTheme.blueGray800,
                    alignment: Alignment.topCenter,
                    margin: getMargin(
                      left: 6,
                      top: 5,
                      right: 7,
                      bottom: 8,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {

          });
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Search,
  Bookmark,
  User,
  Booking,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Text(
            //   'Please replace the respective Widget here',
            //   style: TextStyle(
            //     fontSize: 18,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
