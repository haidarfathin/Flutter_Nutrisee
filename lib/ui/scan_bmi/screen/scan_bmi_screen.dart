import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/scan_bmi/screen/count_bmi_screen.dart';
import 'package:nutrisee/ui/scan_product/screen/product_result_screen.dart';

class ScanBmiScreen extends StatefulWidget {
  const ScanBmiScreen({super.key});

  @override
  State<ScanBmiScreen> createState() => _ScanBmiScreenState();
}

class _ScanBmiScreenState extends State<ScanBmiScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool isCameraInit = false;
  late final List<CameraDescription> _cameras;

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
    await onNewCameraSelected(_cameras[1]);
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
          double height = 175;
          double weight = 76;
          context.push(
            '/result-bmi',
            extra: BMI(
              useImage: true,
              isMale: false,
              height: height,
              weight: weight,
              imagePath: image.path,
            ),
          );
        } catch (e) {
          debugPrint('Error capturing image: $e');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pindai Wajah BMI"),
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.textBlack,
      body: SafeArea(
        child: isCameraInit
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.all(20),
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.only(bottom: 40),
                      alignment: Alignment.center,
                      color: AppColors.textBlack,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              onCapturedPressed();
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                                color: AppColors.primary,
                              ),
                              child: Assets.images.icScanBmi.image(width: 30),
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 70,
                            color: Colors.green.shade300,
                          ),
                          InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              context.push('/count-bmi');
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: AppColors.primary,
                              ),
                              child: const Icon(
                                Icons.calculate,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
          "Nutrisee tidak menyimpan foto anda, hanya digunakan untuk memprediksi BMI anda 😁",
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
