import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class CustomTextFormField extends StatefulWidget {
  final IconData? icon;
  final String label;
  final TextEditingController? controller;
  final bool required;
  final bool obscureText;
  final String? value;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmitted;

  const CustomTextFormField(
      {super.key,
        this.icon,
        required this.label,
        this.value,
        this.required =false,
        this.obscureText =false,
        required this.controller,
        required this.validator,
        required this.onSubmitted,
      });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  bool isObsecure = false;
  @override
  void initState() {
    if (widget.value != null) {
      widget.controller!.text = widget.value ?? '';
    }
    if(widget.obscureText){
      isObsecure = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      padding: EdgeInsets.only(right: width/24),
      height: size.height * 0.1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: const Color(0xff4E4B66),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Visibility(
                visible: widget.required,
                child: const Text(
                  "*",
                  style: TextStyle(
                    color: Color(0xffC30052)
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            onFieldSubmitted: widget.onSubmitted,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: isObsecure,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: width/36, vertical: height/189),
              border: const OutlineInputBorder(),
              suffixIcon:widget.obscureText ? IconButton(
                icon: Icon(isObsecure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,color: const Color(0xff757879)),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  },
                  );
                },
              ) : null,
              hintText: "",
              hintStyle: GoogleFonts.poppins(
                color:  const Color(0xffA7A1A1),
                fontSize: width/25.71428571428571,
              ),
            ),
          ),
        ],
      ),
    );
  }
}