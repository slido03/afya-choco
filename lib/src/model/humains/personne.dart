class Personne {
  final int _id;
  String _nom;
  String _prenoms;
  String _telephone;
  String _email;
  String? _adresse;

  Personne(
    this._id,
    this._nom,
    this._prenoms,
    this._telephone,
    this._email,
    this._adresse,
  );

  int get id => _id;
  String get nom => _nom;
  String get prenoms => _prenoms;
  String get telephone => _telephone;
  String get email => _email;
  String? get adresse => _adresse;
  String get nomComplet => '$nom $prenoms';

  void setNom(String nom) => _nom = nom;
  void setPrenom(String prenoms) => _prenoms = prenoms;
  void setTelephone(String telephone) => _telephone = telephone;
  void setEmail(String email) => _email = email;
  void setAdresse(String adresse) => _adresse = adresse;
}
