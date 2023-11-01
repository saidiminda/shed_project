import 'package:flutter/material.dart';

FormField<String> dropDownWidget(
    String labelText,
    String hintText,
    String currentValue,
    List<dynamic> valuesList,
    Function(dynamic)? changeState) {
  return FormField<String>(
    builder: (FormFieldState<String> state) {
      return InputDecorator(
        decoration: InputDecoration(
            labelText: labelText,
            // labelStyle: textStyle,
            errorStyle:
                const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        isEmpty: currentValue == "",
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            value: currentValue,
            isDense: true,
            onChanged: changeState,
            items: valuesList.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text("$value"),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
