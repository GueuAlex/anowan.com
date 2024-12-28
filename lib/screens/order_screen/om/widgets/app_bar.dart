import 'package:flutter/cupertino.dart';

class AppBarCusttom extends StatelessWidget {
  const AppBarCusttom({
    super.key,
    this.title = 'Autre',
    this.leadingText = 'Menu',
  });
  final String title;
  final String leadingText;

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
                    const Icon(
                      CupertinoIcons.back,
                      // color: Colors.,
                      size: 28,
                    ),
                    Text(
                      leadingText,
                      style: const TextStyle(
                        // color: Palette.primary,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              //fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
