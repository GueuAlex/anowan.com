import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/home_carousel_model.dart';

CarouselSlider headerCarousel({required BuildContext context}) {
  return CarouselSlider(
    options: CarouselOptions(
      height: 150,
      //height: height,
      viewportFraction: 1.0,
      enlargeCenterPage: false,
      autoPlay: true,
      autoPlayCurve: Curves.fastOutSlowIn,
    ),
    items: CarouselModel.list
        .map((item) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.amber,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(item.img),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black.withOpacity(0.40),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 20,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 40),
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.slogan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList(),
  );
}
