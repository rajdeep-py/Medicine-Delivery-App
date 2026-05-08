import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../theme/app_theme.dart';

class DeliveryDetailsCard extends StatefulWidget {
  final String? initialName;
  final String? initialPhone;
  final String? initialAddress;
  final Function(String, String, String) onDetailsChanged;

  const DeliveryDetailsCard({
    super.key,
    this.initialName,
    this.initialPhone,
    this.initialAddress,
    required this.onDetailsChanged,
  });

  @override
  State<DeliveryDetailsCard> createState() => _DeliveryDetailsCardState();
}

class _DeliveryDetailsCardState extends State<DeliveryDetailsCard> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  bool _isFetchingLocation = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _addressController = TextEditingController(text: widget.initialAddress);

    _nameController.addListener(_notifyChanges);
    _phoneController.addListener(_notifyChanges);
    _addressController.addListener(_notifyChanges);
  }

  void _notifyChanges() {
    widget.onDetailsChanged(
      _nameController.text,
      _phoneController.text,
      _addressController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String address = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
          _addressController.text = address;
        }
      }
    } catch (e) {
      debugPrint("Location error: $e");
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: AppCardStyles.sleekCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(IconsaxPlusLinear.truck, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Delivery Details', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
            ],
          ),
          const Divider(height: 24),
          
          _buildField('Receiver Name', _nameController, IconsaxPlusLinear.user),
          const SizedBox(height: 12),
          _buildField('Phone Number', _phoneController, IconsaxPlusLinear.call, TextInputType.phone),
          const SizedBox(height: 12),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Address', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                  TextButton.icon(
                    onPressed: _isFetchingLocation ? null : _getCurrentLocation,
                    icon: _isFetchingLocation 
                      ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(IconsaxPlusLinear.gps, size: 14),
                    label: Text(_isFetchingLocation ? 'Fetching...' : 'Use Current', style: const TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: AppColors.primaryAccent),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _addressController,
                maxLines: 2,
                style: AppTextStyles.description.copyWith(fontSize: 14, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Enter complete address',
                  prefixIcon: const Icon(IconsaxPlusLinear.location, size: 18),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, [TextInputType? type]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: type,
          style: AppTextStyles.description.copyWith(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Enter $label',
            prefixIcon: Icon(icon, size: 18),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
