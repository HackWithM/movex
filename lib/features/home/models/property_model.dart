import 'package:flutter/material.dart';

enum FurnishingStatus { fullyFurnished, semiFurnished, unfurnished }

enum PropertyType { flat, room, pg, oneRK, sharedRoom }

class PropertyModel {
  final String id;
  final String title;
  final PropertyType type;
  final int rentPerMonth;
  final int deposit;
  final String locality;
  final String city;
  final FurnishingStatus furnishing;
  final String bhkConfig;
  final String imageUrl;
  final List<String> amenities;
  final bool isOwnerLocked;

  const PropertyModel({
    required this.id,
    required this.title,
    required this.type,
    required this.rentPerMonth,
    required this.deposit,
    required this.locality,
    required this.city,
    required this.furnishing,
    required this.bhkConfig,
    required this.imageUrl,
    this.amenities = const [],
    this.isOwnerLocked = true,
  });

  String get typeLabel {
    switch (type) {
      case PropertyType.flat:
        return 'Flat';
      case PropertyType.room:
        return 'Room';
      case PropertyType.pg:
        return 'PG';
      case PropertyType.oneRK:
        return '1 RK';
      case PropertyType.sharedRoom:
        return 'Shared Room';
    }
  }

  String get furnishingLabel {
    switch (furnishing) {
      case FurnishingStatus.fullyFurnished:
        return 'Fully Furnished';
      case FurnishingStatus.semiFurnished:
        return 'Semi Furnished';
      case FurnishingStatus.unfurnished:
        return 'Unfurnished';
    }
  }

  Color get furnishingColor {
    switch (furnishing) {
      case FurnishingStatus.fullyFurnished:
        return const Color(0xFF22C55E);
      case FurnishingStatus.semiFurnished:
        return const Color(0xFFF59E0B);
      case FurnishingStatus.unfurnished:
        return const Color(0xFF6B7280);
    }
  }

  String get formattedRent {
    if (rentPerMonth >= 1000) {
      final k = rentPerMonth ~/ 1000;
      final rem = rentPerMonth % 1000;
      if (rem == 0) return '${k}k';
      return '$k,${rem.toString().padLeft(3, '0')}';
    }
    return rentPerMonth.toString();
  }
}

/// Dummy featured property data for UI demonstration.
final List<PropertyModel> dummyProperties = [
  const PropertyModel(
    id: 'prop_001',
    title: '1 BHK Apartment',
    type: PropertyType.flat,
    rentPerMonth: 14000,
    deposit: 42000,
    locality: 'Wakad',
    city: 'Pune',
    furnishing: FurnishingStatus.fullyFurnished,
    bhkConfig: '1 BHK',
    imageUrl:
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=600&q=80',
    amenities: ['WiFi', 'AC', 'Geyser', 'Parking'],
  ),
  const PropertyModel(
    id: 'prop_002',
    title: '2 BHK Premium Flat',
    type: PropertyType.flat,
    rentPerMonth: 22000,
    deposit: 66000,
    locality: 'Hinjewadi',
    city: 'Pune',
    furnishing: FurnishingStatus.semiFurnished,
    bhkConfig: '2 BHK',
    imageUrl:
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&q=80',
    amenities: ['Gym', 'Swimming Pool', 'Security', 'Parking'],
  ),
  const PropertyModel(
    id: 'prop_003',
    title: 'Studio Room',
    type: PropertyType.oneRK,
    rentPerMonth: 9500,
    deposit: 19000,
    locality: 'Baner',
    city: 'Pune',
    furnishing: FurnishingStatus.fullyFurnished,
    bhkConfig: '1 RK',
    imageUrl:
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=600&q=80',
    amenities: ['WiFi', 'Geyser', 'Power Backup'],
  ),
  const PropertyModel(
    id: 'prop_004',
    title: '3 BHK Spacious Flat',
    type: PropertyType.flat,
    rentPerMonth: 32000,
    deposit: 96000,
    locality: 'Kharadi',
    city: 'Pune',
    furnishing: FurnishingStatus.fullyFurnished,
    bhkConfig: '3 BHK',
    imageUrl:
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=600&q=80',
    amenities: ['Modular Kitchen', 'AC', 'Security', 'Parking', 'Gym'],
  ),
  const PropertyModel(
    id: 'prop_005',
    title: 'PG for Working Professionals',
    type: PropertyType.pg,
    rentPerMonth: 7000,
    deposit: 14000,
    locality: 'Viman Nagar',
    city: 'Pune',
    furnishing: FurnishingStatus.fullyFurnished,
    bhkConfig: 'Shared',
    imageUrl:
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=600&q=80',
    amenities: ['Meals Included', 'WiFi', 'Laundry', 'AC'],
  ),
];
