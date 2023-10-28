import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuffixTextFormField extends StatelessWidget {
  final String? text;

  final String? hint;
  final String? suffixText;
  final TextInputType? textInputType;
  final IconData? icon;
  final Function(dynamic)? onSave;
  final String? Function(String?)? validator;
  final TextEditingController? qrTextController;
  final Function()? onTap;
  final int? maxLetter;
  SuffixTextFormField(
      {this.text,
      this.hint,
      this.onSave,
      this.validator,
      this.suffixText,
      this.textInputType,
      this.icon,
      this.qrTextController,
      this.onTap,
      this.maxLetter});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Directionality(
          //علشان يبدأ من اليمين
          textDirection: TextDirection.rtl,
          child: TextFormField(
            // عدد الحروف
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLetter),
            ],
            controller: qrTextController,
            onSaved: onSave,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.teal),
              ),
              hintText: hint,
              labelText: text,
              alignLabelWithHint: false,
              filled: true,
              suffixText: suffixText,
            ),
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
          )),
    );
  }
}
