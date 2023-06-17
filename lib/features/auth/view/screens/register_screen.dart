import '../../../../lib_exports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, this.onClick});

  final VoidCallback? onClick;
  
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            const Text(
              "TikTok Clone",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 35,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 15),
            const RegisterFromWidget(),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Don\'t have an account?       ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Login',
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
        ),
      );
}
