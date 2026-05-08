import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_theme.dart';

class DeliveryDetailsCard extends StatefulWidget {
  final String? initialName;
  final String? initialPhone;
  final String? initialAddress;
  final Function(String, String, LatLng?) onDetailsChanged;

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
  String _displayAddress = '';
  LatLng? _selectedLatLng;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _displayAddress = widget.initialAddress ?? 'No location selected';

    _nameController.addListener(_notifyChanges);
    _phoneController.addListener(_notifyChanges);
  }

  void _notifyChanges() {
    widget.onDetailsChanged(
      _nameController.text,
      _phoneController.text,
      _selectedLatLng,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _navigateToMap() async {
    final LatLng? result = await context.push('/cart/select-location');
    if (result != null) {
      setState(() {
        _selectedLatLng = result;
        _displayAddress = "Lat: ${result.latitude.toStringAsFixed(4)}, Long: ${result.longitude.toStringAsFixed(4)}";
      });
      _notifyChanges();
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
          const SizedBox(height: 20),
          
          Text('Delivery Address', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _LocationButton(
                  icon: IconsaxPlusLinear.gps,
                  label: 'Use Current Location',
                  onTap: _navigateToMap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LocationButton(
                  icon: IconsaxPlusLinear.map,
                  label: 'Set on Map',
                  onTap: _navigateToMap,
                ),
              ),
            ],
          ),
          
          if (_selectedLatLng != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withAlpha(20)),
              ),
              child: Row(
                children: [
                  const Icon(IconsaxPlusLinear.location, size: 18, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _displayAddress,
                      style: AppTextStyles.description.copyWith(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

class _LocationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _LocationButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider.withAlpha(100)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.primaryAccent),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
