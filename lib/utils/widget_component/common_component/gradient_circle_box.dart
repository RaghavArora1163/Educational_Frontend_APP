import 'package:flutter/material.dart';

class GradientCircleBox extends StatelessWidget {
  const GradientCircleBox({super.key});

  @override
  Widget build(BuildContext context) {
    return _gradientCircle();
  }

  Widget _gradientCircle(){
    return  Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xff616CDD).withOpacity(0.1),
          boxShadow:  const [
            BoxShadow(
              color: Color(0xff616CDD),
              spreadRadius: 80,
              blurRadius: 70,
            )
          ]),
    );
  }
}
