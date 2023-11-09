import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../config/config.dart'
    show
        BlockCubit,
        DioException,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        getIt;
import '../../../../../domain/domain.dart' show UserEntity;
import '../../../../common/widgets/widgets.dart' show CustomAlertDialog;
import 'card_unblock_profile.dart';

class UnbloquedProfileSheet extends StatefulWidget {
  const UnbloquedProfileSheet({super.key, required this.user});

  final UserEntity user;

  @override
  State<UnbloquedProfileSheet> createState() => UnbloquedProfileSheetState();
}

class UnbloquedProfileSheetState extends State<UnbloquedProfileSheet> {
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
                        'Blocked user',
                        style: TextStyle(
                          color: Color(0xFF261638),
                          fontSize: 20,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CardUnblockProfile(user: widget.user),
                    ],
                  ),
                );
              },
              controller: DraggableScrollableController(),
            );
          },
        );
      },
      leading: CachedNetworkImage(
        imageUrl: widget.user.avatar,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
        ),
        placeholder: (context, _) => const CircleAvatar(
          backgroundImage: AssetImage('assets/imgs/no-image.jpg'),
        ),
        errorWidget: (context, url, error) => const CircleAvatar(
          backgroundImage: AssetImage('assets/imgs/no-image.jpg'),
        ),
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
