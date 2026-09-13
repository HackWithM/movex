import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';

class HeroSection extends StatelessWidget {
  final ValueChanged<String>? onSearch;

  const HeroSection({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF0F3460),
            Color(0xFF16213E),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withAlpha(25),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.unlockStart.withAlpha(20),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accent.withAlpha(80),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '🏙️  Pune\'s Newest Rental App',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFFB3C1),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Headline
                Text(
                  AppStrings.heroTitle,
                  style: GoogleFonts.outfit(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.15,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle
                Text(
                  AppStrings.heroSubtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withAlpha(178),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Search bar
                _RotatingSearchBar(onSearch: onSearch),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RotatingSearchBar extends StatefulWidget {
  final ValueChanged<String>? onSearch;

  const _RotatingSearchBar({this.onSearch});

  @override
  State<_RotatingSearchBar> createState() => _RotatingSearchBarState();
}

class _RotatingSearchBarState extends State<_RotatingSearchBar> {
  final TextEditingController _controller = TextEditingController();
  static const List<String> _placeholders = [
    'Pune',
    'Wakad',
    'Hinjewadi',
    'Baner',
    'Kharadi',
    'Viman Nagar',
  ];
  int _placeholderIndex = 0;

  @override
  void initState() {
    super.initState();
    _rotatePlaceholder();
  }

  void _rotatePlaceholder() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _placeholderIndex =
              (_placeholderIndex + 1) % _placeholders.length;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _SearchBar(
        key: ValueKey(_placeholderIndex),
        controller: _controller,
        hint: _placeholders[_placeholderIndex],
        onSubmit: widget.onSearch,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onSubmit;

  const _SearchBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmit,
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.outfit(
            fontSize: 14,
            color: AppColors.textHint,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.accent,
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0),
          suffixIcon: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.accent, Color(0xFFFF6B8A)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
