// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/business%20logic/user/user_cubit.dart';
import 'package:social_app/presentation/screens/auth/login.dart';
import 'package:social_app/presentation/screens/layout.dart';
import 'business logic/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget screen = const LoginScreen();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String uId = prefs.getString('token').toString();
  if (uId != "null") {
    screen = const SocialLayout();
  } else {
    screen = const LoginScreen();
  }

  BlocOverrides.runZoned(() {
    runApp(MyApp(
      startScreen: screen,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  const MyApp({Key? key, this.startScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
              create: (context) => UserCubit()..getUserData()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: startScreen,
        ));
  }
}
