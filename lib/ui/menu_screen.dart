import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/gen/assets.gen.dart';
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
      GButton(
        icon: Ionicons.person,
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.green.shade100,
          backgroundImage: AssetImage("assets/images/ic_male_circle.png"),
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
      floatingActionButton: currentScreen == 0
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                context.push("/scan-product");
                // getImageFromCamera();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff049913),
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(12.0),
                child: Assets.images.icOcr.image(),
              ),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff90C788),
                Color(0xff049913),
              ],
              stops: [0.3, 1.0],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: GNav(
            gap: 10,
            color: AppColors.whiteBG,
            padding: const EdgeInsets.all(12),
            activeColor: AppColors.whiteBG,
            tabBackgroundColor: AppColors.primary.withOpacity(0.6),
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white,
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
