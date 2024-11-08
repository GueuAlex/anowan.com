class CentreInteretModel {
  final String category;
  final List<String> centres;

  CentreInteretModel({
    required this.category,
    required this.centres,
  });

  /// Liste d'intérets par catégorie
  static List<CentreInteretModel> centreInteretList = [
    CentreInteretModel(category: 'Activités sociales', centres: [
      'Rencontres amicales',
      'Soirées jeux',
      'Sorties cinéma',
      'Dîners partagés',
      'Discussions ouvertes',
      'Ateliers créatifs',
      'Groupes de lecture',
      'Événements culturels',
    ]),
    CentreInteretModel(category: 'Animaux', centres: [
      'Protection animale',
      'Dressage chien',
      'Randonnée canine',
      'Photographie animalière',
      'Soins vétérinaires',
      'Adoption responsable',
      'Zoos et aquariums',
      'Éducation animale',
    ]),
    CentreInteretModel(category: 'Carrière et affaires', centres: [
      'Entrepreneuriat',
      'Réseautage professionnel',
      'Développement carrière',
      'Mentorat affaires',
      'Stratégie d’entreprise',
      'Création startups',
      'Marketing digital',
      'Consultation affaires',
    ]),
    CentreInteretModel(category: 'Communauté et environnement', centres: [
      'Recyclage',
      'Nettoyage plage',
      'Jardins communautaires',
      'Sensibilisation écologique',
      'Collecte déchets',
      'Conservation nature',
      'Protection faune',
      'Énergies renouvelables',
    ]),
    CentreInteretModel(category: 'Danse', centres: [
      'Danse classique',
      'Danse moderne',
      'Hip-hop',
      'Salsa',
      'Tango',
      'Zumba',
      'Breakdance',
      'Danse africaine',
    ]),
    CentreInteretModel(category: 'Hobbies et passions', centres: [
      'Photographie',
      'Cuisine',
      'Peinture',
      'Lecture',
      'Modélisme',
      'Couture',
      'Dessin',
      'Jardinage',
    ]),
    CentreInteretModel(category: 'Identité et langue', centres: [
      'Bilinguisme',
      'Langue des signes',
      'Traditions locales',
      'Échange culturel',
      'Langue maternelle',
      'Diversité linguistique',
      'Patrimoine oral',
      'Dialectes régionaux',
    ]),
    CentreInteretModel(category: 'Jeux', centres: [
      'Jeux vidéo',
      'Jeux de société',
      'Escape games',
      'Jeux de rôle',
      'E-sport',
      'Jeux de cartes',
      'Puzzles',
      'Jeux d’échecs',
    ]),
    CentreInteretModel(category: 'Parents et Famille', centres: [
      'Activités enfants',
      'Éducation parentale',
      'Parentalité positive',
      'Sorties familiales',
      'Éducation bienveillante',
      'Pédagogie Montessori',
      'Relations frères-sœurs',
      'Familles monoparentales',
    ]),
    CentreInteretModel(category: 'Musique', centres: [
      'Piano',
      'Guitare',
      'Chorale',
      'Musique électronique',
      'Jazz',
      'Musique classique',
      'Rock',
      'Compositions musicales',
    ]),
    CentreInteretModel(category: 'Religion et spiritualité', centres: [
      'Méditation',
      'Prière collective',
      'Spiritualité universelle',
      'Cérémonies religieuses',
      'Études bibliques',
      'Rituels traditionnels',
      'Communion spirituelle',
      'Retraites spirituelles',
    ]),
    CentreInteretModel(category: 'Santé et bien-être', centres: [
      'Yoga',
      'Relaxation',
      'Méditation pleine conscience',
      'Nutrition',
      'Santé mentale',
      'Thérapies alternatives',
      'Fitness',
      'Soins naturels',
    ]),
    CentreInteretModel(category: 'Sport et fitness', centres: [
      'Course à pied',
      'Natation',
      'Cyclisme',
      'Musculation',
      'Football',
      'Tennis',
      'Basketball',
      'Escalade',
    ]),
    CentreInteretModel(category: 'Sciences et éducation', centres: [
      'Astronomie',
      'Chimie',
      'Mathématiques',
      'Programmation',
      'Biologie',
      'Éducation technologique',
      'Physique',
      'Apprentissage linguistique',
    ]),
    CentreInteretModel(category: 'Soutien et coaching', centres: [
      'Coaching personnel',
      'Développement personnel',
      'Aide psychologique',
      'Mentorat jeunes',
      'Coaching carrière',
      'Accompagnement scolaire',
      'Soutien parental',
      'Gestion du stress',
    ]),
    CentreInteretModel(category: 'Technologie', centres: [
      'Programmation web',
      'Intelligence artificielle',
      'Cryptomonnaies',
      'Réalité virtuelle',
      'Sécurité informatique',
      'Impression 3D',
      'Domotique',
      'Innovation technologique',
    ]),
    CentreInteretModel(category: 'Écriture', centres: [
      'Poésie',
      'Journalisme',
      'Écriture créative',
      'Rédaction web',
      'Scénarios',
      'Blogging',
      'Roman',
      'Écriture scientifique',
    ]),
    CentreInteretModel(category: 'Voyages, tourisme et plein air', centres: [
      'Randonnée',
      'Camping',
      'Road trips',
      'Tourisme culturel',
      'Aventures en plein air',
      'Plongée sous-marine',
      'Photographie de voyage',
      'Visites guidées',
    ]),
  ];

  static List<String> allTags = centreInteretList
      .map((category) => category.centres)
      .expand((centres) => centres)
      .toList();
}
