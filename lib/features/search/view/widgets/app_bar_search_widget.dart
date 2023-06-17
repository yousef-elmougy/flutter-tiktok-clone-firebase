import '../../../../lib_exports.dart';

class AppBarSearchWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarSearchWidget({super.key});

  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String query = '';

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => AppBar(
        title: TextField(
          controller: _controller,
          // autofocus: true,
          onChanged: _onChanged,
          cursorColor: kWhiteColor,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'search',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: kWhiteColor),
              onPressed: _clearText,
            ),
          ),
        ),
      );

  void _clearText() {
    if (context.read<SearchCubit>().users.isEmpty) return;
    _controller.clear();
    query = '';
    context.read<SearchCubit>().clearUsers();
    setState(() {});
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      query = value;

      context.read<SearchCubit>().searchUsers(query);
    });
  }
}
