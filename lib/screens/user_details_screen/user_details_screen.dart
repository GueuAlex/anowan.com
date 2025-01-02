import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'widgets/add_cover_view.dart';
import 'widgets/details.dart';
import 'widgets/top_icons.dart';

class UserDetailsScreen extends ConsumerWidget {
  static const routeName = 'userDetailsScreen';
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Change the status bar color

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      /* 'assets/images/anowan-placeholder.png' */ 'assets/images/carousel/carousel1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    //alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [AddCoverView()],
                    ), // For better performance
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: TopIcons(),
          ),
          const Details()
        ],
      ),
    );
  }
}
