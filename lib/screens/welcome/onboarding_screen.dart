import 'package:flutter/material.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/screens/welcome/welcome_screen.dart';
import 'package:my_gym_book/widgets/custom_button.dart';
import 'package:my_gym_book/widgets/custom_link.dart';
import 'package:my_gym_book/widgets/custom_paginator.dart';
import 'package:my_gym_book/widgets/custom_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsService.logEvent(
        "onboarding_start",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            physics: const ClampingScrollPhysics(),
            children: [
              CustomSlider(
                image: 'assets/onboarding_1.png',
                title: 'Gerenciar seus treinos nunca foi tão fácil',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
                text: 'Avalie seus rendimentos, organize e aprimore seus treinos de uma maneira facil e iterativa',

                textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                ),
              ),
              CustomSlider(
                image: 'assets/onboarding_2.png',
                title: 'Acompanhe e gerencie seus treinos a qualquer hora, em qualquer lugar e sem complicações',
                titleStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
                text: 'Apenas com seu celular, é possível acompanhar e gerenciar todos seus treinos de uma maneira rápida e eficiente',
                textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                ),
              ),
              CustomSlider(
                image: 'assets/onboarding_3.png',
                title: 'Defina objetivos e alcance eles',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
                text:
                'Com uso das ferramentas de gerenciamento, é possível criar planos para alcançar suas metas e objetivos de forma fácil e dinâmica',
                textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buttonsList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLink(
                  titulo: 'Pular introdução',
                  irParaPaginaInicial: irParaPaginaInicial,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 170.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaginator(
                  page: _currentPage,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> buttonsList() {

    List<Widget> buttonsList = [];

    if(_currentPage != 0) {
      buttonsList.add(
          backButton()
      );
    }

    buttonsList.add(
      CustomButton(
        title: _currentPage == 2 ? 'Vamos começar' : 'Continuar',
        irParaPaginaInicial: _currentPage == 2 ? irParaPaginaInicial : proximoCard,
        borderColor: Colors.deepPurple,
        backgroundColor: Colors.blueAccent,
        isUserInteractive: true,
      )
    );

    return buttonsList;
  }

  void irParaPaginaInicial() {
    FirebaseAnalyticsService.logEvent(
        "onboarding_finish",
        {}
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    _setEstado();
  }

  void proximoCard() {
    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void voltarCard() {
    _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  _setEstado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ativo = prefs.getBool('ONBOARDING') ?? false;

    if (!ativo) {
      await prefs.setBool('ONBOARDING', true);
    }
  }

  Widget backButton() {
    return CustomButton(
      title: 'Voltar',
      irParaPaginaInicial: voltarCard,
      borderColor: Colors.black12,
      backgroundColor: Colors.black38,
      isUserInteractive: _currentPage != 0,
    );
  }
}