import 'package:flutter/material.dart';
import 'package:my_gym_book/common/exceptions/FirebaseCustomException.dart';
import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/common/services/firebase_auth_service.dart';
import 'package:my_gym_book/common/theme_helper.dart';
import 'package:my_gym_book/repository/firebase_user_repository.dart';
import 'package:my_gym_book/screens/home/home_screen.dart';
import 'package:my_gym_book/widgets/header_widget.dart';


class SignUpScreen extends  StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>{
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String fullName = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, "assets/splash.png", true, onTap: () {
                Navigator.pop(context);
              }), //let's create a common header widget
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Cadastro",
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: fullNameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: ThemeHelper().textInputDecoration('Nome', 'Insira seu nome'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "A nome é obrigatória";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: ThemeHelper().textInputDecoration("Email", "Insira o email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(val!.isNotEmpty && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Insira um Email válido";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: passwordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Senha*", "Insira a senha"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "A senha é obrigatória";
                              } else if(val.length < 6) {
                                return "Senha fraca";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: ThemeHelper().textInputDecoration(
                                "Confirme a senha*", "Confirme a senha"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Confirmar a senha é obrigatório";
                              } else if(val != passwordController.text) {
                                return "As senhas não coincidem";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: checkboxValue,
                                        side: const BorderSide(
                                          color: Colors.grey, //your desire colour here
                                          width: 1.5,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        debugPrint("Termos de privacidade e uso");
                                      },
                                      child: RichText(
                                        text: const TextSpan(
                                          text: 'Eu aceito todos',
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                                text: ' Termos de privacidade e uso',
                                                style: TextStyle(color: Colors.blueAccent)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).colorScheme.error,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Você precisa aceitar os termos e condições';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Cadastrar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var email = emailController.text;
                                var fullname = fullNameController.text;
                                var password = passwordController.text;
                                signUpWithFirebaseBaseEmail(email, fullname, password);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createUserInDB(String email, String fullname, String userId) async {
    var user = UserModel(
      fullname,
      email,
      "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"
    );
    await createUser(user);
  }

  Future<void> signUpWithFirebaseBaseEmail(String email,String fullname, String password) async {
    if(email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Dados invalídos", "Informe o email e senha para realizar o cadastro.", context);
        },
      );
      return;
    }
    try {
      var userId = await registerUser(email, password);
      if(userId == null) {
        return;
      }
      debugPrint("user created");

      FirebaseAnalyticsService.logEvent(
          "signup_success",
          {
            "fullname": fullname,
            "email": email
          }
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const HomeScreen()
          ),
              (Route<dynamic> route) => false
      );
      createUserInDB(email, fullname, userId);
    } on FirebaseCustomException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Ops, ocorreu um erro, tente novamente mais tarde ou entre em contato com o suporte", e.cause, context);
        },
      );
    }
  }
}