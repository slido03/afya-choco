import '../models.dart';

class StatutMedical {
  final int _id;
  final Patient _patient;
  GroupeSanguin? _groupeSanguin;
  final List<String> _allergies = [];
  final List<String> _maladiesHereditaires = [];

  StatutMedical(
    this._id,
    this._patient,
    this._groupeSanguin,
  );

  int get id => _id;
  Patient get patient => _patient;
  GroupeSanguin? get groupeSanguin => _groupeSanguin;
  List<String> get allergies => _allergies;
  List<String> get maladiesHereditaires => _maladiesHereditaires;
  String get groupeSanguinToString {
    switch (groupeSanguin) {
      case GroupeSanguin.aPositif:
        return 'A+';
      case GroupeSanguin.aNegatif:
        return 'A-';
      case GroupeSanguin.bPositif:
        return 'B+';
      case GroupeSanguin.bNegatif:
        return 'B-';
      case GroupeSanguin.oPositif:
        return 'O+';
      case GroupeSanguin.oNegatif:
        return 'O-';
      case GroupeSanguin.abPositif:
        return 'AB+';
      case GroupeSanguin.abNegatif:
        return 'AB-';
      default:
        return 'aucun';
    }
  }

  void setGroupeSanguin(GroupeSanguin groupeSanguin) =>
      _groupeSanguin = groupeSanguin;

  void ajouterAllergie(String allergie) => _allergies.add(allergie);
  void ajouterMaladie(String maladie) => _maladiesHereditaires.add(maladie);
  void supprimerAllergie(String allergie) => _allergies.remove(allergie);
  void supprimerMaladie(String maladie) =>
      _maladiesHereditaires.remove(maladie);
}
