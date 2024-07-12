import 'package:camera/camera.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/ui/scan_product/screen/product_result_screen.dart';
import 'package:nutrisee/ui/scan_product/screen/scan_barcode_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanProductScreen extends StatefulWidget {
  const ScanProductScreen({super.key});

  @override
  State<ScanProductScreen> createState() => _ScanProductScreenState();
}

class _ScanProductScreenState extends State<ScanProductScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool isCameraInit = false;
  late final List<CameraDescription> _cameras;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    await onNewCameraSelected(_cameras.first);
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final previousCameraController = _cameraController;

    final CameraController cameraController = CameraController(
      description,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await cameraController.initialize();
      debugPrint('Camera initialized successfully');
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        _cameraController = cameraController;
        isCameraInit = _cameraController!.value.isInitialized;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onCapturedPressed() async {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        try {
          final image = await _cameraController!.takePicture();
          if (!mounted) return;
          context.push('/result-product', extra: image);
        } catch (e) {
          debugPrint('Error capturing image: $e');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pindai Produk Kemasan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          )
        ],
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.textBlack,
      body: SafeArea(
        child: isCameraInit
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: AppColors.textBlack,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () async {
                                onCapturedPressed();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.greenSwatch.shade50,
                                ),
                                child: const Icon(
                                  Ionicons.sparkles,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BarcodeScannerScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 65,
                                height: 50,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.orange.shade100,
                                ),
                                child: const Icon(
                                  Ionicons.barcode,
                                  size: 40,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : onCameraLateInit(context),
      ),
    );
  }
}

Widget onCameraLateInit(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginHorizontal),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/ic_camera_permission.png',
          width: 200,
        ),
        Text(
          "Hai!, coba beri izin Nutrisee untuk pakai kamera yaaa, "
          "Nutrisee hanya pakai untuk melihat produk yang ingin kamu pindai 😁",
          style: context.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 10),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        const CircularProgressIndicator(color: AppColors.primary)
      ],
    ),
  );
}
