class LabTestBooking {
  final String? id;
  final String testId;
  final String fullName;
  final int age;
  final String phone;
  final String? altPhone;
  final String email;
  final String address;
  final double testAmount;
  final double platformCharges;
  final double collectionCharges;
  final double totalAmount;

  LabTestBooking({
    this.id,
    required this.testId,
    required this.fullName,
    required this.age,
    required this.phone,
    this.altPhone,
    required this.email,
    required this.address,
    required this.testAmount,
    this.platformCharges = 49.0,
    this.collectionCharges = 150.0,
    required this.totalAmount,
  });

  LabTestBooking copyWith({
    String? id,
    String? testId,
    String? fullName,
    int? age,
    String? phone,
    String? altPhone,
    String? email,
    String? address,
    double? testAmount,
    double? platformCharges,
    double? collectionCharges,
    double? totalAmount,
  }) {
    return LabTestBooking(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      altPhone: altPhone ?? this.altPhone,
      email: email ?? this.email,
      address: address ?? this.address,
      testAmount: testAmount ?? this.testAmount,
      platformCharges: platformCharges ?? this.platformCharges,
      collectionCharges: collectionCharges ?? this.collectionCharges,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
