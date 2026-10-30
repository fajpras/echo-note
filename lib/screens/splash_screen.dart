import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          onToggleTheme: widget.onToggleTheme,
          isDark: widget.isDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.creamBg,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _goToLogin,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                    ),
                    onPressed: widget.onToggleTheme,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: AppColors.neonLime,
                        border: Border.all(color: AppColors.pureBlack, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.pureBlack,
                            offset: Offset(4, 4),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_note_rounded,
                        size: 46,
                        color: AppColors.pureBlack,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ECONOTES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                        color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.electricBlue,
                        border: Border.all(color: AppColors.pureBlack, width: 2),
                      ),
                      child: const Text(
                        'CATAT CEPAT • RAPI • PRAKTIS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppColors.pureWhite,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ketuk di mana saja untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _goToLogin,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.neonLime,
                      border: Border.all(color: AppColors.pureBlack, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.pureBlack,
                          offset: Offset(4, 4),
                        )
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LANJUT KE LOGIN',
                          style: TextStyle(
                            color: AppColors.pureBlack,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18, color: AppColors.pureBlack),
                      ],
                    ),
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
