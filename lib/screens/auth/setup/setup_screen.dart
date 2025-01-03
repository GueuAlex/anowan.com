import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/palette.dart';
import '../../../local_service/local_service.dart';
import '../../../providers/bookmark_event_provider.dart';
import '../../../providers/following_provider.dart';
import '../../../providers/providers.dart';
import '../../../widgets/bottom_bar.dart';
import '../../../widgets/custom_button.dart';
import 'views/centre_interet_view.dart';
import 'views/event_suggestion.dart';
import 'views/follow_organizer_view.dart';
import 'views/location_view.dart';

class SetupScreen extends ConsumerStatefulWidget {
  static String routeName = 'SetupScreen';
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  int _currentIndex = 0;
  LocalService _localService = LocalService();

  // Liste des 5 vues à afficher
  final List<Widget> _views = [
    LocationView(),
    CentreInteretView(),
    FollowOrganizerView(),
    EventSuggestion(),
  ];

  // Fonction pour changer de vue
  void _nextView() async {
    if (_currentIndex < _views.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      EasyLoading.show();
      await Future.delayed(const Duration(seconds: 5));
      Navigator.of(context)
          .pushNamedAndRemoveUntil(BottomBar.routeName, (route) => false);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    // place
    final selectedPlace = ref.watch(selectedPlaceProvider);
    // tags
    final selectedTags = ref.watch(tagsProvider);
    // load bookmarked organizers
    ref.watch(bookmarkedOrganizersProvider.notifier).loadBookmarkedOrganizers();
    // load bookmarked events
    ref.watch(bookmarkedEventsProvider.notifier).loadBookmarkedEvents();

    return Scaffold(
      appBar: AppBar(
        //title: Text('Custom Page View'),
        leading: null,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Indicateurs en haut
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.2,
                    color: Palette.separatorColor,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 0.8,
                right: 0.8,
                top: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_views.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Indicator(
                      isActive: index == _currentIndex,
                    ),
                  );
                }),
              ),
            ),

            // Vue actuelle au milieu
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _views,
              ),
            ),

            // Bouton "Suivant" en bas
            SafeArea(
              top: false,
              child: Container(
                width: double.infinity,
                height: 80,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.8, color: Palette.separatorColor),
                  ),
                ),
                child: CustomButton(
                  color: Palette.appRed,
                  width: double.infinity,
                  height: 35,
                  radius: 5,
                  text: 'Suivant',
                  onPress: () async {
                    EasyLoading.show();
                    print(selectedPlace);
                    if (_currentIndex == 0) {
                      if (selectedPlace != null) {
                        await _localService.updateLocation(selectedPlace);
                      } else {
                        await _localService.updateLocation(
                          'Abidjan, Côte d\'ivoire',
                        );
                      }
                    }
                    if (_currentIndex == 1) {
                      await _localService.addInterest(selectedTags);
                    }
                    EasyLoading.dismiss();
                    _nextView();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget personnalisé pour les indicateurs
class Indicator extends StatelessWidget {
  final bool isActive;

  Indicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 16 : 8,
      height: isActive ? 16 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Palette.appRed : Colors.grey.withOpacity(0.7),
      ),
    );
  }
}
