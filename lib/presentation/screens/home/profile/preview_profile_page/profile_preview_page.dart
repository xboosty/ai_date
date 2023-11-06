import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/config.dart' show SharedPref, UserEntity;
import '../../../../common/widgets/widgets.dart'
    show CardProfile, PlaceholderCard;

class ProfilePreviewPage extends StatefulWidget {
  const ProfilePreviewPage({super.key});

  @override
  State<ProfilePreviewPage> createState() => ProfilePreviewPageState();
}

class ProfilePreviewPageState extends State<ProfilePreviewPage> {
  UserEntity? user;

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> userMap = jsonDecode(SharedPref.pref.account);
      user = UserEntity.fromJson(userMap);
    } catch (e) {
      print('Ocurrio un error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (user?.avatar != null) {
      return CachedNetworkImage(
        imageUrl: user?.avatar ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: size.width * 0.80,
          height: size.height,
          alignment: Alignment.center,
          child: CardProfile(
            user: user!,
            imageProvider: imageProvider,
          ),
        ),
        placeholder: (context, url) => const PlaceholderCard(
          assetImage: 'assets/imgs/loading.gif',
        ),
        errorWidget: (context, url, error) => const PlaceholderCard(
          assetImage: 'assets/imgs/no-image.jpg',
        ),
      );
    } else {
      return const PlaceholderCard(
        assetImage: 'assets/imgs/no-image.jpg',
      );
    }
  }
}
