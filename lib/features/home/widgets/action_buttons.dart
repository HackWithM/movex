import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onPostTap;

  const ActionButtons({
    super.key,
    this.onSearchTap,
    this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: _ActionCard(
              icon: Icons.search_rounded,
              title: AppStrings.searchProperty,
              subtitle: AppStrings.searchPropertySub,
              isPrimary: true,
              onTap: onSearchTap,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _ActionCard(
              icon: Icons.add_home_rounded,
              title: AppStrings.postProperty,
              subtitle: AppStrings.postPropertySub,
              isPrimary: false,
              onTap: onPostTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isPrimary,
    this.onTap,
  });

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: widget.isPrimary
            ? _PrimaryCard(icon: widget.icon, title: widget.title, subtitle: widget.subtitle)
            : _SecondaryCard(icon: widget.icon, title: widget.title, subtitle: widget.subtitle),
      ),
    );
  }
}

class _PrimaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PrimaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accent, Color(0xFFFF6B8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SecondaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(12),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.sectionBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
