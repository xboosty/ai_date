part of 'register_screen.dart';

class PasswordRegister extends StatefulWidget {
  const PasswordRegister({
    super.key,
    required this.passwordCtrl,
    required this.focusNodePassword,
    this.validator,
    this.onEditingComplete,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController passwordCtrl;
  final FocusNode focusNodePassword;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;

  @override
  State<PasswordRegister> createState() => _PasswordRegisterState();
}

class _PasswordRegisterState extends State<PasswordRegister> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.passwordCtrl,
            focusNode: widget.focusNodePassword,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF686E8C),
                  width: 2.0,
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF686E8C),
                  width: 2.0,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 24,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            validator: widget.validator,
            onEditingComplete: widget.onEditingComplete,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Your password should be at least 8 characters long and include a combination of uppercase letters, lowercase letters, numbers, and special characters for added security',
              style: TextStyle(
                color: Color(0xFF9CA4BF),
                fontSize: 12,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
