import '../models.dart';
import 'package:faker/faker.dart';

class Message {
  final Utilisateur _expediteur;
  final Utilisateur _destinataire;
  final DateTime _dateHeure;
  final ObjetMessage _objet;
  final String _contenu;
  StatutMessage _statut;

  Message(
    this._expediteur,
    this._destinataire,
    this._dateHeure,
    this._objet,
    this._contenu,
    this._statut,
  );

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      Utilisateur.fromJson(json['expediteur']),
      Utilisateur.fromJson(json['destinataire']),
      DateTime.fromMillisecondsSinceEpoch(json['dateHeure']),
      parseObjet(json['objet']),
      json['contenu'],
      parseStatut(json['statut']),
    );
  }

  factory Message.faker(
    Utilisateur expediteur,
    Utilisateur destinataire,
  ) {
    var faker = Faker();
    var dateHeure = faker.date.dateTime(minYear: 2022, maxYear: 2024);
    var contenu = faker.lorem.sentence();
    return Message(
      expediteur,
      destinataire,
      dateHeure,
      ObjetMessageExtension.faker(),
      contenu,
      StatutMessageExtension.faker(),
    );
  }

  Utilisateur get expediteur => _expediteur;
  Utilisateur get destinataire => _destinataire;
  DateTime get dateHeure => _dateHeure;
  ObjetMessage get objet => _objet;
  String get contenu => _contenu;
  StatutMessage get statut => _statut;

  void changerStatut(StatutMessage statut) => _statut = statut;

  Map<String, dynamic> toJson() => {
        'expediteur': expediteur.toJson(),
        'destinataire': destinataire.toJson(),
        'dateHeure': dateHeure.millisecondsSinceEpoch,
        'objet': objet.name,
        'contenu': contenu,
        'statut': statut.name,
      };

  static ObjetMessage parseObjet(String name) {
    ObjetMessage objet = ObjetMessage.values
        .firstWhere((o) => o.toString() == 'ObjetMessage.$name');
    return objet;
  }

  static StatutMessage parseStatut(String name) {
    StatutMessage statut = StatutMessage.values
        .firstWhere((s) => s.toString() == 'StatutMessage.$name');
    return statut;
  }
}
