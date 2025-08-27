import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:online/utils/app_colors/app_color.dart';

class IntroBtn extends StatelessWidget {
  String text;
  bool isLoading;
  Function() onTap;
  Color? bgClr;

  bool isTrailingShow;
   IntroBtn({
     this.isTrailingShow = true,
     this.bgClr,
     this.isLoading = false,
    required this.text,
     required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return _starBtn(context);
  }

  Widget _starBtn(BuildContext context){
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: onTap,
      child: Container(
        width: 207,
        height: MediaQuery.of(context).size.height * .09,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2.5,
                spreadRadius: 0.1,
                offset: Offset(0.0,4.0)
            )
          ],
          borderRadius: BorderRadius.circular(50.0),
          color: bgClr ?? AppColor.introBtnClr,
          border: const GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
              [
                Color(0xff726D87),
                Color(0xff41435E),
              ],
            ),
            width: 1.0,
          ),
        ),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),)
            : Text(text,
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontSize: MediaQuery.of(context).size.height * .03,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            if(isTrailingShow)...[
              const SizedBox(width: 10.0,),
              const Icon(Icons.arrow_forward_outlined,color: Colors.white)
            ]
          ],
        ),
      ),
    );
  }
}
