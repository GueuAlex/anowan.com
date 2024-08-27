import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:ticketwave/config/app_text.dart';

import '../../../constants/constants.dart';

class SwiperBuilder extends StatelessWidget {
  const SwiperBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: kPadding / 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Swiper(
              itemWidth: 400,
              itemHeight: 225,
              loop: true,
              duration: 1200,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    color: colors[index],
                    //image: DecorationImage(image: AssetImage(imagepath[index])),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // qr code part
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 5,
                            color: Colors.black.withOpacity(0.12),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          /* image: DecorationImage(
                              image: AssetImage(),
                              fit: BoxFit.cover,
                            ), */
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset('assets/images/qr-model.png'),
                        ),
                      ),
                      //
                      // ticket ref part
                      Positioned(
                        bottom:
                            0, // Ajout d'un espace par rapport au bord inférieur
                        right: 0, // Ajout d'un espace par rapport au bord droit
                        child: AppText.medium('#529455816448'),
                      ),

                      // already scanned part
                      Positioned(
                        top: 0,
                        left: 0,
                        child: _statutIcon(),
                      ),
                      Positioned(
                        top: 45,
                        left: 15.2,
                        child: _passType(),
                      )
                    ],
                  ),
                );
              },
              itemCount: colors.length,
              layout: SwiperLayout.STACK,
            ),
          ),
        ),
      ),
    );
  }

  Container _passType() {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.15),
              width: 1,
            ),
            top: BorderSide(
              color: Colors.black.withOpacity(0.15),
              width: 1,
            ),
            right: BorderSide(
              color: Colors.black.withOpacity(0.15),
              width: 1,
            ),
          ),
        ),
        child: VerticalText(
          text: 'STANDARD',
        ));
  }

  Container _statutIcon() {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 31, 194, 206).withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 31, 194, 206),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.12),
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.check_mark,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

List<Color> colors = [
  const Color.fromARGB(255, 45, 97, 153),
  Color.fromARGB(255, 4, 134, 169),
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemPink,
  CupertinoColors.systemPurple,
];

class VerticalText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const VerticalText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: text.split('').map((char) {
        return Text(
          char,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(),
    );
  }
}
