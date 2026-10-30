import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const LoginScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'lestari.bumi@econotes.id');
  final _passwordController = TextEditingController(text: 'rahasiahijau2026');
  bool _isPasswordObscured = true;

  void _submitLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          onToggleTheme: widget.onToggleTheme,
          isDark: widget.isDark,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.neonLime,
                  border: Border.all(color: AppColors.pureBlack, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.pureBlack,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, size: 16, color: AppColors.pureBlack),
                    SizedBox(width: 6),
                    Text(
                      'PORTAL CATATAN',
                      style: TextStyle(
                        color: AppColors.pureBlack,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'MASUK KE AKUN',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Lanjutkan pencatatan ide dan tugas harian Anda.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.mutedGrey : AppColors.pureBlack.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.pureWhite,
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black54 : AppColors.pureBlack,
                      offset: const Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ALAMAT EMAIL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBg : AppColors.creamBg,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _emailController,
                        style: TextStyle(
                          color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline, color: AppColors.pureBlack, size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'KATA SANDI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBg : AppColors.creamBg,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.pureBlack,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        style: TextStyle(
                          color: isDark ? AppColors.pureWhite : AppColors.pureBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.pureBlack, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: AppColors.pureBlack,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: _submitLogin,
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.electricBlue,
                          border: Border.all(color: AppColors.pureBlack, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.pureBlack,
                              offset: Offset(3, 3),
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MASUK',
                              style: TextStyle(
                                color: AppColors.pureWhite,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: AppColors.pureWhite, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum terdaftar? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: isDark ? AppColors.mutedGrey : AppColors.pureBlack,
                    ),
                  ),
                  const Text(
                    'DAFTAR SEKARANG',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: AppColors.electricBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
