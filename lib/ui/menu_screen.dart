import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuScreen extends StatefulWidget {
  final int screen; // Parameter untuk menentukan layar yang akan ditampilkan

  const MenuScreen({Key? key, this.screen = 0}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late int currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen =
        widget.screen; // Inisialisasi layar saat ini dengan parameter
  }

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
          backgroundImage: const AssetImage("assets/images/ic_male_circle.png"),
        ),
        text: 'Profile',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getImageFromCamera() async {
      bool isCameraGranted = await Permission.camera.request().isGranted;
      if (!isCameraGranted) {
        isCameraGranted =
            await Permission.camera.request() == PermissionStatus.granted;
      }

      if (!isCameraGranted) {
        return;
      }

      String imagePath = join((await getApplicationSupportDirectory()).path,
          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

      bool success = false;

      try {
        success = await EdgeDetection.detectEdge(
          imagePath,
          canUseGallery: true,
          androidScanTitle: 'Scan Nutrition Table',
          androidCropTitle: 'Crop',
          androidCropBlackWhiteTitle: 'Black White',
          androidCropReset: 'Reset',
        );
        print("success: $success");
      } catch (e) {
        print(e);
      }

      if (!mounted) return;
      if (success) {
        context.push("/result-product", extra: XFile(imagePath));
      }
    }

    return Scaffold(
      body: IndexedStack(
        index: currentScreen,
        children: screens,
      ),
      floatingActionButton: currentScreen == 0
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () async {
                context.push("/scan-product");
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
