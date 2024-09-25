import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Color primaryColor = const Color(0xff115e38);
Color secondaryColor = const Color(0xff4dd07f);
Color accentColor = const Color(0xfffead58);

double kSpacing = 20.00;

double kfontSize = 18.00;
double kLargefontSize = 25.00;

BorderRadius kBorderRadius = BorderRadius.circular(kSpacing);

EdgeInsets kPadding = EdgeInsets.all(kSpacing);
EdgeInsets kHPadding = EdgeInsets.symmetric(horizontal: kSpacing);
EdgeInsets kVPadding = EdgeInsets.symmetric(vertical: kSpacing);

getBtnStyle(context) => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
    backgroundColor: primaryColor,
    fixedSize: Size(MediaQuery.of(context).size.width, 47),
    textStyle: const TextStyle(fontWeight: FontWeight.bold));
var btnTextStyle = TextStyle(fontSize: kfontSize);

String networtImgPlaceholder =
    'https://oifoeivdflxzgtj0.public.blob.vercel-storage.com/anowan-placeholder-tAFlbGkVichP1J33x41uuo0DBpKV4Q.png';

final String mapsApiKey = dotenv.env['MAPS_APIKEY']!;

final String termsOFus = 'https://anowan.com/terms-and-policies/privacy-policy';
