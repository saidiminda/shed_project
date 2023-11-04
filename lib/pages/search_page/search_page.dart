import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/custom_search_view.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore_for_file: must_be_immutable
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DateTimeRange? _selectedDateRange;
  late BoxConstraints constraints;

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      fieldEndHintText: translation(context).checkroomAvail,
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
        start: DateTime.now(),
      ),
      builder: (context, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade200,
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: child),
            ),
          ),
        ]);
      },
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      print(result.end.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: getPadding(left: 2, top: 10, right: 17, bottom: 18),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          OutlineGradientButton(
            padding: EdgeInsets.only(
                left: getHorizontalSize(1),
                top: getVerticalSize(1),
                right: getHorizontalSize(1),
                bottom: getVerticalSize(1)),
            strokeWidth: getHorizontalSize(1),
            gradient: LinearGradient(
                begin:const Alignment(0.5, 0),
                end:const Alignment(0.5, 1),
                colors: [appTheme.deepOrange700, theme.colorScheme.primary]),
            corners: const Corners(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            child: CustomSearchView( 
              readOnly: true,
              prefix: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: _show,
                  child: Container(
                    width: 300,
                    margin: getMargin(left: 2, top: 5, right: 1, bottom: 5),
                    child: _selectedDateRange == null
                        // ignore: avoid_unnecessary_containers
                        ? Center(
                            child: Text(translation(context).checkroomAvail,
                                softWrap: true),
                          )

                        // ignore: avoid_unnecessary_containers
                        : Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Start date
                                Row(
                                  children: [
                                    Text(
                                      "Start: ${_selectedDateRange?.start.toString().split(' ')[0]}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 1, 9, 15)),
                                    ),

                                    const SizedBox(
                                      width: 30,
                                    ),
                                    // End date
                                    Text(
                                        "End: ${_selectedDateRange?.end.toString().split(' ')[0]}",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.red)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              suffix: Container(
                margin: getMargin(left: 30, top: 18, right: 13, bottom: 18),
                child: CustomImageView(
                  imagePath: ImageConstant.imgSearch24x24,
                  height: getSize(24),
                  width: getSize(24),
                  onTap: () => onTapViewAvailability(context),
                ),
              ),
              suffixConstraints: BoxConstraints(maxHeight: getVerticalSize(60)),
              contentPadding: getPadding(
                left: 10,
                top: 18,
              ),
            ),
          ),
        ]));
  }

  onTapViewAvailability(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.checkAvailability);
  }
}
