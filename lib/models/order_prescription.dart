class OrderPrescription {
  final String id;
  final String fullName;
  final int age;
  final String phone;
  final String? altPhone;
  final String email;
  final String address;
  final List<String> prescriptionPhotos; // Paths to local files
  final DateTime createdAt;
  final String status; // 'pending', 'confirmed', 'delivered', etc.

  OrderPrescription({
    required this.id,
    required this.fullName,
    required this.age,
    required this.phone,
    this.altPhone,
    required this.email,
    required this.address,
    required this.prescriptionPhotos,
    required this.createdAt,
    this.status = 'pending',
  });

  OrderPrescription copyWith({
    String? id,
    String? fullName,
    int? age,
    String? phone,
    String? altPhone,
    String? email,
    String? address,
    List<String>? prescriptionPhotos,
    DateTime? createdAt,
    String? status,
  }) {
    return OrderPrescription(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      altPhone: altPhone ?? this.altPhone,
      email: email ?? this.email,
      address: address ?? this.address,
      prescriptionPhotos: prescriptionPhotos ?? this.prescriptionPhotos,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
