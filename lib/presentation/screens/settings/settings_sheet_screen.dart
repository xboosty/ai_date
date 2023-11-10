import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        DioException,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        UserRegisterStatus,
        VersionApp,
        getIt;
import '../../common/widgets/widgets.dart' show CustomAlertDialog;
import '../screens.dart' show SignInScreen;
import 'widgets/widget_settings.dart';

class SettingsSheetScreen extends StatefulWidget {
  const SettingsSheetScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<SettingsSheetScreen> createState() => _SettingsSheetScreenState();
}

class _SettingsSheetScreenState extends State<SettingsSheetScreen> {
  Future<void> _logOut(BuildContext context, {required Size size}) async {
    final notifications = getIt<HandlerNotification>();
    try {
      await context.read<AccountCubit>().logOutUser();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName,
        (route) => false,
      );
    } catch (e) {
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
          height: size.height * 0.14,
          width: size.width * 0.90,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              color: Color(0xFF261638),
              fontSize: 20,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          const AccountSettings(),
          const PrivacyAndSecuritySetting(),
          const LocationSetting(),
          const NotificationsSetting(),
          const LegalSetting(),
          const HelpSupportSetting(),
          SizedBox(height: size.height * 0.04),
          Center(
            child: Image.asset(
              'assets/imgs/aidate-logo.png',
              height: 80,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.90,
            child: FilledButton.icon(
              onPressed: () {
                // Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) => switch (state.status) {
                      UserRegisterStatus.initial => CustomAlertDialog(
                          title: 'Exit AI Date',
                          content: 'Are you sure you want to exit the app?',
                          onPressedCancel: () => Navigator.of(context).pop(),
                          onPressedOk: () => _logOut(context, size: size),
                        ),
                      UserRegisterStatus.loading => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      UserRegisterStatus.failure => CustomAlertDialog(
                          title: 'Exit AI Date',
                          content: 'Are you sure you want to exit the app?',
                          onPressedCancel: () => Navigator.of(context).pop(),
                          onPressedOk: () => _logOut(context, size: size),
                        ),
                      UserRegisterStatus.success => CustomAlertDialog(
                          title: 'Exit AI Date',
                          content: 'Are you sure you want to exit the app?',
                          onPressedCancel: () => Navigator.of(context).pop(),
                          onPressedOk: () => _logOut(context, size: size),
                        ),
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.login,
                color: Color(0xFF6C2EBC),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6C2EBC),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              label: const Text(
                'LOG OUT',
                style: TextStyle(
                  color: Color(0xFF6C2EBC),
                  fontSize: 16,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width * 0.90,
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Color(0xFF6C2EBC),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6C2EBC),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              label: const Text(
                'DELETE ACCOUNT',
                style: TextStyle(
                  color: Color(0xFF6C2EBC),
                  fontSize: 16,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
