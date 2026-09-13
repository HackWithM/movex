import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';

class HowMovexWorks extends StatelessWidget {
  const HowMovexWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28),
      color: AppColors.sectionBg,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.howMovexWorks,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.unlockStart, AppColors.primaryMid],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3 steps',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _StepTile(
            stepNumber: 1,
            icon: Icons.search_rounded,
            title: AppStrings.step1Title,
            description: AppStrings.step1Desc,
            isHighlighted: false,
          ),
          const _StepConnector(),
          const _StepTile(
            stepNumber: 2,
            icon: Icons.home_work_outlined,
            title: AppStrings.step2Title,
            description: AppStrings.step2Desc,
            isHighlighted: false,
          ),
          const _StepConnector(),
          const _StepTile(
            stepNumber: 3,
            icon: Icons.lock_open_rounded,
            title: AppStrings.step3Title,
            description: AppStrings.step3Desc,
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 2,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.divider,
                  AppColors.divider.withAlpha(80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int stepNumber;
  final IconData icon;
  final String title;
  final String description;
  final bool isHighlighted;

  const _StepTile({
    super.key,
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withAlpha(6)
            : AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted
              ? AppColors.accent.withAlpha(60)
              : AppColors.divider,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number badge
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: isHighlighted
                  ? const LinearGradient(
                      colors: [AppColors.accent, Color(0xFFFF6B8A)],
                    )
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryMid],
                    ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isHighlighted
                            ? AppColors.accent.withAlpha(20)
                            : AppColors.sectionBg,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$stepNumber',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isHighlighted
                                ? AppColors.accent
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (isHighlighted)
                  _HighlightedDescription(description: description)
                else
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightedDescription extends StatelessWidget {
  final String description;

  const _HighlightedDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    // Split to highlight ₹100
    const rupeeText = '₹100';
    final parts = description.split(rupeeText);

    return RichText(
      text: TextSpan(
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        children: [
          TextSpan(text: parts[0]),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.accent, Color(0xFFFF6B8A)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                rupeeText,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
