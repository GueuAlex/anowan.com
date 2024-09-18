import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticketwave/config/palette.dart';

import '../../model/event_model.dart';
import '../../model/localization_model.dart';
import '../../widgets/add_forite.dart';
import '../../widgets/customAnimateSlide.dart';
import '../../widgets/custom_leading.dart';
import '../../widgets/custome_divider.dart';
import '../../widgets/menu_contextuel.dart';
import 'widgets/bottom_area.dart';
import 'widgets/date_selector.dart';
import 'widgets/event_about.dart';
import 'widgets/google_map_container.dart';
import 'widgets/more_event_container.dart';
import 'widgets/organisateur_page_route.dart';
import 'widgets/sellStatus.dart';
import 'widgets/tag_container.dart';
import 'widgets/title_widgets.dart';

class SingleEventScreen extends StatefulWidget {
  static String routeName = 'single_event_screen';
  const SingleEventScreen({super.key});

  @override
  State<SingleEventScreen> createState() => _SingleEventScreenState();
}

class _SingleEventScreenState extends State<SingleEventScreen> {
  final ScrollController _scontroller = ScrollController();
  bool isAppBarExpanded = true;

  @override
  void initState() {
    super.initState();
    _scontroller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scontroller.hasClients) {
      final appBarHeight = 250.0; // Hauteur de l'expandedHeight du SliverAppBar
      setState(() {
        isAppBarExpanded =
            _scontroller.offset < (appBarHeight - kToolbarHeight);
      });
      //print(isAppBarExpanded);
    }
  }

  @override
  void dispose() {
    _scontroller.removeListener(_scrollListener);
    _scontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final List<LocalizationModel> localizations = event.localizations;
    final size = MediaQuery.of(context).size;
    //bool isMultipleLocalization = localizations.length > 1;
    return Scaffold(
      //backgroundColor: Palette.scafoldColor,
      bottomNavigationBar: CustomeAnimatedSlide(
        child: BottomArea(size: size, event: event),
        // duration: const Duration(seconds: 5),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _scrollListener();
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scontroller,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              elevation: 0,
              backgroundColor: Colors.white,
              expandedHeight: 250,
              leadingWidth: 45,
              centerTitle: !isAppBarExpanded,
              leading: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: isAppBarExpanded
                    ? CustomLeading()
                    : Container(), // Animation douce pour la transition du leading
              ),
              actions: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: isAppBarExpanded
                      ? Row(
                          children: [
                            AddForiteButton(),
                            Gap(5),
                            MenuContextuel(),
                            Gap(5),
                          ],
                        )
                      : Container(), // Animation douce pour la transition des actions
                ),
              ],
              flexibleSpace: Container(
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Palette.separatorColor,
                      width: 0.8,
                    ),
                  ),
                ),
                child: FlexibleSpaceBar(
                  //collapseMode: CollapseMode.pin,
                  centerTitle: !isAppBarExpanded,
                  titlePadding: const EdgeInsets.all(0),
                  title: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: isAppBarExpanded
                        ? normalTitleContainer(
                            title: event.name,
                            size: size,
                          )
                        : offsetTitleContainer(
                            title: event.name,
                            size: size,
                          ), // Animation douce pour la transition du titre
                  ),
                  background: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/anowan-placeholder.png',
                    image: event.image,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/anowan-placeholder.png',
                        fit: BoxFit.cover,
                      );
                    },
                    width: double.infinity,
                    height: size.width * 0.25,
                  ),
                ),
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SellStatus(),
                        OrganisateurPageRoute(
                          organizer: event.organizer,
                        ),
                        DateSelector(
                          localizations: localizations,
                          title: event.name,
                          description: event.shortDescription,
                        ),
                        EventAbout(
                          html: event.description,
                          shortHtml: event.shortDescription,
                        ),
                        customDiveder(),
                        GoogleMapContainer(
                          localization: localizations[0],
                        ),
                        /* customDiveder(), */
                        TageContainer(),
                        MoreEventContainer(categoryId: event.categoryId)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
