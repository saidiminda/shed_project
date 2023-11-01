import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';

// ignore: must_be_immutable
class SwitchAccount extends StatelessWidget {
  TextEditingController saleTypeController = TextEditingController();
    final List<String> saleType = [
    'Hotel 1',
    'Hotel 2',
    'Hotel 3',

  ];
   String? selectedValue;

  SwitchAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           SizedBox(
               child: Padding(
                padding: getPadding(
                left: 8, top: 10, right: 6
                ),
                child:DropdownButtonFormField2<String>(
                 
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Switch Account',
                   hintStyle: theme.textTheme.bodyLarge!,
                  contentPadding: getPadding(
                  all: 18,
                     ),
                     
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(10.00)
                  ),
                borderSide: BorderSide(
                  color: appTheme.tealA700,
                  width: 0.5,
                ),
                         ),
                ),
                hint:  Text('',
                    style: TextStyle(fontSize: 12),
                  ),
               
                items: saleType
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return translation(context).identity_type;
                  }
                  return null;
                },
                onChanged: (value) { 
                  
                  selectedValue = value;
           
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                  print(selectedValue);
                },
                 dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.switch_access_shortcut_add,
                  ),
                  iconSize: 24,
                ),
          dropdownSearchData: DropdownSearchData(
            searchController: saleTypeController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
                         
            child: TextFormField(
                expands: true,
                maxLines: null,
                controller: saleTypeController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Switch Account',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
             searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
             //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              saleTypeController.clear();
            }}
          
                )) 
                
                ),
                Container(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {  },
                   style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC2892D),
                      elevation: 0,
                      ),
                  child: const Text('Switch Account',
                   style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 252, 251, 250)
                                ),),
                ),
      ],
    );
  }
}