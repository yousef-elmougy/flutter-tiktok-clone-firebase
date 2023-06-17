
import '../../../../lib_exports.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = false;

  void toggleScreen() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AuthCubit(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: BlocListener<AuthCubit, AuthState>(
                listener: _listenToAuth,
                child: isLogin
                    ? LoginScreen(onClick: toggleScreen)
                    : RegisterScreen(onClick: toggleScreen),
              ),
            ),
          ),
        ),
      );

  Future<void> _listenToAuth(context, state) async {
    if (state is LoginLoading || state is RegisterLoading) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoaderWidget(),
      );
    }
    if (state is LoginError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is RegisterError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is LoginSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Login Successfully', color: Colors.green);
    }
    if (state is RegisterSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Registered Successfully', color: Colors.green);
    }
  }
}
