import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
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
  CustomTextFormField({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
    this.suffixText,
    this.textInputType,
    this.icon,
    this.qrTextController,
    this.onTap,
    this.maxLetter,
  });

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
              suffixIcon: GestureDetector(
                child: Icon(
                  icon,
                  color: Colors.green,
                ),
                onTap: onTap,
              ),
            ),
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
          )),
    );
  }
}

// ده علشان اغير اللون بتاع الحدود واحط ايقونه
//  child: new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.redAccent,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           decoration: new InputDecoration(
//               border: new OutlineInputBorder(
//                   borderSide: new BorderSide(color: Colors.teal)),
//               hintText: 'Tell us about yourself',
//               helperText: 'Keep it short, this is just a demo.',
//               labelText: 'Life story',
//               prefixIcon: const Icon(
//                 Icons.person,
//                 color: Colors.green,
//               ),
//               prefixText: ' ',
//               suffixText: 'USD',
//               suffixStyle: const TextStyle(color: Colors.green)),
//         ),
//       ));
