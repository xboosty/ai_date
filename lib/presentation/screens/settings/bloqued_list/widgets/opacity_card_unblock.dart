import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart'
    show
        AppTheme,
        BlockCubit,
        DioException,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        UserEntity,
        getIt;
import '../../../../common/widgets/widgets.dart'
    show CustomAlertDialog, FilledColorizedButton;

class OpacityCardUnblock extends StatefulWidget {
  const OpacityCardUnblock({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  State<OpacityCardUnblock> createState() => OpacityCardUnblockState();
}

class OpacityCardUnblockState extends State<OpacityCardUnblock> {
  final _notifications = getIt<HandlerNotification>();

  void _handleUnblockCard(BuildContext context, {required Size size}) async {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      await context.read<BlockCubit>().unBlockedUser(id: widget.user.id ?? -1);
      if (!mounted) return;
      await _notifications.ntsSuccessNotification(
        context,
        message: 'User successfully unlocked',
        height: size.height * 0.12,
        width: size.width * 0.90,
      );
    } catch (e) {
      if (!mounted) return;
      if (e is NtsErrorResponse) {
        await _notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }

      if (e is DioException) {
        if (!mounted) return;
        await _notifications.ntsErrorNotification(
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

    return Container(
      height: size.height * 0.35,
      padding: const EdgeInsets.only(top: 30, bottom: 50, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        gradient: AppTheme.shadowGradient(
            begin: Alignment.bottomCenter, end: Alignment.topCenter),
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
                  onPressedOk: () => _handleUnblockCard(context, size: size),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
