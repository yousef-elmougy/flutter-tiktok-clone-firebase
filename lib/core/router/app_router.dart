import 'package:tiktok_clone/features/messages/view/screens/messages_screen.dart';
import 'package:tiktok_clone/features/video/view/screens/comments_screen.dart';

import '../../lib_exports.dart';

class AppRouter {
  static const confirmAddingVideoScreen = 'confirm-adding-video';
  static const videoCommentsScreen = 'video-comments';
  static const messagesScreen = 'messages';
  static const profileScreen = 'profile';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainScreen(),
        );

      case confirmAddingVideoScreen:
        final video = settings.arguments as XFile;

        return CustomPageRoute(
          ConfirmAddingVideoScreen(video: video),
          Transitions.leftToRight,
          setting: settings,
        );

      case messagesScreen:
        final user = settings.arguments as UserData;
        return CustomPageRoute(
          MessagesScreen(user: user),
          Transitions.leftToRight,
          setting: settings,
        );

      case profileScreen:
        final uid = settings.arguments as String;
        return CustomPageRoute(
          ProfileScreen(uid: uid),
          Transitions.leftToRight,
          setting: settings,
        );

      case videoCommentsScreen:
        final videoId = settings.arguments as String;
        return CustomPageRoute(
          CommentsScreen(videoId: videoId),
          Transitions.leftToRight,
          setting: settings,
        );

      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('ERROR : Route Not Found')),
          body: const Center(
            child: Text(
              'ERROR : Route Not Found',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const LayoutScreen();
          } else {
            return const AuthScreen();
          }
        },
      );
}
