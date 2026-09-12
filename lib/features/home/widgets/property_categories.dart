import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';

class _CategoryData {
  final String emoji;
  final String label;
  const _CategoryData(this.emoji, this.label);
}

const List<_CategoryData> _categories = [
  _CategoryData('🏠', 'Flats'),
  _CategoryData('🛏', 'Rooms'),
  _CategoryData('🏢', 'PG'),
  _CategoryData('🏡', '1 RK'),
  _CategoryData('👥', 'Shared'),
];

class PropertyCategories extends StatefulWidget {
  final ValueChanged<String>? onCategoryTap;

  const PropertyCategories({super.key, this.onCategoryTap});

  @override
  State<PropertyCategories> createState() => _PropertyCategoriesState();
}

class _PropertyCategoriesState extends State<PropertyCategories> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  AppStrings.exploreProperties,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Text(
                  'See all',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 88,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    widget.onCategoryTap?.call(cat.label);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 74,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.divider,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(60),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(8),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cat.emoji,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cat.label,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
