import 'package:tiktok_clone/app_bloc_observer.dart';

import 'features/messages/manager/messages_cubit.dart';
import 'features/profile/manager/profile_cubit.dart';
import 'lib_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => VideoCubit()..getVideos()),
          BlocProvider(
            create: (_) => MessagesCubit()..getAllUsers(),
          ),
          BlocProvider(
            create: (_) => ProfileCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kSecondaryColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            // colorScheme: ColorScheme.fromSeed(
            //   brightness: Brightness.dark,
            //   background: kBackgroundColor,
            //   seedColor: kSecondaryColor,
            // ),
            // useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      );
}
