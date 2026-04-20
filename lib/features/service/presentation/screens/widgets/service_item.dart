import 'package:flutter/material.dart';

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
