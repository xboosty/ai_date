import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart'
    show AccountCubit, AccountState, UserRegisterStatus;
import '../../../../common/widgets/widgets.dart'
    show CardProfile, PersonalDetail, PlaceholderCard;

class ProfilePreviewPage extends StatefulWidget {
  const ProfilePreviewPage({super.key});

  @override
  State<ProfilePreviewPage> createState() => ProfilePreviewPageState();
}

class ProfilePreviewPageState extends State<ProfilePreviewPage> {
  final List<String> _hobbies = [
    'Sushi',
    'Books',
    'Basketball',
    'Travel',
    'Movie'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) => switch (state.status) {
              UserRegisterStatus.initial => CachedNetworkImage(
                  imageUrl: state.user?.avatar ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: size.width * 0.80,
                    height: size.height,
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return PersonalDetail(
                              user: state.user!,
                              hobbies: _hobbies,
                              bloquedButtonAvailable: false,
                            );
                          },
                        );
                      },
                      child: CardProfile(
                        user: state.user!,
                        imageProvider: imageProvider,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const PlaceholderCard(
                    assetImage: 'assets/imgs/loading.gif',
                  ),
                  errorWidget: (context, url, error) => InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return PersonalDetail(
                            user: state.user!,
                            hobbies: _hobbies,
                            bloquedButtonAvailable: false,
                          );
                        },
                      );
                    },
                    child: PlaceholderCard(
                      assetImage: 'assets/imgs/no-image.jpg',
                      user: state.user,
                    ),
                  ),
                ),
              // TODO: Handle this case.
              UserRegisterStatus.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              // TODO: Handle this case.
              UserRegisterStatus.success => CachedNetworkImage(
                  imageUrl: state.user?.avatar ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: size.width * 0.80,
                    height: size.height,
                    alignment: Alignment.center,
                    child: CardProfile(
                      user: state.user!,
                      imageProvider: imageProvider,
                    ),
                  ),
                  placeholder: (context, url) => const PlaceholderCard(
                    assetImage: 'assets/imgs/loading.gif',
                  ),
                  errorWidget: (context, url, error) => const PlaceholderCard(
                    assetImage: 'assets/imgs/no-image.jpg',
                  ),
                ),
              // TODO: Handle this case.
              UserRegisterStatus.failure => CachedNetworkImage(
                  imageUrl: state.user?.avatar ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: size.width * 0.80,
                    height: size.height,
                    alignment: Alignment.center,
                    child: CardProfile(
                      user: state.user!,
                      imageProvider: imageProvider,
                    ),
                  ),
                  placeholder: (context, url) => const PlaceholderCard(
                    assetImage: 'assets/imgs/loading.gif',
                  ),
                  errorWidget: (context, url, error) => const PlaceholderCard(
                    assetImage: 'assets/imgs/no-image.jpg',
                  ),
                ),
            });
  }
}
