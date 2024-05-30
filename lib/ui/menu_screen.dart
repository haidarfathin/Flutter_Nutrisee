import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/ui/article/screen/article_screen.dart';
import 'package:nutrisee/ui/history/screen/history_screen.dart';
import 'package:nutrisee/ui/home/screen/home_screen.dart';
import 'package:nutrisee/ui/profile/screen/profile_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var currentScreen = 0;

  List<Widget> get screens {
    return const <Widget>[
      HomeScreen(),
      HistoryScreen(),
      ArticleScreen(),
      ProfileScreen(),
    ];
  }

  List<GButton> get navbarItem {
    return <GButton>[
      const GButton(
        icon: Icons.home,
        text: "Home",
      ),
      const GButton(
        icon: Ionicons.reader,
        text: "Riwayat",
      ),
      const GButton(
        icon: Ionicons.newspaper,
        text: "Artikel",
      ),
      const GButton(
        icon: Ionicons.person,
        leading: const CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage(
            'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
          ),
        ),
        text: 'Profile',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentScreen,
        children: screens,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primary,
      //   onPressed: () {
      //     setState(() {
      //       currentScreen = 1;
      //     });
      //   },
      //   child: Icon(
      //     Icons.document_scanner_outlined,
      //     size: 30,
      //     color: AppColors.ancientSwatch.shade50,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: GNav(
            gap: 10,
            color: AppColors.ancientSwatch.shade300,
            padding: const EdgeInsets.all(12),
            activeColor: AppColors.primary,
            tabBackgroundColor: AppColors.secondary.withOpacity(0.2),
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: AppColors.primary,
            ),
            onTabChange: (index) {
              setState(() {
                currentScreen = index;
              });
            },
            tabs: navbarItem,
          ),
        ),
      ),
    );
  }
}

/*
 Container(
        color: Colors.transparent,
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.ancient,
            unselectedItemColor: AppColors.ancientSwatch.shade300,
            showUnselectedLabels: false,
            backgroundColor: AppColors.ancientSwatch.shade50,
            items: bottomNavBarItem,
            currentIndex: currentScreen,
            onTap: (index) => setState(
              () => currentScreen = index,
            ),
          ),
        ),
      ),
 */