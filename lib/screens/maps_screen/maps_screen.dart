import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/app_text.dart';
import '../../config/functions.dart';
import '../../config/palette.dart';
import '../annuaire/widgets/filter_modal_bottom_sheet.dart';
import 'widgets/draggable_bottom_sheet.dart';
import 'widgets/localisable_events.dart';

class MapsScreen extends StatefulWidget {
  static const String routeName = 'mapsScreen';
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  //filters
  List<String> filters = [
    "Trier",
    "All upcoming",
    "À tout moment",
    "En personne",
    "Peu importe",
    "Catégorie"
  ];
  CameraPosition? _initialPosition;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final LatLng tapedCoordonnees =
          ModalRoute.of(context)!.settings.arguments as LatLng;
      setState(() {
        _initialPosition = CameraPosition(
          target: tapedCoordonnees,
          zoom: 10.0,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final LatLng tapedCoordonnees =
        ModalRoute.of(context)!.settings.arguments as LatLng;

    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('start'),
        position: LatLng(5.347017, -4.024429),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: LatLng(5.348317, -4.026429),
      ),
      Marker(
        markerId: MarkerId('taped'),
        position: tapedCoordonnees,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (_initialPosition != null)
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: GoogleMap(
                    initialCameraPosition: _initialPosition!,
                    markers: Set.from(_markers),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      Future.delayed(Duration(milliseconds: 2000), () {
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: tapedCoordonnees,
                              zoom: 14.0,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                );
              },
            )
          else
            Center(
              child: SizedBox(),
            ),
          // localisable events
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: LocalisableEvents(),
          ),
          // Draggable
          DraggableBottomSheet(),
          // top bar
          Container(
            width: double.infinity,
            height: 175,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              right: false,
              left: false,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 22,
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Palette.primaryColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FluentIcons.search_12_regular,
                                  color: Colors.grey.shade500,
                                  size: 22,
                                ),
                                const Gap(5),
                                AppText.medium(
                                  'Événements',
                                  color: Colors.grey.shade500,
                                  fontSize: (size.width * 0.038),
                                  fontWeight: FontWeight.w300,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Gap(8),
                  //filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Gap(13),
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
                              filters.map((label) => _buildTag(label)).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    //bool isSelected = label == _selectedCategory;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: const EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 45, 57, 85).withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () => _onTagTap(label),
        child: Row(
          children: [
            AppText.medium(
              label,
              fontSize: 12,
              color: Color.fromARGB(230, 49, 49, 49),
              fontWeight: FontWeight.w700,
            ),
            Gap(5),
            Icon(
              CupertinoIcons.chevron_down,
              size: 18,
              color: Color.fromARGB(230, 49, 49, 49),
            )
          ],
        ),
      ),
    );
  }

  void _onTagTap(String tag) {}
}

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1! + 1, y1! + 1),
      southwest: LatLng(x0! - 1, y0! - 1),
    );
  }
}
