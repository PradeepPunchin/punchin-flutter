import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punchin/constant/const_color.dart';


class CustomCommentField extends StatelessWidget {
  const CustomCommentField({Key? key,
    this.textInputType = TextInputType.text,
    this.search=false,
    this.cross=false,
    this.controller,
    this.hint,
    this.onTap,
    this.enable,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool search;
  final bool cross;
  final String? hint;

  final TextInputType textInputType;
  final onTap;
  final enable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration:BoxDecoration(
        gradient: LinearGradient(colors: [kLightBlack,kLightBlack]),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Container(
        height: 20*10,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 16,top: 2),
        decoration:BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(

          enabled: enable,
          maxLines: 8,
          minLines: 1,
          //onTap: onTap,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              counterText: '',
              hintText: hint,
              hintStyle: TextStyle(
                color: kLightBlack,
              ),
              prefixIcon: search?SvgPicture.asset("assets/images/Search.svg",color: kBlack,):null,
              suffixIcon: cross?Icon(Icons.close_sharp):null,

              prefixIconConstraints: BoxConstraints()),
        ),
      ),
    );
  }
}
