import '../../../../lib_exports.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  String? email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            TextFormFieldWidget(
              prefixIcon: const Icon(Icons.email),
              labelText: "Email",
              onSaved: (email) => setState(() => this.email = email),
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              prefixIcon: const Icon(Icons.lock),
              obscureText: !isVisible,
              suffixIcon: IconButton(
                onPressed: () => setState(() => isVisible = !isVisible),
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              ),
              labelText: "Password",
              onSaved: (password) => setState(() => this.password = password),
            ),
            const SizedBox(height: 30),
            ButtonWidget(
              onPressed: _login,
              title: "Login",
            ),
          ],
        ),
      );

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AuthCubit>().login(
            email: email!,
            password: password!,
          );
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
