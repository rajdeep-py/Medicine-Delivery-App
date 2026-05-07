import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/medicine.dart';
import '../../cards/medicine/medicine_composition_card.dart';
import '../../cards/medicine/medicine_description_card.dart';
import '../../cards/medicine/medicine_precautions_card.dart';
import '../../cards/medicine/medicine_shop_card.dart';

class MedicineDetailScreen extends ConsumerStatefulWidget {
  final Medicine medicine;

  const MedicineDetailScreen({super.key, required this.medicine});

  @override
  ConsumerState<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends ConsumerState<MedicineDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Parallax Header with Swipeable Images
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.surface,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(200),
                    child: IconButton(
                      icon: const Icon(IconsaxPlusLinear.arrow_left_2, color: AppColors.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Swipeable Images
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) => setState(() => _currentPage = index),
                        itemCount: widget.medicine.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.medicine.images[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppColors.blush,
                              child: const Icon(IconsaxPlusLinear.box, size: 60, color: AppColors.textTertiary),
                            ),
                          );
                        },
                      ),
                      
                      // Text Overlay (Only on First Image)
                      if (_currentPage == 0)
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.medicine.name,
                                style: AppTextStyles.header.copyWith(color: Colors.white, fontSize: 26),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    widget.medicine.manufacturer,
                                    style: AppTextStyles.description.copyWith(color: Colors.white.withAlpha(200)),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.circle, size: 4, color: Colors.white70),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.medicine.quantity,
                                    style: AppTextStyles.description.copyWith(color: Colors.white.withAlpha(200)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '₹${widget.medicine.price.toInt()}',
                                style: AppTextStyles.header.copyWith(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      // Page Indicator
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Row(
                          children: List.generate(
                            widget.medicine.images.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(left: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index ? Colors.white : Colors.white.withAlpha(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Body
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  MedicineCompositionCard(
                    composition: widget.medicine.composition,
                    quantity: widget.medicine.quantity,
                  ),
                  MedicineDescriptionCard(description: widget.medicine.description),
                  MedicinePrecautionsCard(precautions: widget.medicine.precautions),
                  MedicineShopCard(
                    shopName: widget.medicine.shopName,
                    shopAddress: widget.medicine.shopAddress,
                  ),
                  const SizedBox(height: 120), // Space for FAB
                ]),
              ),
            ],
          ),
          
          // Floating Add to Cart Button
          Positioned(
            bottom: 30,
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart')),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(18),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(IconsaxPlusLinear.shopping_cart, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      'ADD TO CART',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
