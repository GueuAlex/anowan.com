import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';
import 'infini_events_list.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({super.key});

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  late double _screenHeight;
  bool isMaxHeight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      /* if (_scrollController.pixels <= _scrollController.size) {
        print("DraggableScrollableSheet has reached its maximum size.");
      } */
      print('Scroll position: ${_scrollController.pixels}');
      if (_scrollController.pixels >= _screenHeight) {
        print("DraggableScrollableSheet has reached its maximum size.");
        setState(() {
          isMaxHeight = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _screenHeight = MediaQuery.of(context).size.height;
    });
    final size = MediaQuery.of(context).size;
    print(size.height);
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 0.08,
          minChildSize: 0.08,
          maxChildSize: 1.0,
          snapSizes: [1], // Permet de "snap" entre 30% et 100%
          snap: true,
          shouldCloseOnMinExtent: true,
          controller: _scrollController,

          builder: (BuildContext context, scrollSheetController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: isMaxHeight ? EdgeInsets.only(top: 120) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 0.8,
                    color: Palette.separatorColor,
                  ),
                ),
                borderRadius: isMaxHeight
                    ? null
                    : BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                controller: scrollSheetController,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return SafeArea(
                    top: false,
                    // bottom: true,
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          !isMaxHeight ? _draggableHeader() : Container(),
                          // afficher la liste des événements ici et un bouton (width 150 , height 50) flottant tout en bas "retour sur la carte"
                          SizedBox(
                            height: size.height,
                            width: size.width,
                            child: InfiniEventsList(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        isMaxHeight
            ? Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: _backToMapWidget(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _draggableHeader() {
    return Column(
      children: [
        SizedBox(
          width: 45,
          child: Divider(
            thickness: 5,
            color: Color.fromARGB(255, 225, 225, 225),
          ),
        ),
        Gap(4),
        AppText.medium(
          'Liste des événements.',
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  //

  Container _backToMapWidget() {
    return Container(
      width: 180,
      //height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: _backToMap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/marqueur-de-carte.svg',
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
            Gap(5),
            AppText.medium(
              'Retour sur la carte',
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  void _backToMap() {
    setState(() {
      _screenHeight = 0;
      isMaxHeight = !isMaxHeight;
    });

    //_scrollController.pixelsToSize(_screenHeight / 2);
    _scrollController.animateTo(
      0.08, // Taille initiale
      duration: Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }
}



/* 
  Container _backToMapWidget() {
    return Container(
      width: 180,
      //height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: _backToMap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/marqueur-de-carte.svg',
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
            Gap(5),
            AppText.medium(
              'Retour sur la carte',
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  } */

/*   _backToMap() {} */
