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
import 'package:nutrisee/ui/auth/screen/paginated_signup_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  "DAFTAR",
                  style: context.textTheme.displayLarge,
                ),
                const Gap(70),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: const AppTextField(
                        hint: "Nama depan",
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: const AppTextField(
                        hint: "Nama Belakang",
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                const AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: "Your Email",
                  startIcon: Ionicons.mail_outline,
                ),
                const Gap(20),
                const AppTextField(
                  hint: "Password",
                  startIcon: Ionicons.lock_closed_outline,
                  obscure: true,
                  endIcon: Ionicons.eye,
                ),
                Gap(20),
                const AppTextField(
                  hint: "Konfirmasi Password",
                  startIcon: Ionicons.lock_closed_outline,
                  obscure: true,
                  endIcon: Ionicons.eye,
                ),
                const Gap(50),
                AppButton(
                  caption: "DAFTAR",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaginatedSignupScreen(),
                        ));
                  },
                ),
                const Gap(30),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Sudah punya akun? ",
                        style: context.textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "Masuk",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/login'),
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
