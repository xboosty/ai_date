import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../config/config.dart' show UserEntity;
import 'opacity_card_unblock.dart';
import 'title_unblock_user.dart';

class CardUnblockProfile extends StatelessWidget {
  const CardUnblockProfile({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CachedNetworkImage(
      imageUrl: user.avatar,
      imageBuilder: (context, imageProvider) => Container(
        height: size.height * 0.90,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TitleUnblockUser(size: size, name: user.name),
            const Spacer(),
            OpacityCardUnblock(
              user: user,
            ),
          ],
        ),
      ),
      placeholder: (context, _) => Container(
        height: size.height * 0.90,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/no-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TitleUnblockUser(size: size, name: user.name),
            const Spacer(),
            OpacityCardUnblock(
              user: user,
            ),
          ],
        ),
      ),
      errorWidget: (context, _, __) => Container(
        height: size.height * 0.90,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/no-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TitleUnblockUser(size: size, name: user.name),
            const Spacer(),
            OpacityCardUnblock(
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}
