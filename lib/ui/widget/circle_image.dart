import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pollingstation/config/constant.dart';

import '../../res/app_icon.dart';

Widget circleImage(String images, [double? height, double? width]) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        images,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget circleFileImage(File images, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.file(
        images,
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
    ),
  );
}

Widget flatImage(String images, [double? height, double? width]) {
  return SizedBox(
    height: height,
    width: width,
    child: Image.asset(
      images,
      fit: BoxFit.cover,
    ),
  );
}

Widget flatFileImage(File images, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Image.file(
      images,
      fit: BoxFit.cover,
      height: height,
      width: width,
    ),
  );
}

Widget circleNetworkImage(String url,
    [double? height, double? width, bool? border]) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: border ?? false ? 1 : 0),
        borderRadius: BorderRadius.circular(100)),
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: imageUrl+url,
        fit: BoxFit.fill,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset(
          AppIcon.icApp,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget networkImageView(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.fill,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => Image.asset(
      AppIcon.icApp,
      fit: BoxFit.fill,
    ),
  );
}
