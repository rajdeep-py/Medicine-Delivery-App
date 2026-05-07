import 'package:flutter/material.dart';

class Medicine {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final double price;
  final List<String> images; // Changed from imageUrl to images
  final String manufacturer;
  final bool isPrescriptionRequired;
  final String quantity; // e.g., "10 Tablets", "100ml"
  final String composition;
  final List<String> precautions;
  final String shopName;
  final String shopAddress;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.images,
    required this.manufacturer,
    required this.isPrescriptionRequired,
    required this.quantity,
    required this.composition,
    required this.precautions,
    required this.shopName,
    required this.shopAddress,
  });
}

class MedicineCategory {
  final String id;
  final String name;
  final IconData icon;
  final bool isPopular;
  final bool isMostOrdered;

  MedicineCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.isPopular = false,
    this.isMostOrdered = false,
  });
}
