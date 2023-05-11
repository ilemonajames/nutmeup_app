import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class ImageViews {
  BuildContext context;
  ImageViews(this.context);

  Widget ProfileImage(
      {required String? link, required double height, required double width}) {
    return Container(
      child: link == null
          ? Container(
              width: width,
              height: height,
              margin: const EdgeInsets.only(left: 5),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colorGray.withOpacity(.4),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Image.asset(
                "assets/images/icons/big_profile.png",
                width: 35,
                height: 35,
              ),
            )
          : Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(height / 2),
                  child: CachedNetworkImage(
                    imageUrl: link,
                    width: width,
                    height: height,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
            ),
    );
  }
}
