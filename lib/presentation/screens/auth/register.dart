import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business%20logic/auth/sociallogin_cubit.dart';
import 'package:social_app/presentation/screens/auth/login.dart';
import 'package:social_app/presentation/widgets/defaultbutton.dart';

import '../../widgets/textForm.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
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
            if (state is SocialRegisertSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const LoginScreen()),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Regiser",
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
                      "create your account to contact with others ..",
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
                        hint: "UserName",
                        prefix: const Icon(
                          FontAwesomeIcons.user,
                          color: Colors.grey,
                        ),
                        obsecure: false,
                        textInputAction: TextInputAction.next,
                        focusNode: userNameFocus,
                        onEditingComplete: () {
                          userNameFocus.unfocus();
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "userNmae is required";
                          }
                          return null;
                        },
                        controller: userName),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    buildTextForm(
                        hint: "Email",
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
                        textInputAction: TextInputAction.next,
                        focusNode: passwordFocus,
                        onEditingComplete: () {
                          passwordFocus.unfocus();
                          FocusScope.of(context).requestFocus(phoneFocus);
                        },
                        controller: password),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    buildTextForm(
                        hint: "phone number",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "phone number is required";
                          } else if (value.length != 11) {
                            return "please enter valid phone number";
                          }
                          return null;
                        },
                        prefix: const Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.grey,
                        ),
                        obsecure: false,
                        textInputAction: TextInputAction.done,
                        focusNode: passwordFocus,
                        onEditingComplete: () {
                          phoneFocus.unfocus();
                        },
                        controller: phone),
                    SizedBox(
                      height: h * 0.08,
                    ),
                    ConditionalBuilder(
                      condition: state is! SocialRegisertLoadingState,
                      builder: (context) => DefaultButton(
                          press: () {
                            if (formkey.currentState!.validate()) {
                              SocialloginCubit.get(context).userRegister(
                                  email: email.text,
                                  name: userName.text,
                                  phone: phone.text,
                                  context: context,
                                  password: password.text);
                            }
                          },
                          title: "REGISTER"),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
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
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            "Login",
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
            );
          },
        ),
      ),
    );
  }
}
