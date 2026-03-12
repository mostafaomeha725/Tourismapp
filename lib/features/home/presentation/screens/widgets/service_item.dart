import 'package:flutter/material.dart';
import 'package:tourismapp/core/constants/app_assets.dart';

class ServiceItem {
  final String category;
  final String imageUrl;
  final String title;
  final String description;
  final String location;
  final String city;
  final String mapUrl;
  final IconData? icon;
  final double price;

  ServiceItem({
    required this.category,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.city,
    required this.mapUrl,
    required this.price,
    this.icon,
  });
}

final List<ServiceItem> allServices = [
  ServiceItem(
    category: 'Guides',
    imageUrl: Assets.egyptsplash,
    title: 'Pyramids of Giza and Sphinx',
    description:
        'One of the Seven Wonders of the ancient world, the famous three Giza Pyramids with the statue of the Great Sphinx',
    location: 'Giza, Egypt',
    city: 'Giza',
    mapUrl: "https://maps.app.goo.gl/art5k9NAJvDbYiGE9",
    icon: Icons.person_outline,
    price: 50,
  ),
  ServiceItem(
    category: 'Photographers',
    imageUrl: Assets.karnak,
    title: 'Karnak Temple (Luxor)',
    description:
        'A vast temple complex in Luxor, dedicated to Amun, Mut, and Khonsu, featuring towering columns and rich historical magic.',
    location: 'Luxor, Egypt',
    city: 'Luxor',
    mapUrl: "https://maps.app.goo.gl/t388psh3aaWk9hdKA",
    icon: Icons.camera_alt_outlined,
    price: 80,
  ),
  ServiceItem(
    category: 'Trips',
    imageUrl: Assets.egyptsplash,
    title: 'Pyramids of Giza and Sphinx',
    description:
        'One of the Seven Wonders of the ancient world, the famous three Giza Pyramids with the statue of the Great Sphinx',
    location: 'Giza, Egypt',
    city: 'Giza',
    mapUrl: "https://maps.app.goo.gl/art5k9NAJvDbYiGE9",
    icon: Icons.location_on_outlined,
    price: 120,
  ),
  ServiceItem(
    category: 'Trips',
    imageUrl: Assets.karnak,
    title: 'Karnak Temple (Luxor)',
    description:
        'A vast temple complex in Luxor, dedicated to Amun, Mut, and Khonsu, featuring towering columns and rich historical magic.',
    location: 'Luxor, Egypt',
    city: 'Luxor',
    mapUrl: "https://maps.app.goo.gl/t388psh3aaWk9hdKA",
    icon: Icons.location_on_outlined,
    price: 150,
  ),
  ServiceItem(
    category: 'Guides',
    imageUrl: Assets.karnak,
    title: 'Alexandria City Tour',
    description:
        'Discover the beauty of Alexandria, the pearl of the Mediterranean, with its stunning coastal views and ancient history.',
    location: 'Alexandria, Egypt',
    city: 'Alexandria',
    mapUrl: "https://maps.app.goo.gl/art5k9NAJvDbYiGE9",
    icon: Icons.person_outline,
    price: 60,
  ),
  ServiceItem(
    category: 'Trips',
    imageUrl: Assets.egyptsplash,
    title: 'Aswan Nile Cruise',
    description:
        'Enjoy a breathtaking Nile cruise in Aswan, exploring temples and natural wonders along the river.',
    location: 'Aswan, Egypt',
    city: 'Aswan',
    mapUrl: "https://maps.app.goo.gl/t388psh3aaWk9hdKA",
    icon: Icons.location_on_outlined,
    price: 200,
  ),
  ServiceItem(
    category: 'Photographers',
    imageUrl: Assets.egyptsplash,
    title: 'Sharm El Sheikh Dive',
    description:
        'Capture the vibrant underwater world of Sharm El Sheikh with a professional photographer.',
    location: 'Sharm El Sheikh, Egypt',
    city: 'Sharm El Sheikh',
    mapUrl: "https://maps.app.goo.gl/t388psh3aaWk9hdKA",
    icon: Icons.camera_alt_outlined,
    price: 100,
  ),
];
