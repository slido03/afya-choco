//import 'package:flutter/foundation.dart';
import 'package:afya/src/view/mobile/carnet/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/view/mobile/authentication/authentication.dart';

class PopupMenuUser extends StatefulWidget {
  const PopupMenuUser({super.key});

  @override
  State<PopupMenuUser> createState() => _PopupMenuUserState();
}

class _PopupMenuUserState extends State<PopupMenuUser> {
  AuthService authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> uid = authService.getCurrentUserUid();

    return FutureBuilder(
        future: Future.wait([uid]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<String?> data = result.data!;
            final userId = data[0];
            //si l'utilisateur est connecté
            if (userId != null) {
              return PopupMenuButton(
                icon: const Icon(Icons.person_2_outlined),
                itemBuilder: (context) => [
                  // user profile
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.person_2_outlined, color: Colors.black),
                        SizedBox(width: 10.0),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  // logout
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 10.0),
                        Text('Déconnexion'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: const Text('Profile'),
                            ),
                            body: Center(
                              child: Profile(
                                userId: userId,
                              ),
                            ),
                          ),
                        ),
                      );
                      break;
                    case 2:
                      logout(context);
                      break;
                  }
                },
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          }
          //en cas d'erreur quelconque (result.hasError)
          return Center(child: Text('Erreur: ${result.error}'));
        });
  }
}
