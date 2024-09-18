import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:ticketwave/config/app_text.dart';
import 'package:ticketwave/config/palette.dart';

import '../../config/functions.dart';
import '../../model/organizer_model.dart';
import '../../providers/providers.dart';
import 'widgets/Organize_header.dart';
import 'widgets/action_button.dart';
import 'widgets/name_and_desc.dart';
import 'widgets/social_media_w.dart';
import 'widgets/up_coming_event.dart';

class OrganizerScreen extends ConsumerStatefulWidget {
  static const routeName = 'organizerScreen';
  const OrganizerScreen({super.key});

  @override
  ConsumerState<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends ConsumerState<OrganizerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final organizer =
        ModalRoute.of(context)!.settings.arguments as OrganizerModel;

    // Utilisation du provider avec l'organizer.id
    var events = ref.watch(organizeEventsProvider(organizer.id.toString()));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppText.medium(
          organizer.name,
          maxLine: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        /*  actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset(
              'assets/icons/menu-points.svg',
              width: 20,
            ),
          )
        ], */
      ),
      backgroundColor: Colors.white,
      body: SmartRefresher(
        onRefresh: () {
          events = ref.refresh(organizeEventsProvider(organizer.id.toString()));
          Future.delayed(const Duration(milliseconds: 1000), () {
            _refreshController.refreshCompleted();
          });
        },
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        physics: const BouncingScrollPhysics(),
        header: const ClassicHeader(
          completeText: "",
          idleText: "",
          refreshingText: "",
          releaseText: "",
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                OrganizerHeader(organizer: organizer),
                OrganisationNameAndDesc(organizer: organizer),
                const Gap(15),
                const ActionButtons(),
                const Gap(15),
                TabBar(
                  indicatorColor: Palette.appRed,
                  labelColor: Palette.appRed,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Prochains'),
                    Tab(text: 'Précédents'),
                    Tab(text: 'Liens sociaux'),
                  ],
                ),
                Expanded(
                  child: events.when(
                    data: (events) {
                      // Filtrer les événements dont la date est dans le futur
                      final upcomingEvents =
                          Functions.filterAndSortUpcomingEvents(events);
                      final pastEvents = Functions.eventsHistory(events);
                      return TabBarView(controller: _tabController, children: [
                        // Contenu de l'onglet "Prochains"

                        UpComingEvents(events: upcomingEvents),
                        // Contenu de l'onglet "Précédents"
                        UpComingEvents(events: pastEvents),
                        // Contenu de l'onglet "Liens sociaux"
                        SocialMediaView(),
                      ]);
                    },
                    loading: () => Container(
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                    error: (error, stackTrace) =>
                        Center(child: Text('Erreur : $error')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
