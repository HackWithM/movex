import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';

const List<_FeatureData> _features = [
  _FeatureData(
    icon: Icons.lock_rounded,
    label: 'Privacy Protected',
    desc: AppStrings.privacyDesc,
    gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
  ),
  _FeatureData(
    icon: Icons.photo_library_rounded,
    label: 'Property Photos',
    desc: AppStrings.photosDesc,
    gradientColors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
  ),
  _FeatureData(
    icon: Icons.verified_rounded,
    label: 'Verified Listings',
    desc: AppStrings.verifiedDesc,
    gradientColors: [Color(0xFF00C9A7), Color(0xFF0F3460)],
  ),
  _FeatureData(
    icon: Icons.currency_rupee_rounded,
    label: 'Affordable Access',
    desc: AppStrings.affordableDesc,
    gradientColors: [Color(0xFFE94560), Color(0xFF1A1A2E)],
  ),
];

class WhyMovex extends StatelessWidget {
  const WhyMovex({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.whyChooseMovex,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.88,
            ),
            itemCount: _features.length,
            itemBuilder: (context, index) => _FeatureCard(
              data: _features[index],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String label;
  final String desc;
  final List<Color> gradientColors;

  const _FeatureData({
    required this.icon,
    required this.label,
    required this.desc,
    required this.gradientColors,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData data;

  const _FeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(10),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: data.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            data.label,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              data.desc,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
