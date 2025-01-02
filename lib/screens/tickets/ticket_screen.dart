import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/palette.dart';
import '../../model/user_model.dart';
import '../../providers/tickets.provider.dart';
import '../../widgets/login_sheet2.dart';
import 'widgets/find_ticket_view.dart';
import 'widgets/up_coming_tickets.dart';

class TicketScreen extends ConsumerStatefulWidget {
  static String routeName = "TicketScreen";
  const TicketScreen({super.key, this.user});
  final UserModel? user;

  @override
  ConsumerState<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    //final user = null;
    var eventsWithTicketsAsync = ref
        .watch(ticketsProvider(widget.user != null ? widget.user!.id : null));

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 238, 241),
      body: Column(
        children: [
          // Barre supérieure
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              border: Border(
                bottom: BorderSide(
                  width: 0.8,
                  color: Palette.separatorColor,
                ),
              ),
            ),
          ),

          // Contenu principal
          Expanded(
            child: SmartRefresher(
              onRefresh: () async {
                eventsWithTicketsAsync = await ref.refresh(ticketsProvider(
                    widget.user != null ? widget.user!.id : null));
                _refreshController.refreshCompleted();
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
              child: Column(
                children: [
                  widget.user != null
                      ? eventsWithTicketsAsync.when(
                          data: (eventsWithTickets) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: UpCommingTickets(
                                eventsWithTickets: eventsWithTickets,
                              ),
                            );

                            // Section pour trouver des tickets
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          error: (error, stack) {
                            debugPrint("Error fetching tickets: $error");
                            return Center(
                              child: Text(
                                'Une erreur s\'est produite : $error',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          color: Colors.white,
                          child: LoginSheet2(
                            fontSize: 16,
                            title: 'Beaucoup mieux avec un compte !',
                            text:
                                'Créez un compte pour accéder à toutes les fonctionnalités - C\'est gratuit, simple et rapide!',
                            withMiddleText: false,
                            withBack: false,
                            withClose: false,
                            width: size.width * 0.6,
                          ),
                        ),
                  const Gap(10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: findTicketView(size: size),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 /*  Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: findTicketView(size: size),
                        ),
                      ), */



/* if (user == null) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      color: Colors.white,
                      child: LoginSheet(
                        fontSize: 16,
                        title: 'Beaucoup mieux avec un compte !',
                        text:
                            'Créez un compte pour accéder à toutes les fonctionnalités - C\'est gratuit, simple et rapide!',
                        withMiddleText: false,
                        withBack: false,
                        withClose: false,
                        width: size.width * 0.6,
                      ),
                    );
                  } */
