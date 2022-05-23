import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostCardItem extends StatelessWidget {
  const PostCardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.015),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(w * .02),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: w * 0.07,
                  backgroundColor: Colors.white,
                  backgroundImage: const NetworkImage(
                      "https://img.freepik.com/free-photo/close-up-distracted-guy-with-glasses_1149-895.jpg?t=st=1653314444~exp=1653315044~hmac=d4efde9c39d55b350bf751c05ba2dac0149e4d79f80571c44310d2a985364e01&w=360"),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Nermeen Ramadan",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(height: 1.3),
                        ),
                        SizedBox(
                          width: w * 0.01,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: w * 0.04,
                        ),
                      ],
                    ),
                    Text(
                      "january 21 , 2021 at 11 p.m",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.3),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: w * 0.05,
                    ))
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Center(
              child: SizedBox(
                width: w * 0.8,
                child: Divider(
                  color: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w400, height: 1.4),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                MaterialButton(
                  padding: EdgeInsets.zero,
                  height: h * 0.02,
                  minWidth: w * 0.02,
                  onPressed: () {},
                  child: Text(
                    "#software",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.green),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  height: h * 0.02,
                  minWidth: w * 0.02,
                  onPressed: () {},
                  child: Text(
                    "#flutter",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.green),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  height: h * 0.02,
                  minWidth: w * 0.02,
                  onPressed: () {},
                  child: Text(
                    "#digital",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0.0,
              margin: EdgeInsets.zero,
              child: Image(
                image: const NetworkImage(
                    "https://img.freepik.com/free-psd/photo-frame-set-mockup-with-doodle-ornament_17005-1307.jpg?t=st=1653313699~exp=1653314299~hmac=534b79454ccd1ce63e38d32f7a0ef375d737f02f6907cee3b87e620007a52abb&w=360"),
                fit: BoxFit.cover,
                height: h * 0.2,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: h * 0.015,
            ),
            Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "5 likes",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        FontAwesomeIcons.comment,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "5 comments",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.amber,
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            const Divider(),
            SizedBox(
              height: h * 0.015,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: w * 0.05,
                  backgroundColor: Colors.white,
                  backgroundImage: const NetworkImage(
                      "https://img.freepik.com/free-photo/close-up-distracted-guy-with-glasses_1149-895.jpg?t=st=1653314444~exp=1653315044~hmac=d4efde9c39d55b350bf751c05ba2dac0149e4d79f80571c44310d2a985364e01&w=360"),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Row(
                  children: [
                    Text("write a comment ....",
                        style: Theme.of(context).textTheme.caption!),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "like",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.blueGrey,
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: w * 0.04,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        FontAwesomeIcons.share,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Share",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.blueGrey,
                            ),
                      ),
                    )
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
