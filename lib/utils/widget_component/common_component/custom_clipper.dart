import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height / 3);
    var firstControllerPoint = Offset(0.0, size.height / 3 -60);
    var firstEndPoint = Offset(size.width * .3, size.height * .2);
    path.quadraticBezierTo(firstControllerPoint.dx, firstControllerPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width * .7, size.height * .2);

    var secondControllerPoint = Offset(size.width , size.height * .2);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControllerPoint.dx, secondControllerPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
  
}