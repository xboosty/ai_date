import 'package:ai_date/config/config.dart';
import 'package:ai_date/presentation/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CodeVerificationStep extends StatefulWidget {
  const CodeVerificationStep({
    super.key,
    required this.pageviewController,
    required this.focusNodeVerification,
    required this.verificationCtrl,
    required this.onPressed,
  });

  final PageController pageviewController;
  final FocusNode focusNodeVerification;
  final TextEditingController verificationCtrl;
  final VoidCallback onPressed;

  @override
  State<CodeVerificationStep> createState() => _CodeVerificationStepState();
}

class _CodeVerificationStepState extends State<CodeVerificationStep> {
  final _navigations = getIt<NavigationsApp>();

  String? _validateVerificationCode(String value) {
    if (value.isEmpty) {
      return 'Verification code is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/imgs/vector_code.png',
                      ),
                    ),
                    Center(child: Image.asset('assets/imgs/code_img.png')),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        // padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.backPage(context,
                                  pageviewController:
                                      widget.pageviewController),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: AppTheme.disabledColor,
                                // size: 32,
                              ),
                              onPressed: () => _navigations.exitSetup(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 40),
                child: const Text(
                  'Enter your code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF261638),
                    fontSize: 28,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CodeVerificationInput(
                      focusNode: widget.focusNodeVerification,
                      controller: widget.verificationCtrl,
                      validator: (value) =>
                          _validateVerificationCode(value ?? ''),
                      onEditingComplete: () =>
                          widget.focusNodeVerification.unfocus(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextButton(
                        onPressed: widget.onPressed,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Resend code',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
