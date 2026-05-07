import 'package:flutter/material.dart';

class LabTestCategory {
  final String id;
  final String name;
  final IconData icon;

  LabTestCategory({required this.id, required this.name, required this.icon});
}

class LabTest {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final double price;

  LabTest({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
  });
}
