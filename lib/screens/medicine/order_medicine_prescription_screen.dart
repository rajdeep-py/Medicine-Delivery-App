import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../theme/app_theme.dart';
import '../../models/order_prescription.dart';
import '../../providers/order_prescription_provider.dart';

class OrderMedicinePrescriptionScreen extends ConsumerStatefulWidget {
  const OrderMedicinePrescriptionScreen({super.key});

  @override
  ConsumerState<OrderMedicinePrescriptionScreen> createState() =>
      _OrderMedicinePrescriptionScreenState();
}

class _OrderMedicinePrescriptionScreenState
    extends ConsumerState<OrderMedicinePrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  final List<XFile> _prescriptionPhotos = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    // Request permissions based on source
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        _showPermissionDeniedDialog('Camera');
        return;
      }
    } else {
      // For gallery, handling varies by platform but usually requested automatically by picker
      // On some Android versions/iOS it's better to check
      final status = await Permission.photos.request();
      if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog('Gallery');
        return;
      }
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (image != null) {
        setState(() {
          _prescriptionPhotos.add(image);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showPermissionDeniedDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$feature Permission Required'),
        content: Text('Please enable $feature access in settings to use this feature.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => openAppSettings(), child: const Text('Settings')),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')),
        );
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedDialog('Location');
      return;
    }

    setState(() => _addressController.text = "Fetching current location...");

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}";
        setState(() => _addressController.text = address);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _addressController.text = "");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching location: $e')),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _prescriptionPhotos.removeAt(index);
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Attach Prescription',
              style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPickerOption(
                  icon: IconsaxPlusLinear.camera,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                _buildPickerOption(
                  icon: IconsaxPlusLinear.gallery,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primaryAccent, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_prescriptionPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please attach at least one prescription photo')),
      );
      return;
    }

    final order = OrderPrescription(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _fullNameController.text,
      age: int.parse(_ageController.text),
      phone: _phoneController.text,
      altPhone: _altPhoneController.text,
      email: _emailController.text,
      address: _addressController.text,
      prescriptionPhotos: _prescriptionPhotos.map((x) => x.path).toList(),
      createdAt: DateTime.now(),
    );

    await ref.read(orderPrescriptionProvider.notifier).submitOrder(order);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order submitted successfully! Our team will contact you.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderPrescriptionProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(IconsaxPlusLinear.arrow_left_2, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order with Prescription', style: AppTextStyles.header.copyWith(fontSize: 20)),
            Text('Provide your details and upload prescription', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Personal Information'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: IconsaxPlusLinear.user,
                validator: (v) => v!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _ageController,
                      label: 'Age',
                      hint: 'Years',
                      icon: IconsaxPlusLinear.calendar,
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Age is required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'example@mail.com',
                      icon: IconsaxPlusLinear.sms,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.isEmpty ? 'Email is required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: '+91 00000 00000',
                icon: IconsaxPlusLinear.call,
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Phone is required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _altPhoneController,
                label: 'Alternative Phone (Optional)',
                hint: '+91 00000 00000',
                icon: IconsaxPlusLinear.call,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle('Delivery Address'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Full Address',
                hint: 'House No, Street, Landmark, City',
                icon: IconsaxPlusLinear.location,
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'Address is required' : null,
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(IconsaxPlusLinear.gps, size: 18),
                label: const Text('Use Current Location'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primaryAccent),
              ),

              const SizedBox(height: 32),
              _buildSectionTitle('Attach Prescription'),
              const SizedBox(height: 16),
              _buildPrescriptionPicker(),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: orderState.isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: AppColors.primaryAccent,
                  ),
                  child: orderState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          'SUBMIT ORDER',
                          style: AppTextStyles.tagline.copyWith(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.cardTitle.copyWith(fontSize: 16, color: AppColors.primaryAccent),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: AppTextStyles.description.copyWith(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.divider.withAlpha(100)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.divider.withAlpha(100)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPrescriptionPicker() {
    return Column(
      children: [
        if (_prescriptionPhotos.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _prescriptionPhotos.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(File(_prescriptionPhotos[index].path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _showImagePickerOptions,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryAccent.withAlpha(100), style: BorderStyle.none),
            ),
            child: Column(
              children: [
                Icon(IconsaxPlusLinear.add_square, color: AppColors.primaryAccent, size: 32),
                const SizedBox(height: 8),
                Text('Add Prescription Photos', style: AppTextStyles.tagline.copyWith(fontSize: 14)),
                Text('Camera or Gallery', style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
