import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business%20logic/user/user_cubit.dart';
import 'package:social_app/presentation/widgets/defaultbutton.dart';
import 'package:social_app/presentation/widgets/textForm.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FocusNode nameFocuse = FocusNode();
  FocusNode bioFocuse = FocusNode();
  FocusNode phoneFocuse = FocusNode();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    name.text = UserCubit.get(context).userModel!.name!;
    bio.text = UserCubit.get(context).userModel!.bio!;
    phone.text = UserCubit.get(context).userModel!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: cutomeAppBar(
          press: () => Navigator.pop(context), title: "Edit profile", w: w),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileImage = UserCubit.get(context).profileImage;
          var coverImage = UserCubit.get(context).coverImage;

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.35,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: h * 0.23,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    image: (coverImage != null)
                                        ? DecorationImage(
                                            image: FileImage(coverImage),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(
                                              UserCubit.get(context)
                                                  .userModel!
                                                  .cover!,
                                            ),
                                            fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await UserCubit.get(context)
                                        .getCoverImage();
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.cameraRotate,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: w * 0.22,
                                backgroundColor: Colors.white,
                                child: (profileImage != null)
                                    ? CircleAvatar(
                                        radius: w * 0.2,
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            FileImage(profileImage),
                                      )
                                    : CircleAvatar(
                                        radius: w * 0.2,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            UserCubit.get(context)
                                                .userModel!
                                                .image!),
                                      ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await UserCubit.get(context)
                                      .getProfileImage();
                                },
                                color: Colors.green,
                                icon: const Icon(
                                  FontAwesomeIcons.cameraRotate,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    buildTextForm(
                      hint: "Name",
                      prefix: const Icon(FontAwesomeIcons.user),
                      obsecure: false,
                      textInputAction: TextInputAction.next,
                      focusNode: nameFocuse,
                      controller: name,
                      onEditingComplete: () {
                        nameFocuse.unfocus();
                        FocusScope.of(context).requestFocus(bioFocuse);
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    buildTextForm(
                      hint: "bio ..",
                      prefix: const Icon(Icons.edit_outlined),
                      obsecure: false,
                      textInputAction: TextInputAction.next,
                      focusNode: bioFocuse,
                      controller: bio,
                      onEditingComplete: () {
                        bioFocuse.unfocus();
                        FocusScope.of(context).requestFocus(phoneFocuse);
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    buildTextForm(
                      hint: "phone number",
                      prefix: const Icon(Icons.edit_outlined),
                      obsecure: false,
                      textInputAction: TextInputAction.next,
                      focusNode: phoneFocuse,
                      controller: phone,
                      onEditingComplete: () {
                        phoneFocuse.unfocus();
                      },
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateUserLoadingState,
                      builder: (context) => DefaultButton(
                        press: () {
                          UserCubit.get(context).updateUserData(
                              email: UserCubit.get(context).userModel!.email!,
                              name: name.text,
                              bio: bio.text,
                              cover: (UserCubit.get(context).coverImageUrl !=
                                      '')
                                  ? UserCubit.get(context).coverImageUrl
                                  : UserCubit.get(context).userModel!.cover!,
                              profile:
                                  (UserCubit.get(context).profileImageUrl != '')
                                      ? UserCubit.get(context).profileImageUrl
                                      : UserCubit.get(context)
                                          .userModel!
                                          .image!,
                              phone: phone.text);
                        },
                        title: "UPDATE",
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
