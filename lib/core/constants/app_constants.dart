abstract final class AppStrings {
  static const String appName = 'Movex';

  // Hero
  static const String heroTitle = 'Find Your\nPerfect Property';
  static const String heroSubtitle =
      'Discover rooms, flats and PGs that match your needs.';
  static const String searchHint = 'Search by city, area or locality';

  // Action buttons
  static const String searchProperty = 'Search Property';
  static const String searchPropertySub = 'Find rooms, flats & PGs';
  static const String postProperty = 'Post Your Property';
  static const String postPropertySub = 'List your property for rent';

  // Sections
  static const String exploreProperties = 'Explore Properties';
  static const String howMovexWorks = 'How Movex Works';
  static const String featuredProperties = 'Featured Properties';
  static const String whyChooseMovex = 'Why Choose Movex?';

  // How it works steps
  static const String step1Title = 'Search Property';
  static const String step1Desc =
      'Browse properties and view photos and basic details.';
  static const String step2Title = 'Choose Your Property';
  static const String step2Desc =
      'Check the rent, amenities, property type and locality.';
  static const String step3Title = 'Unlock Owner Details';
  static const String step3Desc =
      'Pay ₹100 to unlock the owner\'s contact details and exact property location for that property.';

  // Why Movex
  static const String privacyTitle = 'Privacy Protected';
  static const String privacyDesc =
      'Owner details remain private until unlocked.';
  static const String photosTitle = 'Property Photos';
  static const String photosDesc =
      'Explore high-quality property photos before visiting.';
  static const String verifiedTitle = 'Verified Listings';
  static const String verifiedDesc =
      'All properties are manually reviewed for authenticity.';
  static const String affordableTitle = 'Affordable Access';
  static const String affordableDesc =
      'Pay only ₹100 per property — no monthly subscriptions.';

  // Property card
  static const String ownerLocked = 'Owner details locked';
  static const String viewProperty = 'View Property';
  static const String unlockAt = 'Unlock at ₹100';
}

abstract final class AppRoutes {
  static const String home = '/';
  static const String search = '/search';
  static const String postProperty = '/post-property';
  static const String profile = '/profile';
  static const String propertyDetail = '/property-detail';
}

/// Placeholder Unsplash images for featured properties.
/// Using reliable Unsplash source URLs with fixed IDs.
abstract final class PropertyImages {
  static const List<String> urls = [
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=600&q=80',
    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&q=80',
    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=600&q=80',
    'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=600&q=80',
    'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=600&q=80',
  ];
}
