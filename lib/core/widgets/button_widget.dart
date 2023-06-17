



import '../../lib_exports.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.color = kSecondaryColor,
  });

  final void Function()? onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: color,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      );
}
