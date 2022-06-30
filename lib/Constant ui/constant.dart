import 'package:flutter/material.dart';

class ImageAssets {
  ImageAssets._();
  static const background = "assets/images/background.png";

}


class FWeight {
  FWeight._();
  static const regular = FontWeight.normal;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.bold;
}


class ColorPalette {
  ColorPalette._();
  static const themeBlue = Color(0xFF1fa1bd);
  static const white = Color(0xFFFFFFFF);

}


class EWTWidget {
  EWTWidget._();

  static get splashBoldTextStyle =>
      TextStyle(
          color: ColorPalette.white,
          fontSize: 40,
          fontWeight: FWeight.bold);


  static disableKeyboard() {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
  }



  static TextFormField disabledTextFormField(_controller, label) =>
      TextFormField(
        controller: _controller,
        decoration: new InputDecoration(
            labelText: label,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            ),
        enabled: false,
        keyboardType: TextInputType.number,

        validator: (value) {
          if (value!.isEmpty) {
            return 'The field is mandatory';
          }
          return null;
        },
      );



  static TextFormField enabledTextFormField1(_controller, label, inputType,
      inputFormatters, validator, maxLength) =>
      TextFormField(
        controller: _controller,
        decoration: new InputDecoration(
            labelText: label,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: ColorPalette.themeBlue, width: 0.5),
            // ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
           // labelStyle: EWTWidget.fieldLabelTextStyle,
            counterText: ""),
        //enabled: true,
        inputFormatters: inputFormatters,
        maxLines: null,
        keyboardType: inputType,
        //style: EWTWidget.fieldValueTextStyle,
        maxLength: maxLength,
        validator: validator,
      );
}