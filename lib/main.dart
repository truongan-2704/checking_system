import 'package:checking_system/screen/home/home_screen.dart';
import 'package:checking_system/screen/authentication/login_screen.dart';
import 'package:checking_system/screen/monitor/monitor_screen.dart';
import 'package:checking_system/screen/notify/notify_screen.dart';
import 'package:checking_system/screen/profile/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// 🔥 IMPORT HIVE FLUTTER (bắt buộc cho Web + Mobile)
import 'package:hive_flutter/hive_flutter.dart';
import 'package:checking_system/utils/local_storage.dart';

import 'common/widget/button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 1. KHỞI TẠO HIVE (CHẠY ĐƯỢC TRÊN WEB)
  await Hive.initFlutter();

  // 🔥 2. MỞ BOX (tránh lỗi Box not found)
  await Hive.openBox('AppLocalStorage');

  // 🔥 3. Kiểm tra trạng thái đăng nhập
  bool isLogin = LocalStorage.getBool(LocalStorageKey.isLogin);

  runApp(MyApp(isLoggedIn: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // 🔥 Auto login
      home: isLoggedIn ? const MyHomePage() : const Login_Screen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MonitorScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: "Camera on You",
        isShowBack: false,
        titleColor: Colors.blue,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.blue,
              iconSize: 24,
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[300]!,
              color: Colors.black,
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.monitor, text: 'Monitor'),
                GButton(icon: Icons.notifications, text: 'Notify'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
