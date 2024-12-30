import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:ticketwave/widgets/login_sheet.dart';

import '../../config/palette.dart';
import '../../providers/tickets.provider.dart';
import '../../providers/user.provider.dart';
import 'widgets/find_ticket_view.dart';
import 'widgets/up_coming_tickets.dart';

class TicketScreen extends ConsumerStatefulWidget {
  static String routeName = "TicketScreen";
  const TicketScreen({super.key});

  @override
  ConsumerState<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
/*   List<String> categories = [
    "Entreprise",
    "Culture et Art",
    "Sport",
    "Social",
    "Education",
    "Charité et Levée de fonds",
    "Divertissement",
    "Religieux"
  ];

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"]; */
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /*  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  } */

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var ticketsAsync = ref.watch(
      ticketsProvider(user != null ? user.id : null),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 238, 241),
      body: Column(
        children: [
          Container(
            //padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
            //child: searcheBarView(size: size),
          ),
          Expanded(
            child: SmartRefresher(
              // onLoading: _onLoading,
              onRefresh: () async {
                ticketsAsync = await ref.refresh(
                  ticketsProvider(user != null ? user.id : null),
                );
                await Future.delayed(Duration(milliseconds: 1000));
                setState(() {});
                _refreshController.refreshCompleted();
              },
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              physics: BouncingScrollPhysics(),
              header: ClassicHeader(
                completeText: "",
                idleText: "",
                refreshingText: "",
                releaseText: "",
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user != null
                      ? ticketsAsync.when(
                          data: (tickets) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(color: Colors.white),
                              child: UpCommingTickets(),
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stack) {
                            print(error);
                            return Text('Error: $error');
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          color: Colors.white,
                          child: LoginSheet(
                            fontSize: 16,
                            title: 'Beaucoup mieux avec un compte !',
                            text:
                                'Créez un compte pour accéder à toutes les fonctionnalités - C\'est gratuit , simple et rapide!',
                            withMiddleText: false,
                            withBack: false,
                            withClose: false,
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                  Gap(10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: findTicketView(size: size),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}



  
  //
 
  /////
  ///
  

