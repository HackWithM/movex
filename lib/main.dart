import 'package:flutter/material.dart';
import 'package:movex/core/theme/app_theme.dart';
import 'package:movex/core/constants/app_constants.dart';
import 'package:movex/features/home/home_screen.dart';
import 'package:movex/screens/placeholder_screens.dart';

void main() {
  runApp(const MovexApp());
}

class MovexApp extends StatelessWidget {
  const MovexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.search: (context) => const PropertySearchScreen(),
        AppRoutes.postProperty: (context) => const PostPropertyScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.propertyDetail: (context) => const PropertyDetailScreen(),
      },
    );
  }
}
