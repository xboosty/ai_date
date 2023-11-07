import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config/config.dart' show AppTheme;

class CardGradientPicture extends StatelessWidget {
  const CardGradientPicture({super.key, this.width, this.height, this.picture});

  final double? width;
  final double? height;
  final String? picture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: AppTheme.linearGradientReverse,
      ),
      child: CachedNetworkImage(
          imageUrl: picture ?? '',
          imageBuilder: (context, imageProvider) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          placeholder: (context, url) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      image: AssetImage('assets/imgs/no-image.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
          errorWidget: (context, url, error) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage('assets/imgs/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(30),
          //     image: image,
          //     // const DecorationImage(
          //     //   image: AssetImage('assets/imgs/girl2.png'),
          //     //   fit: BoxFit.cover,
          //     // ),
          //   ),
          // child:
          ),
    );
  }
}
