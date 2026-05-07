import 'package:flutter/material.dart';

class LabTestCategory {
  final String id;
  final String name;
  final IconData icon;
  final bool isPopular;

  LabTestCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.isPopular = false,
  });
}

class TestParameter {
  final String name;
  final String value;

  TestParameter({required this.name, required this.value});
}

class LabTest {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String pathoLabName;
  final String imageUrl;
  final double price;
  final List<TestParameter> parameters;
  final List<String> precautions;

  LabTest({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.pathoLabName,
    required this.imageUrl,
    required this.price,
    this.parameters = const [],
    this.precautions = const [],
  });
}
