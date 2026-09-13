import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';
import 'package:movex/features/home/models/property_model.dart';
import 'package:movex/features/home/widgets/home_header.dart';
import 'package:movex/features/home/widgets/hero_section.dart';
import 'package:movex/features/home/widgets/action_buttons.dart';
import 'package:movex/features/home/widgets/property_categories.dart';
import 'package:movex/features/home/widgets/how_movex_works.dart';
import 'package:movex/features/home/widgets/featured_properties.dart';
import 'package:movex/features/home/widgets/why_movex.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  void _navigateTo(String route) {
    Navigator.of(context).pushNamed(route);
  }

  void _onNavItemTapped(int index) {
    setState(() => _selectedNavIndex = index);
    switch (index) {
      case 0:
        break; // Already on home
      case 1:
        _navigateTo(AppRoutes.search);
      case 2:
        _navigateTo(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        body: Column(
          children: [
            // Sticky header
            SafeArea(
              bottom: false,
              child: HomeHeader(
                onProfileTap: () => _navigateTo(AppRoutes.profile),
              ),
            ),
            // Scrollable body
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: HeroSection(
                      onSearch: (query) {
                        if (query.trim().isNotEmpty) {
                          _navigateTo(AppRoutes.search);
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ActionButtons(
                      onSearchTap: () => _navigateTo(AppRoutes.search),
                      onPostTap: () => _navigateTo(AppRoutes.postProperty),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PropertyCategories(
                      onCategoryTap: (cat) => _navigateTo(AppRoutes.search),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FeaturedProperties(
                      properties: dummyProperties,
                      onPropertyTap: (prop) =>
                          _navigateTo(AppRoutes.propertyDetail),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: HowMovexWorks(),
                  ),
                  const SliverToBoxAdapter(
                    child: WhyMovex(),
                  ),
                  const SliverToBoxAdapter(
                    child: _Footer(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _MovexBottomNav(
          selectedIndex: _selectedNavIndex,
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 32, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Movex',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Connecting tenants and property owners across Pune. Find your perfect space today.',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.white.withAlpha(178),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Divider(color: Colors.white.withAlpha(40), height: 1),
          const SizedBox(height: 14),
          Text(
            '© 2024 Movex. All rights reserved.',
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withAlpha(120),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovexBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _MovexBottomNav({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        border: const Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                outlineIcon: Icons.home_outlined,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.search_rounded,
                outlineIcon: Icons.search_outlined,
                label: 'Search',
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                outlineIcon: Icons.person_outline_rounded,
                label: 'Profile',
                isSelected: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData outlineIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.outlineIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent.withAlpha(20)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  isSelected ? icon : outlineIcon,
                  color: isSelected ? AppColors.accent : AppColors.textSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color:
                      isSelected ? AppColors.accent : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
