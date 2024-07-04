import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/functions.dart';
import '../../../config/palette.dart';
import '../../../model/prestator_model.dart';
import 'filter_modal_bottom_sheet.dart';
import 'prestator_card.dart';

class PrestatorByCategory extends StatefulWidget {
  const PrestatorByCategory({
    super.key,
  });

  @override
  State<PrestatorByCategory> createState() => _PrestatorByCategoryState();
}

class _PrestatorByCategoryState extends State<PrestatorByCategory> {
  //prestator category list
  List<String> categories = [
    "Tout",
    "Décoration",
    "Service traiteur",
    "Tenue traditionnelle",
    "Location (salle , couverts etc....)",
    "Resto grill et lounge",
  ];

  String _selectedCategory = "Tout";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AppText.medium(
              'Prestataires par categorie',
              fontSize: (size.width * 0.042),
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(10),
          // filter tags
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(Palette.primaryColor),
                    ),
                    onPressed: () => Functions.showSimpleBottomSheet(
                      ctxt: context,
                      widget: FilterModalBottomeSheet(),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/filters.svg',
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Wrap(
                    children:
                        categories.map((label) => _buildTag(label)).toList(),
                  ),
                ],
              ),
            ),
          ),
          Gap(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // must replace filtered prestator list
              children: PrestatorMdel.prestators
                  .map(
                    (prestator) => prestatorCard(
                      prestator: prestator,
                      size: size,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    bool isSelected = label == _selectedCategory;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: const EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        color: !isSelected
            ? Palette.primaryColor.withOpacity(0.1)
            : Palette.primaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: InkWell(
        onTap: () => _onTagTap(label),
        child: AppText.medium(
          label,
          fontSize: 12,
          color: !isSelected ? Palette.primaryColor : Palette.whiteColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _onTagTap(String tag) {
    setState(() {
      _selectedCategory = tag;
    });

    /*  List<int> bytes = [
      70,
      77,
      82,
      0,
      48,
      51,
      48,
      0,
      0,
      0,
      1,
      38,
      0,
      1,
      0,
      0,
      0,
      1,
      23,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      -1,
      0,
      0,
      0,
      0,
      0,
      1,
      81,
      0,
      29,
      6,
      19,
      0,
      0,
      0,
      -59,
      0,
      -59,
      0,
      1,
      0,
      1,
      -112,
      96,
      40,
      -128,
      86,
      0,
      22,
      -76,
      67,
      -128,
      105,
      0,
      43,
      -80,
      67,
      -128,
      -86,
      0,
      48,
      -92,
      67,
      64,
      60,
      0,
      52,
      -68,
      67,
      -128,
      -100,
      0,
      52,
      36,
      67,
      64,
      -67,
      0,
      57,
      -88,
      67,
      64,
      86,
      0,
      69,
      60,
      80,
      64,
      39,
      0,
      71,
      56,
      67,
      64,
      107,
      0,
      71,
      52,
      67,
      64,
      -51,
      0,
      71,
      36,
      67,
      64,
      -105,
      0,
      80,
      36,
      80,
      64,
      20,
      0,
      92,
      84,
      67,
      -128,
      -109,
      0,
      118,
      -108,
      93,
      64,
      88,
      0,
      -126,
      96,
      93,
      64,
      100,
      0,
      -115,
      120,
      93,
      -128,
      -126,
      0,
      -103,
      -120,
      93,
      -128,
      -72,
      0,
      -101,
      32,
      93,
      -128,
      -51,
      0,
      -91,
      -100,
      93,
      64,
      88,
      0,
      -89,
      124,
      93,
      64,
      -83,
      0,
      -86,
      -108,
      93,
      -128,
      -25,
      0,
      -75,
      36,
      87,
      -128,
      48,
      0,
      -68,
      112,
      93,
      -128,
      -41,
      0,
      -54,
      -104,
      93,
      64,
      67,
      0,
      -33,
      124,
      93,
      64,
      109,
      0,
      -9,
      -120,
      93,
      64,
      -128,
      1,
      0,
      12,
      93,
      -128,
      -32,
      1,
      24,
      28,
      87,
      -128,
      46,
      1,
      33,
      -4,
      80,
      -128,
      34,
      1,
      42,
      120,
      74,
      64,
      -72,
      1,
      45,
      -108,
      93,
      64,
      98,
      1,
      49,
      124,
      87,
      64,
      -20,
      1,
      75,
      -100,
      67,
      -128,
      67,
      1,
      78,
      124,
      93,
      64,
      116,
      1,
      92,
      -120,
      93,
      64,
      -58,
      1,
      106,
      28,
      80,
      -128,
      95,
      1,
      108,
      -120,
      93,
      -128,
      58,
      1,
      110,
      0,
      80,
      64,
      -76,
      1,
      115,
      -108,
      87,
      64,
      98,
      1,
      117,
      16,
      93,
      -128,
      114,
      1,
      122,
      -112,
      93,
      0,
      0
    ];
    //
    String compressedString = compressString(bytes);
    print(compressedString);
    String decompressedString = decompressString(compressedString);
    print(decompressedString); */

    ///
    ///
  }

  /*  String compressString(List<int> bytes) {
    // Convertir la chaîne en liste d'octets
    //List<int> bytes = utf8.encode(input);

    // Compresser les octets
    List<int> compressedBytes = gzip.encode(bytes);

    print(compressedBytes);

    // Convertir les octets compressés en chaîne de base64 pour une manipulation facile
    String compressedString = base64Encode(compressedBytes);

    return compressedString;
  }

//
  String decompressString(String compressedString) {
    // Convertir la chaîne compressée de base64 en liste d'octets
    List<int> compressedBytes = base64Decode(compressedString);

    // Décompresser les octets
    List<int> decompressedBytes = gzip.decode(compressedBytes);

    // Convertir les octets décompressés en chaîne
    String output = utf8.decode(decompressedBytes);

    return output;
  } */

  ///
  ///
}
