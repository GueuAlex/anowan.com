import 'package:flutter/material.dart';
import 'package:ticketwave/config/palette.dart';

import 'views/location_view.dart';

class SetupScreen extends StatefulWidget {
  static String routeName = 'SetupScreen';
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _currentIndex = 0;

  // Liste des 5 vues à afficher
  final List<Widget> _views = [
    LocationView(),
    Center(child: Text('View 2', style: TextStyle(fontSize: 24))),
    Center(child: Text('View 3', style: TextStyle(fontSize: 24))),
    Center(child: Text('View 4', style: TextStyle(fontSize: 24))),
    Center(child: Text('View 5', style: TextStyle(fontSize: 24))),
  ];

  // Fonction pour changer de vue
  void _nextView() {
    if (_currentIndex < _views.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Custom Page View'),
        leading: null,
      ),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _nextView,
              child: Text('Suivant'),
            ),
          ),
        ],
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
