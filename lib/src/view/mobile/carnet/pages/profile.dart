import 'package:flutter/material.dart';

// import de Material Symbols
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Map<String, dynamic> _patient = {
    'nom': 'ATOULELE',
    'prenoms': 'Kiffo Albert',
    'telephone': "92312387",
    'email': 'atoulelekiffo23@gmail.com',
    'adresse': 'Ségbé, rue 218',
    'dateNaissance': '02/20/2000',
    'sexe': 'Masculin',
  }; // on recuperera les infos du patient dans la BD

  // ignore: non_constant_identifier_names
  final Map<String, dynamic> _status_medical = {
    'groupeSanguin': 'A+',
    'alergies': ['blibli', 'blabla', 'bloblo'],
    'maladies-hereditaires': [],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
            //padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Informations civiques",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _patient
                          .isEmpty // ou si le status medical n'a pas été renseigné / trouvé
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 10,
                          ),
                          child: Text(
                              "Vos informations civiques n'ont pas encore été renseignées par un professionnel de santé",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient['nom'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _patient['prenoms'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient['telephone'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient['email'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient["adresse"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient["dateNaissance"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.wc,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          _patient["sexe"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Status médical",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _status_medical
                          .isEmpty // ou si le status medical n'a pas été renseigné / trouvé
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 10,
                          ),
                          child: Text(
                              "Votre status médical n'a pas encore été renseignés par un professionnel de santé",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .80,
                                  ),
                                  Row(
                                    children: [
                                      // Icon de groupe sanguin
                                      Icon(
                                        Icons.bloodtype,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _status_medical["groupeSanguin"],
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Text(
                                        "(Groupe sanguin)",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      // Icon d'alergies via google font
                                      Icon(
                                        MaterialSymbols.allergies,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _status_medical["alergies"].isEmpty
                                            ? "Aucun"
                                            : _status_medical["alergies"]
                                                .join(",\n"),
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Text(
                                        "(Alergies)",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      // Icon de maladies hereditaires
                                      Icon(
                                        MaterialSymbols.genetics,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        _status_medical["maladies-hereditaires"]
                                                .isEmpty
                                            ? "Aucun"
                                            : _status_medical[
                                                    "maladies-hereditaires"]
                                                .join(",\n"),
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Text(
                                        "(Maladies hereditaires)",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
