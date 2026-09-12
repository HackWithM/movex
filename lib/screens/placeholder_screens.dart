import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';

class PropertySearchScreen extends StatelessWidget {
  const PropertySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Property Search',
      icon: Icons.search_rounded,
      gradientColors: [AppColors.primary, AppColors.primaryMid],
      message: 'Advanced property search with filters\ncoming soon.',
    );
  }
}

class PostPropertyScreen extends StatelessWidget {
  const PostPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Post Property',
      icon: Icons.add_home_rounded,
      gradientColors: [AppColors.accent, const Color(0xFFFF6B8A)],
      message: 'Property listing flow\ncoming soon.',
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_rounded,
      gradientColors: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      message: 'User profile and account settings\ncoming soon.',
    );
  }
}

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Property Details',
      icon: Icons.apartment_rounded,
      gradientColors: [const Color(0xFF00C9A7), AppColors.primaryMid],
      message: 'Full property details with\n₹100 unlock flow coming soon.',
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final String message;

  const _PlaceholderScreen({
    required this.title,
    required this.icon,
    required this.gradientColors,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withAlpha(60),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.sectionBg,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.divider),
              ),
              child: Text(
                '🚧  Coming Soon',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
