import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user_model.dart'; // Importez votre UserModel ici

class LocalService {
  static final LocalService _instance = LocalService._internal();
  static Database? _database;

  LocalService._internal();

  factory LocalService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS user(
            id INTEGER PRIMARY KEY,
            name TEXT,
            firstname TEXT,
            phone TEXT,
            email TEXT,
            avatar TEXT,
            active INTEGER,
            phoneCode TEXT,
            gender TEXT,
            birthDate TEXT,
            interests TEXT,
            bio TEXT,
            about TEXT,
            bookmarkedOrganizersId TEXT,
            bookmarkedEventsId TEXT,
            favoriteLocation TEXT
          )
        ''');
      },
    );
  }

  // Méthode pour créer ou remplacer l'utilisateur (il n'y aura qu'un seul utilisateur)
  Future<int> saveUser(UserModel user) async {
    final db = await database;

    // Convertir les listes d'intérêts et d'événements en chaînes
    final interests = user.interests.join(',');
    final bookmarkedEventsId = user.bookmarkedEventsId.join(',');
    final bookmarkedOrganizersId = user.bookmarkedOrganizersId.join(',');
    final about = user.about.join(',');

    return await db.insert(
      'user',
      {
        'id': user.id,
        'name': user.name,
        'firstname': user.firstname,
        'phone': user.phone,
        'email': user.email,
        'avatar': user.avatar,
        'active': user.active ? 1 : 0,
        'phoneCode': user.phoneCode,
        'gender': user.gender,
        'birthDate': user.birthDate?.toIso8601String(),
        'interests': interests,
        'bio': user.bio,
        'about': about,
        'bookmarkedOrganizersId': bookmarkedOrganizersId,
        'bookmarkedEventsId': bookmarkedEventsId,
        'favoriteLocation': user.favoriteLocation
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fonction pour vider la table 'user'
  Future<void> clearUserTable() async {
    final db = await database;
    try {
      await db.execute('DELETE FROM user');
      print('Table user vidée avec succès.');
    } catch (e) {
      print('Erreur lors de la vidange de la table user: $e');
    }
  }

  // Méthode pour récupérer l'utilisateur (il n'y en aura qu'un seul)
  Future<UserModel?> getUser() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('user');
    print(maps);
    if (maps.isNotEmpty) {
      final Map<String, dynamic> userMap = maps.first;

      // Convertir les chaînes d'intérêts et d'événements en listes
      List<String> interests = userMap['interests'].toString().split(',');
      List<String> about = userMap['about'].toString().split(',');
      List<String> bookmarkedEventsId = userMap['bookmarkedEventsId']
          .toString()
          .split(',')
          .map((e) => e)
          .toList();
      List<String> bookmarkedOrganizersId = userMap['bookmarkedOrganizersId']
          .toString()
          .split(',')
          .map((e) => e)
          .toList();

      return UserModel(
        id: userMap['id'],
        name: userMap['name'],
        firstname: userMap['firstname'],
        phone: userMap['phone'],
        email: userMap['email'],
        avatar: userMap['avatar'],
        active: userMap['active'] == 1,
        phoneCode: userMap['phoneCode'],
        gender: userMap['gender'],
        birthDate: userMap['birthDate'] != null
            ? DateTime.parse(userMap['birthDate'])
            : null,
        interests: interests,
        bookmarkedEventsId: bookmarkedEventsId,
        bookmarkedOrganizersId: bookmarkedOrganizersId,
        about: about,
        bio: userMap['bio'],
        favoriteLocation: userMap['favoriteLocation'],
      );
    } else {
      return null;
    }
  }

  // Méthode pour mettre à jour l'avatar
  Future<int> updateAvatar(String newAvatar) async {
    final db = await database;
    return await db.update(
      'user',
      {'avatar': newAvatar},
      where:
          'id = (SELECT id FROM user LIMIT 1)', // Mise à jour pour le seul utilisateur
    );
  }

  // Méthode pour mettre à jour la bio
  Future<int> updateBio(String bio) async {
    final db = await database;
    return await db.update(
      'user',
      {'bio': bio},
      where:
          'id = (SELECT id FROM user LIMIT 1)', // Mise à jour pour le seul utilisateur
    );
  }

  // Méthode pour mettre à jour l'avatar
  Future<int> updateLocation(String location) async {
    final db = await database;
    return await db.update(
      'user',
      {'favoriteLocation': location},
      where:
          'id = (SELECT id FROM user LIMIT 1)', // Mise à jour pour le seul utilisateur
    );
  }

  // Méthode pour ajouter un centre d'intérêt
  Future<int> addInterest(List<String> interests) async {
    final user = await getUser();
    if (user != null) {
      user.interests.addAll(interests);
      return await saveUser(
          user); // Met à jour l'utilisateur avec le nouvel intérêt
    }
    return 0;
  }

  // Méthode pour ajouter un about
  Future<int> addAbout(String about) async {
    final user = await getUser();
    if (user != null) {
      user.about.add(about);
      return await saveUser(
          user); // Met à jour l'utilisateur avec le nouvel about
    }
    return 0;
  }

  // Méthode pour retirer un centre d'intérêt
  Future<int> removeInterest(String interest) async {
    final user = await getUser();
    if (user != null) {
      user.interests.remove(interest);
      return await saveUser(
          user); // Met à jour l'utilisateur avec l'intérêt supprimé
    }
    return 0;
  }

  // Méthode pour retirer un about
  Future<int> removeAbout(String about) async {
    final user = await getUser();
    if (user != null) {
      user.about.remove(about);
      return await saveUser(
          user); // Met à jour l'utilisateur avec l'intérêt supprimé
    }
    return 0;
  }

  // Méthode pour ajouter un événement dans les favoris
  Future<int> addBookmarkedEvent(String eventId) async {
    final user = await getUser();
    if (user != null && !user.bookmarkedEventsId.contains(eventId)) {
      user.bookmarkedEventsId.add(eventId);
      return await saveUser(
          user); // Met à jour l'utilisateur avec le nouvel événement
    }
    return 0;
  }

  // Méthode pour ajouter un organizer dans les favoris
  Future<int> addBookmarkedOrganizer(String organizerId) async {
    final user = await getUser();
    if (user != null && !user.bookmarkedOrganizersId.contains(organizerId)) {
      user.bookmarkedOrganizersId.add(organizerId);
      return await saveUser(
          user); // Met à jour l'utilisateur avec le nouvel événement
    }
    return 0;
  }

  // Méthode pour récupérer les organisateurs suivis
  Future<List<String>> getBookmarkedOrganizers() async {
    final user = await getUser();
    if (user != null) {
      return user.bookmarkedOrganizersId;
    }
    return [];
  }

  // Méthode pour récupérer les events favoris
  Future<List<String>> getBookmarkedEvents() async {
    final user = await getUser();
    if (user != null) {
      return user.bookmarkedEventsId;
    }
    return [];
  }

  // Méthode pour retirer un événement des favoris
  Future<int> removeBookmarkedEvent(int eventId) async {
    final user = await getUser();
    if (user != null && user.bookmarkedEventsId.contains(eventId)) {
      user.bookmarkedEventsId.remove(eventId);
      return await saveUser(
          user); // Met à jour l'utilisateur avec l'événement retiré
    }
    return 0;
  }

  // Méthode pour retirer un événement des favoris
  Future<int> removeBookmarkedOrganizer(int organizerId) async {
    final user = await getUser();
    if (user != null && user.bookmarkedOrganizersId.contains(organizerId)) {
      user.bookmarkedOrganizersId.remove(organizerId);
      return await saveUser(
          user); // Met à jour l'utilisateur avec l'événement retiré
    }
    return 0;
  }
}
