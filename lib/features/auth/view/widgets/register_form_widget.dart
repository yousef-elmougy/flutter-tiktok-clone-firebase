import '../../../../lib_exports.dart';

class RegisterFromWidget extends StatefulWidget {
  const RegisterFromWidget({super.key});

  @override
  State<RegisterFromWidget> createState() => _RegisterFromWidgetState();
}

class _RegisterFromWidgetState extends State<RegisterFromWidget> {
  String? name, email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final file = context.read<AuthCubit>().file;
                return InkWell(
                  onTap: _pickImage,
                  child: ClipOval(
                    child: file == null
                        ? const Icon(
                            Icons.photo_camera,
                            size: 120,
                            color: kWhiteColor,
                          )
                        : ColoredBox(
                            color: kSecondaryColor,
                            child: Image.file(
                              file,
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            TextFormFieldWidget(
              prefixIcon: const Icon(Icons.person),
              labelText: "Name",
              onSaved: (name) => setState(() => this.name = name),
            ),
            const SizedBox(height: 16),
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
              onPressed: _register,
              title: "Register",
            ),
          ],
        ),
      );

  void _pickImage() => showCameraGalleryDialog(
        context,
        pickedByCamera: () async =>
            await context.read<AuthCubit>().pickedImage(ImageSource.camera),
        pickedByGallery: () async =>
            await context.read<AuthCubit>().pickedImage(ImageSource.gallery),
      );

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context
          .read<AuthCubit>()
          .register(name: name!, email: email!, password: password!);
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }
}
