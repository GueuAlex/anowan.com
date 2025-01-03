import 'package:flutter/material.dart';

import '../../order_screen/widgets/sheet_header.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.25),
        width: double.infinity,
        // height: ,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
        ),
        child: Column(
          children: [sheetheader(context: context, text: 'Les avis (99K)')],
        ),
      ),
    );
  }
}
