
import '../../../../lib_exports.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => SearchCubit(),
        child: const Scaffold(
          appBar: AppBarSearchWidget(),
          body: SearchBodyWidget(),
        ),
      );
}
