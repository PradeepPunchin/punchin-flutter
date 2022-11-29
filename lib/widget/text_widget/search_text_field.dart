import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punchin/constant/const_color.dart';


class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key,
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
        borderRadius: BorderRadius.circular(7),
      ),

      child: Container(

        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 21,top: 16,bottom: 14.51),
        decoration:BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextField(
          enabled: enable,
          onTap: onTap,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              counterText: '',
              hintText: hint,
              hintStyle: TextStyle(
                color: kMediumBlack,
              ),
              prefixIcon: search?Padding(
                padding: const EdgeInsets.only(right: 15.51),
                child: SvgPicture.asset("assets/icons/search.svg",color: kBlack,),
              ):null,
              suffixIcon: cross?Icon(Icons.close_sharp):null,

              prefixIconConstraints: BoxConstraints()),
        ),
      ),
    );
  }
}
