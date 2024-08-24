import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_button.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';
import 'package:nutrisee/core/widgets/app_snackbar.dart';
import 'package:nutrisee/core/widgets/app_textfield.dart';
import 'package:nutrisee/core/widgets/app_theme.dart';
import 'package:nutrisee/gen/assets.gen.dart';
import 'package:nutrisee/ui/auth/bloc/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: kDebugMode ? 'jaka@mail.com' : "");
    final TextEditingController passwordController =
        TextEditingController(text: kDebugMode ? 'jaka123' : "");

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
                Assets.images.icLogo.image(height: 30),
                const Gap(24),
                Text(
                  "Masuk",
                  style: context.textTheme.displayLarge,
                ),
                const Gap(70),
                AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  hint: "Your Email",
                  startIcon: Ionicons.mail_outline,
                  controller: emailController,
                ),
                const Gap(20),
                AppTextField(
                  hint: "Your Password",
                  startIcon: Ionicons.lock_closed_outline,
                  obscure: true,
                  endIcon: Ionicons.eye,
                  controller: passwordController,
                ),
                const Gap(50),
                BlocProvider(
                  create: (context) => AuthCubit(),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        context.go('/menu');
                      } else if (state is AuthError) {
                        context.showSnackbar(state.message ?? "");
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        caption: "MASUK",
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (emailController.text.isEmpty) {
                            context.showSnackbar("Please Fill Your Email");
                          } else if (passwordController.text.isEmpty) {
                            context.showSnackbar("Please Fill Your Password");
                          } else {
                            context.read<AuthCubit>().login(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }
                        },
                      );
                    },
                  ),
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
