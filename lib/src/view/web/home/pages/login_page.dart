import 'package:flutter/material.dart';

import '../../authentication/login_form.dart';
import '../../constant/afya_logo.dart';
import '../components/home_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  late double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/banner-img-3.jpg'),
            fit: BoxFit.cover,
          ),
<<<<<<< HEAD
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.only(left: 90, right: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: AfyaLogo(),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: HomeContainer1(),
                        ),
                        SizedBox(
                            width: 70,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Colors.red,
                            )),
                        Expanded(
                          child: Login(),
                        ),
                      ],
=======
          child: const SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.0,),
                  child: AfyaLogo(),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 70),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: HomeContainer1(),
                          ),
                          SizedBox(
                              width: 70,
                              child: VerticalDivider(
                                thickness: 2,
                                color: Colors.red,
                              )),
                          Expanded(
                            child: Login(),
                          ),
                        ],
                      ),
>>>>>>> 1772f7950f67f1d4cfc9496f5144b0fd04aa5d31
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
