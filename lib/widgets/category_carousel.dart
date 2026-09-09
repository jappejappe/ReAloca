import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';

class CategoryCarousel extends StatefulWidget {
  final ItemCategory? selectedCategory;
  final ValueChanged<ItemCategory?> onCategorySelected;

  const CategoryCarousel({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryCarousel> createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: ItemCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = ItemCategory.values[index];
          final isSelected = widget.selectedCategory == category;
          return _CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () {
              widget.onCategorySelected(isSelected ? null : category);
            },
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final ItemCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: 90,
          decoration: BoxDecoration(
            gradient: widget.isSelected ? AppTheme.primaryGradient : null,
            color: widget.isSelected ? null : AppTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSelected
                  ? AppTheme.accentGreen.withValues(alpha: 0.6)
                  : AppTheme.primaryGreen.withValues(alpha: 0.2),
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.category.icon,
                color: widget.isSelected
                    ? Colors.white
                    : AppTheme.textMuted,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                widget.category.label,
                style: TextStyle(
                  color: widget.isSelected
                      ? Colors.white
                      : AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: widget.isSelected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
