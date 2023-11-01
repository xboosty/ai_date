import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../config/config.dart'
    show
        AppTheme,
        BlockCubit,
        BlockState,
        BlockedUsersData,
        BlockedUsersError,
        BlockedUsersInitial,
        BlockedUsersLoading,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        getIt;
import '../../../domain/domain.dart' show UserEntity;
import '../../widgets/widgets.dart'
    show CustomAlertDialog, FilledColorizedButton, GradientText;

class BloquedListScreen extends StatefulWidget {
  const BloquedListScreen({super.key});

  static const String routeName = '/bloqued_list_screen';

  @override
  State<BloquedListScreen> createState() => _BloquedListScreenState();
}

class _BloquedListScreenState extends State<BloquedListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlockCubit>().getUsersBloqued();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Blocked',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<BlockCubit, BlockState>(
        builder: (context, state) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
                bottom: false,
                child: switch (state) {
                  // TODO: Handle this case.
                  BlockedUsersInitial() => Container(),
                  // TODO: Handle this case.
                  BlockedUsersLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  // ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return Skeleton.unite(
                  //         child: const Column(
                  //           children: [
                  //             _UnbloquedProfile(),
                  //             Divider(),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // TODO: Handle this case.
                  BlockedUsersData() => state.users.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                _UnbloquedProfile(
                                  user: state.users[index],
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: Text('There are no blocked users'),
                        ),
                  // TODO: Handle this case.
                  BlockedUsersError() => Container(),
                }),
          );
        },
      ),
    );
  }
}

class _UnbloquedProfile extends StatefulWidget {
  const _UnbloquedProfile({required this.user});

  final UserEntity user;

  @override
  State<_UnbloquedProfile> createState() => _UnbloquedProfileState();
}

class _UnbloquedProfileState extends State<_UnbloquedProfile> {
  final notifications = getIt<HandlerNotification>();

  void _handleUnblock(BuildContext context, {required Size size}) async {
    try {
      Navigator.of(context).pop();
      await context.read<BlockCubit>().unBlockedUser(id: widget.user.id ?? -1);
      if (!mounted) return;
      await notifications.ntsSuccessNotification(
        context,
        message: 'User successfully unlocked',
        height: size.height * 0.12,
        width: size.width * 0.90,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      if (e is NtsErrorResponse) {
        notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }

      if (e is DioException) {
        notifications.ntsErrorNotification(
          context,
          message: 'Sorry. Something went wrong. Please try again later',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          enableDrag: true,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 1.0,
              minChildSize: 1.0,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const Text(
                        'Unbloqued user',
                        style: TextStyle(
                          color: Color(0xFF261638),
                          fontSize: 20,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: size.height * 0.90,
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/imgs/girl5.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _TitleUnblockUser(
                                size: size, name: widget.user.name),
                            const Spacer(),
                            _OpacityCardUnblock(
                              size: size,
                              user: widget.user,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              controller: DraggableScrollableController(),
            );
          },
        );
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/imgs/girl3.png'),
      ),
      title: Text(
        widget.user.name,
        style: const TextStyle(
          color: Color(0xFF686E8C),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: FilledButton(
        style: FilledButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialog(
              title: 'Unlock user',
              content: 'Are you sure to unblock this user?',
              onPressedCancel: () => Navigator.of(context).pop(),
              onPressedOk: () => _handleUnblock(context, size: size),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Unblock',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.0),
            Icon(Icons.published_with_changes_outlined)
          ],
        ),
      ),
    );
  }
}

class _TitleUnblockUser extends StatelessWidget {
  const _TitleUnblockUser({
    required this.size,
    required this.name,
  });

  final Size size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.10,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          'Lives in New York',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.6000000238418579),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          child: const GradientText(
            text: '95% match',
            gradient: AppTheme.linearGradient,
            style: TextStyle(
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _OpacityCardUnblock extends StatefulWidget {
  _OpacityCardUnblock({
    required this.size,
    required this.user,
  });

  final Size size;
  final UserEntity user;

  @override
  State<_OpacityCardUnblock> createState() => _OpacityCardUnblockState();
}

class _OpacityCardUnblockState extends State<_OpacityCardUnblock> {
  final _notifications = getIt<HandlerNotification>();

  void _handleUnblockCard(BuildContext context) async {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      await context.read<BlockCubit>().unBlockedUser(id: widget.user.id ?? -1);
      if (!mounted) return;
      await _notifications.ntsSuccessNotification(
        context,
        message: 'User successfully unlocked',
        height: widget.size.height * 0.12,
        width: widget.size.width * 0.90,
      );
    } catch (e) {
      if (!mounted) return;
      if (e is NtsErrorResponse) {
        await _notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: widget.size.height * 0.12,
          width: widget.size.width * 0.90,
        );
      }

      if (e is DioException) {
        if (!mounted) return;
        await _notifications.ntsErrorNotification(
          context,
          message: 'Sorry. Something went wrong. Please try again later',
          height: widget.size.height * 0.12,
          width: widget.size.width * 0.90,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.35,
      padding: const EdgeInsets.only(top: 30, bottom: 50, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white.withOpacity(0.10000000149011612),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'You\'ve blocked this user',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            'If you want to see this user\'s details, unblock them first',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          FilledColorizedButton(
            width: 150,
            height: 50,
            title: 'Unblock',
            isTrailingIcon: true,
            icon: const Icon(
              Icons.published_with_changes_outlined,
              color: Colors.white,
            ),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialog(
                  title: 'Unlock user',
                  content: 'Are you sure to unblock this user?',
                  onPressedCancel: () => Navigator.of(context).pop(),
                  onPressedOk: () => _handleUnblockCard(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
