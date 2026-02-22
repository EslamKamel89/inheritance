import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image, this.smallImage = false});
  final String image;
  final bool smallImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: smallImage ? 50 : 0),
      child: Image.asset(image, height: smallImage ? 100.h : 200.h, fit: BoxFit.cover),
    );
  }
}
