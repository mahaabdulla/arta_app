import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoginTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  CustomLoginTextField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomLoginTextField> createState() => _CustomLoginTextFieldState();
}

class _CustomLoginTextFieldState extends State<CustomLoginTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF59827D), Color(0xFFf7f5ec)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4],
          tileMode: TileMode.clamp,
        ),
        // color: Colors.white,
        // shape: RoundedRectangleBorder(
        border: Border.all(
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
          color: Color(0xFF59827D),
        ),

        // boxShadow: [

        //   BoxShadow(
        //     color: Colors.black,

        //   ),
        //   BoxShadow(
        //     color: Colors.black,
        //     spreadRadius: -5.0,
        //     blurRadius: 20.0,
        //   ),
        // BoxShadow(
        //   color: Colors.black,
        //   spreadRadius: -2,
        //   blurRadius: 2,
        //   offset: Offset(0, -4), // الظل من الأعلى وداخل الحقل
        // ),
        // ],

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        obscureText: _obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.cairo(
            textStyle: TextStyle(color: Colors.grey.shade600),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // تغيير حالة الإخفاء
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF59827D),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(24),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF59827D),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
