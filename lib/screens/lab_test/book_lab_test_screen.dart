import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/lab_test.dart';
import '../../models/lab_test_booking.dart';
import '../../widgets/app_bar.dart';
import '../../cards/lab_test/test_booking_price_card.dart';
import '../../providers/book_lab_test_provider.dart';

class BookLabTestScreen extends ConsumerStatefulWidget {
  final LabTest test;

  const BookLabTestScreen({super.key, required this.test});

  @override
  ConsumerState<BookLabTestScreen> createState() => _BookLabTestScreenState();
}

class _BookLabTestScreenState extends ConsumerState<BookLabTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _altPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookLabTestProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Checkout',
        subtitle: 'Complete your booking details',
        showBackButton: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Details',
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: IconsaxPlusLinear.user,
                    validator: (v) => v!.isEmpty ? 'Please enter name' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _ageController,
                          label: 'Age',
                          icon: IconsaxPlusLinear.cake,
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildTextField(
                          controller: _phoneController,
                          label: 'Phone No',
                          icon: IconsaxPlusLinear.call,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _altPhoneController,
                    label: 'Alternative Phone No (Optional)',
                    icon: IconsaxPlusLinear.call_calling,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email ID',
                    icon: IconsaxPlusLinear.sms,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v!.isEmpty ? 'Please enter email' : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Collection Address',
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _addressController.text = 'Fetching location...';
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(
                              () => _addressController.text =
                                  'Sector 62, Noida, Uttar Pradesh 201309',
                            );
                          });
                        },
                        icon: const Icon(
                          IconsaxPlusLinear.location,
                          size: 16,
                          color: AppColors.primaryAccent,
                        ),
                        label: Text(
                          'Use Current Location',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Full Address',
                    icon: IconsaxPlusLinear.map,
                    maxLines: 3,
                    validator: (v) => v!.isEmpty ? 'Please enter address' : null,
                  ),
                  const SizedBox(height: 32),
                  TestBookingPriceCard(
                    testAmount: widget.test.price,
                    platformCharges: 49,
                    collectionCharges: 150,
                  ),
                  const SizedBox(height: 120), // Bottom padding for FAB
                ],
              ),
            ),
          ),

          // Floating Proceed Button
          Positioned(
            bottom: 30,
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
            child: InkWell(
              onTap: bookingState.isLoading ? null : _handleBooking,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: bookingState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'PROCEED TO PAYMENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, size: 20, color: AppColors.primaryAccent),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryAccent,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  void _handleBooking() async {
    if (_formKey.currentState!.validate()) {
      final booking = LabTestBooking(
        testId: widget.test.id,
        fullName: _nameController.text,
        age: int.parse(_ageController.text),
        phone: _phoneController.text,
        altPhone: _altPhoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        testAmount: widget.test.price,
        totalAmount: widget.test.price + 49 + 150,
      );

      await ref.read(bookLabTestProvider.notifier).createBooking(booking);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Redirecting to payment gateway...'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }
}
