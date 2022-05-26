// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/business%20logic/user/user_cubit.dart';
import 'package:social_app/presentation/screens/auth/login.dart';
import 'package:social_app/presentation/screens/setting/updateprofile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserLoadingState,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.35,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: h * 0.23,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                                image: NetworkImage(
                                  UserCubit.get(context).userModel!.cover!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: w * 0.22,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: w * 0.2,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              UserCubit.get(context).userModel!.image!),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  UserCubit.get(context).userModel!.name!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Text(
                  UserCubit.get(context).userModel!.bio!,
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: h * 0.02, horizontal: w * .02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            "posts",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            "Likes",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            "Followers",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          Text(
                            "followering",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: h * 0.02, horizontal: w * .02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: h * 0.06,
                        width: w * 0.3,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Add photo"),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.06,
                        width: w * 0.3,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateProfile()));
                          },
                          child: const Text("Edit profile"),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.06,
                        width: w * 0.23,
                        child: OutlinedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            FirebaseAuth.instance.signOut().then((value) {
                              prefs.clear();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            }).catchError((e) {
                              print(e.toString());
                            });
                          },
                          child: const Text("Log out"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
