import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart'
    show
        BlockCubit,
        BlockedUsersData,
        BlockedUsersError,
        BlockedUsersInitial,
        BlockedUsersLoading,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        getIt;
import '../../../../../domain/domain.dart' show UserEntity;

class BlockUserSheet extends StatefulWidget {
  const BlockUserSheet({super.key, required this.user});

  final UserEntity? user;

  @override
  State<BlockUserSheet> createState() => BlockUserSheetState();
}

class BlockUserSheetState extends State<BlockUserSheet> {
  final notifications = getIt<HandlerNotification>();

  void _handleBlockUser(BuildContext context, {required Size size}) async {
    try {
      await context.read<BlockCubit>().blockedUser(id: widget.user?.id ?? -1);
      if (!mounted) return;
      await notifications.ntsSuccessNotification(
        context,
        message: 'User successfully blocked',
        height: size.height * 0.12,
        width: size.width * 0.90,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
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
    final block = context.watch<BlockCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        children: [
          Text(
            'ARE YOU SURE YOU WANT TO BLOCK THIS ${widget.user?.name.toUpperCase()}?',
            style: const TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Your Blocked list will be on your profile settings',
            style: TextStyle(
              color: Color(0xFF9CA4BF),
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height * 0.15),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: size.width * 0.40,
                  child: switch (block.state) {
                    BlockedUsersLoading() => FilledButton(
                        onPressed: null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersInitial() => FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersData() => FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersError() => FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  }),
              SizedBox(
                  width: size.width * 0.40,
                  child: switch (block.state) {
                    BlockedUsersData() => FilledButton(
                        onPressed: () => _handleBlockUser(
                          context,
                          size: size,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersInitial() => FilledButton(
                        onPressed: () => _handleBlockUser(
                          context,
                          size: size,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersLoading() => FilledButton(
                        onPressed: () => _handleBlockUser(
                          context,
                          size: size,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    // TODO: Handle this case.
                    BlockedUsersError() => FilledButton(
                        onPressed: () => _handleBlockUser(
                          context,
                          size: size,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  })
            ],
          )
        ],
      ),
    );
  }
}
