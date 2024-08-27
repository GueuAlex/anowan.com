import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container buildIcon(
        {required String svgPath,
        required VoidCallback onTap,
        Color bgColor = Colors.black,
        double bgOpacity = 0.45}) =>
    Container(
      width: 32,
      height: 32,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(bgOpacity),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
