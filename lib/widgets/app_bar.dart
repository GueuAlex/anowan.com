import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCusttom extends StatelessWidget {
  const AppBarCusttom({
    super.key,
    this.title = 'Autre',
    this.leadingText = 'Menu',
    this.color = Colors.white,
  });
  final String title;
  final String leadingText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // horizontal: 15,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: Color.fromARGB(0, 231, 231, 231),
          ),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                // width: 150,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: color,
                      size: 28,
                    ),
                    Text(
                      leadingText,
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: color),
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
