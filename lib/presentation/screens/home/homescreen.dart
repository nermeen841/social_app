// ignore_for_file: avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/business%20logic/posts/postcubit_cubit.dart';
import 'package:social_app/presentation/widgets/postcard.dart';
import '../../../business logic/user/user_cubit.dart';
import '../../widgets/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetUserLoadingState,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                (!FirebaseAuth.instance.currentUser!.emailVerified)
                    ? Container(
                        color: Colors.yellow.withOpacity(0.7),
                        height: h * 0.06,
                        padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                        child: Center(
                          child: homeBannar(
                              w: w,
                              press: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: "please check your email",
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.CENTER,
                                      toastLength: Toast.LENGTH_LONG);
                                }).catchError((e) {
                                  print(e.toString());
                                });
                              }),
                        ),
                      )
                    : const SizedBox(),
                (!FirebaseAuth.instance.currentUser!.emailVerified)
                    ? SizedBox(
                        height: h * 0.015,
                      )
                    : const SizedBox(),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * .02),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: const NetworkImage(
                              "https://img.freepik.com/free-photo/vintage-lighting-decor-filtered-image-processed-vintage-effe_1232-3037.jpg?t=st=1653313699~exp=1653314299~hmac=df631bd800223611762b711ced63f241969c4cda31b682ba73472826dc9c950a&w=360"),
                          fit: BoxFit.cover,
                          height: h * 0.2,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "communicate with friends",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<PostcubitCubit, PostcubitState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: PostcubitCubit.get(context).posts.length,
                      itemBuilder: (context, index) => PostCardItem(
                        content: PostcubitCubit.get(context).posts[index].text!,
                        dateTime:
                            PostcubitCubit.get(context).posts[index].dateTime!,
                        name: PostcubitCubit.get(context).posts[index].name!,
                        userImage:
                            PostcubitCubit.get(context).posts[index].image!,
                        postImage:
                            PostcubitCubit.get(context).posts[index].postImage!,
                        myImage: UserCubit.get(context).userModel!.image!,
                      ),
                    );
                  },
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
