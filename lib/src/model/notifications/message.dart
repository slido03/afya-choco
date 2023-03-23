import '../models.dart';

class Message {
  final int _id;
  final Personne _expediteur;
  final Personne _destinataire;
  final DateTime _dateHeure;
  final ObjetMessage _objet;
  final String _contenu;
  StatutMessage _statut;

  Message(
    this._id,
    this._expediteur,
    this._destinataire,
    this._dateHeure,
    this._objet,
    this._contenu,
    this._statut,
  );

  int get id => _id;
  Personne get expediteur => _expediteur;
  Personne get destinataire => _destinataire;
  DateTime get dateHeure => _dateHeure;
  ObjetMessage get objet => _objet;
  String get contenu => _contenu;
  StatutMessage get statut => _statut;

  void setSatut(StatutMessage statut) => _statut = statut;
}
