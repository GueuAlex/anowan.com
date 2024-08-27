import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.withOpacity(0.6),
            child: Text(
              'Chargement des prestataires',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
