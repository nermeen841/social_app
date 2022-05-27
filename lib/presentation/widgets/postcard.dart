import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostCardItem extends StatelessWidget {
  final String content;
  final String postImage;
  final String myImage;
  final String userImage;
  final String name;
  final String dateTime;

  const PostCardItem(
      {Key? key,
      required this.content,
      required this.postImage,
      required this.userImage,
      required this.name,
      required this.myImage,
      required this.dateTime})
      : super(key: key);

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
                  backgroundImage: NetworkImage(userImage),
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
                          name,
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
                      dateTime,
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
              content,
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
            (postImage != "")
                ? Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0.0,
                    margin: EdgeInsets.zero,
                    child: Image(
                      image: NetworkImage(postImage),
                      fit: BoxFit.cover,
                      height: h * 0.2,
                      width: double.infinity,
                    ),
                  )
                : const SizedBox(),
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
                  backgroundImage: NetworkImage(myImage),
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
