import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_gym_book/common/theme_helper.dart';
import 'package:my_gym_book/screens/signin/sign_in_screen.dart';
import 'package:my_gym_book/screens/signup/sign_up_screen.dart';
import 'package:my_gym_book/widgets/header_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final double _headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, "assets/splash.png", false, onTap: () {
                Navigator.pop(context);
              }),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bem vindo', style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen())),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text("Ou crie uma conta usando a mídia social",  style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const FaIcon(
                          FontAwesomeIcons.apple,
                          size: 35,
                          color: Colors.white
                      ),
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.", context);
                            },
                          );
                        });
                      },
                    ),
                    const SizedBox(width: 30.0),
                    GestureDetector(
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        size: 35,
                        color: HexColor("#EC2D2F"),
                      ),
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.", context);
                            },
                          );
                        });
                      },
                    ),
                    const SizedBox(width: 30.0),
                    GestureDetector(
                      child: FaIcon(
                          FontAwesomeIcons.facebook,
                          size: 35,
                          color: HexColor("#3E529C")
                      ),
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ThemeHelper().alartDialog("Facebook",
                                  "You tap on Facebook social icon.",
                                  context);
                            },
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}