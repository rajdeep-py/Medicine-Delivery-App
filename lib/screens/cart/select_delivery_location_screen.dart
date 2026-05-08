import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import '../../theme/app_theme.dart';

class SelectDeliveryLocationScreen extends StatefulWidget {
  const SelectDeliveryLocationScreen({super.key});

  @override
  State<SelectDeliveryLocationScreen> createState() =>
      _SelectDeliveryLocationScreenState();
}

class _SelectDeliveryLocationScreenState
    extends State<SelectDeliveryLocationScreen> {
  final MapController _mapController = MapController();
  LatLng _selectedLocation = const LatLng(
    22.5726,
    88.3639,
  ); // Default to Kolkata
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _isLoading = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _isLoading = false);
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
    });
    _mapController.move(_selectedLocation, 15);
  }

  void _confirmLocation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Location'),
        content: Text(
          'Do you want to set this as your delivery location?\n\n'
          'Lat: ${_selectedLocation.latitude.toStringAsFixed(4)}\n'
          'Long: ${_selectedLocation.longitude.toStringAsFixed(4)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.pop(_selectedLocation); // Return to cart with location
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAccent,
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            IconsaxPlusLinear.arrow_left_2,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: AppTextStyles.header.copyWith(fontSize: 18),
            ),
            Text(
              'Drag the map to pinpoint your address',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation,
              initialZoom: 15.0,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  setState(() {
                    _selectedLocation = position.center;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.medapp.medicine_customer_app',
              ),
            ],
          ),

          // Fixed Center Pointer
          const Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 40,
              ), // Offset to align point of pin
              child: Icon(
                Icons.location_on,
                size: 50,
                color: AppColors.primaryAccent,
              ),
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.white.withAlpha(200),
              child: const Center(child: CircularProgressIndicator()),
            ),

          // Confirm Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _confirmLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: AppColors.primary.withAlpha(80),
              ),
              child: Text(
                'CONFIRM DELIVERY LOCATION',
                style: AppTextStyles.tagline.copyWith(
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
