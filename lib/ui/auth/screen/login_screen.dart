import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBG,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.marginHorizontal,
            vertical: AppTheme.marginVertical,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.icLogo.image(height: 15),
                const Gap(24),
                Text(
                  "Masuk",
                  style: context.textTheme.displayLarge,
                ),
                const Gap(70),
                const AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: "Your Email",
                  startIcon: Ionicons.mail_outline,
                ),
                const Gap(20),
                const AppTextField(
                  hint: "Your Password",
                  startIcon: Ionicons.lock_closed_outline,
                  obscure: true,
                  endIcon: Ionicons.eye,
                ),
                const Gap(50),
                AppButton(
                  caption: "MASUK",
                  onPressed: () {
                    context.go('/menu');
                  },
                ),
                const Gap(30),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Belum punya akun? ",
                        style: context.textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "Daftar",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/signup'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
