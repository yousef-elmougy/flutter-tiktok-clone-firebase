import '../../lib_exports.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    const screens = [
      VideosScreen(),
      SearchScreen(),
      AddVideoScreen(),
      UsersMessagesScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBackgroundColor,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        fixedColor: kSecondaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: AddVideoIconWidget(),
          ),
          BottomNavigationBarItem(
            label: 'Messages',
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: screens[currentIndex],
      // body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
