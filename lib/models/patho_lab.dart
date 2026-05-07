class PathoLab {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final List<String> testIds; // IDs of tests available in this lab

  PathoLab({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.testIds,
  });
}
