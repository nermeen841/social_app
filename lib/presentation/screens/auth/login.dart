import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business%20logic/auth/sociallogin_cubit.dart';
import 'package:social_app/presentation/screens/auth/register.dart';
import 'package:social_app/presentation/screens/home/homescreen.dart';
import 'package:social_app/presentation/screens/layout.dart';
import 'package:social_app/presentation/widgets/defaultbutton.dart';
import 'package:social_app/presentation/widgets/textForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool secureText = true;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocProvider<SocialloginCubit>(
      create: (context) => SocialloginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 0.0,
        ),
        body: BlocConsumer<SocialloginCubit, SocialloginState>(
          listener: (context, state) {
            if (state is SocialloginSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const SocialLayout(
                        index: 0,
                      )),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: h * 0.03, horizontal: w * 0.03),
              child: Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: h * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                            color: Colors.black54,
                            fontSize: w * 0.1),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Text(
                        "you can connect with poeple from all world ..",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                            color: Colors.grey,
                            fontSize: w * 0.04),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      buildTextForm(
                          hint: "Email or Username",
                          prefix: const Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.grey,
                          ),
                          obsecure: false,
                          textInputAction: TextInputAction.next,
                          focusNode: emailFocus,
                          onEditingComplete: () {
                            emailFocus.unfocus();
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "email is required";
                            } else if (!value.contains("@") ||
                                !value.contains(".com")) {
                              return "please enter valid email";
                            }
                            return null;
                          },
                          controller: email),
                      SizedBox(
                        height: h * 0.03,
                      ),
                      buildTextForm(
                          hint: "Password",
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "password is required";
                            } else if (value.length < 8) {
                              return "password must be at least 8 characters";
                            }
                            return null;
                          },
                          prefix: (secureText)
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      secureText = !secureText;
                                    });
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.grey,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      secureText = !secureText;
                                    });
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.grey,
                                  ),
                                ),
                          obsecure: secureText,
                          textInputAction: TextInputAction.done,
                          focusNode: passwordFocus,
                          onEditingComplete: () {
                            passwordFocus.unfocus();
                          },
                          controller: password),
                      SizedBox(
                        height: h * 0.08,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialloginLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        ),
                        builder: (context) => DefaultButton(
                            press: () {
                              if (formkey.currentState!.validate()) {
                                SocialloginCubit.get(context).login(
                                    email: email.text,
                                    password: password.text,
                                    context: context);
                              }
                            },
                            title: "LOGIN"),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                                color: Colors.black,
                                fontSize: w * 0.04),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  color: Colors.green,
                                  fontSize: w * 0.04),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
