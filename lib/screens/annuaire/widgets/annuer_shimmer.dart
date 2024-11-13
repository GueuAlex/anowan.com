import 'package:flutter/material.dart';

class AnnuaireShimmer extends StatelessWidget {
  const AnnuaireShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        // height: size.height * 0.65,
        color: Colors.white,
        alignment: Alignment.center,
        child: SizedBox(
          width: 200.0,
          height: 100.0,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
