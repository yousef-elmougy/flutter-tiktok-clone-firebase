import 'package:tiktok_clone/features/auth/view/widgets/login_form_widget.dart';

import '../../../../lib_exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.onClick});

  final VoidCallback? onClick;
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "TikTok Clone",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 30),
          const LoginFormWidget(),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Don\'t have an account?       ',
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: 'Register',
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onClick,
                ),
              ],
            ),
          ),
        ],
      );
}
