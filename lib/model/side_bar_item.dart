import '../admin/screens/scan/scan_screen.dart';
import '../widgets/bottom_bar.dart';

class SideBarItemModel {
  final String title;
  final String svg;
  final String routeName;
  const SideBarItemModel({
    required this.title,
    required this.svg,
    required this.routeName,
  });

  static List<SideBarItemModel> tab = [
    SideBarItemModel(
      title: 'Accueil',
      svg: 'assets/icons/home1.svg',
      routeName: BottomBar.routeName,
    ),
    const SideBarItemModel(
      title: 'Organisation name',
      svg: 'assets/icons/building.svg',
      routeName: 'menu route',
    ),
    const SideBarItemModel(
      title: 'Événements',
      svg: 'assets/icons/calendar.svg',
      routeName: 'menu route',
    ),
    SideBarItemModel(
      title: 'Scanner',
      svg: 'assets/icons/scanner.svg',
      routeName: ScanScreen.routeName,
    ),
    const SideBarItemModel(
      title: 'Changer d\'organisateur',
      svg: 'assets/icons/double-arrow.svg',
      routeName: 'menu route',
    ),

    ///////////middle part//////////////////:
    const SideBarItemModel(
      title: 'Appareil',
      svg: 'assets/icons/settings.svg',
      routeName: 'menu route',
    ),
    const SideBarItemModel(
      title: 'Commentaires',
      svg: 'assets/icons/comments.svg',
      routeName: 'menu route',
    ),
    const SideBarItemModel(
      title: 'Besoin d\'aide ?',
      svg: 'assets/icons/life-ring.svg',
      routeName: 'menu route',
    ),
    const SideBarItemModel(
      title: 'A propos de nous',
      svg: 'assets/icons/exclamation.svg',
      routeName: '',
    ),
  ];

/*   static List<SideBarItemModel> middleTab = const [
    SideBarItemModel(
      title: 'Appareil',
      svg: 'assets/icons/settings.svg',
      routeName: 'menu route',
    ),
    SideBarItemModel(
      title: 'Commentaires',
      svg: 'assets/icons/comments.svg',
      routeName: 'menu route',
    ),
    SideBarItemModel(
      title: 'Besoin d\'aide ?',
      svg: 'assets/icons/life-ring.svg',
      routeName: 'menu route',
    ),
    SideBarItemModel(
      title: 'A propos de nous',
      svg: 'assets/icons/exclamation.svg',
      routeName: '',
    ),
  ]; */

  static List<SideBarItemModel> bottomTab = const [
    SideBarItemModel(
      title: 'Déconnexion',
      svg: 'assets/icons/logout.svg ',
      routeName: '',
    )
  ];

  static int selectedIndex = -1;
}
