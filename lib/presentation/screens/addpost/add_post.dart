import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business%20logic/posts/postcubit_cubit.dart';
import 'package:social_app/business%20logic/user/user_cubit.dart';
import 'package:social_app/presentation/screens/layout.dart';
import 'package:social_app/presentation/widgets/textForm.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: cutomeAppBar(
          press: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const SocialLayout(
                        index: 0,
                      )),
              (route) => false),
          title: "Create post",
          w: w),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.07,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          UserCubit.get(context).userModel!.image!),
                    ),
                    SizedBox(
                      width: w * 0.01,
                    ),
                    Text(
                      UserCubit.get(context).userModel!.name!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(height: 1.3),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                BlocConsumer<PostcubitCubit, PostcubitState>(
                  listener: (context, state) {
                    if (state is AddPostLoadingState) {
                      Fluttertoast.showToast(
                          msg: "Loading .....",
                          gravity: ToastGravity.TOP,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.white);
                    } else if (state is AddPostSuccessState) {
                      post.clear();
                      PostcubitCubit.get(context).removePostImage();
                      Fluttertoast.showToast(
                          msg: "your post Addedd Successfully .. ",
                          gravity: ToastGravity.TOP,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.green,
                          textColor: Colors.white);
                    } else if (state is AddPostErrorState) {
                      Fluttertoast.showToast(
                          msg: state.error.toString(),
                          gravity: ToastGravity.TOP,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        addPostTextForm(
                            controller: post,
                            hint: "what are you thinking ... "),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        (PostcubitCubit.get(context).postImage != null)
                            ? Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Image(
                                    image: FileImage(
                                        PostcubitCubit.get(context).postImage!),
                                    fit: BoxFit.cover,
                                    height: h * 0.2,
                                    width: double.infinity,
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        PostcubitCubit.get(context)
                                            .removePostImage();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: h * 0.35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  PostcubitCubit.get(context).getpostImage();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.image),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    const Text("Add photo")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.tags),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    const Text("Tags")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (PostcubitCubit.get(context).postImage ==
                                      null) {
                                    PostcubitCubit.get(context).createPost(
                                        name: UserCubit.get(context)
                                            .userModel!
                                            .name!,
                                        userImage: UserCubit.get(context)
                                            .userModel!
                                            .image!,
                                        content: post.text,
                                        dateTime:
                                            "${DateTime.now().year} , ${DateTime.now().month}, ${DateTime.now().day}",
                                        postImage: "");
                                  } else {
                                    PostcubitCubit.get(context).uploadPostImage(
                                      name: UserCubit.get(context)
                                          .userModel!
                                          .name!,
                                      userImage: UserCubit.get(context)
                                          .userModel!
                                          .image!,
                                      content: post.text,
                                      dateTime:
                                          "${DateTime.now().year} , ${DateTime.now().month}, ${DateTime.now().day}",
                                    );
                                  }
                                },
                                child: const Text("post"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
