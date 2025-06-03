import 'package:flutter/material.dart';

class AnimatedTabIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;

  const AnimatedTabIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.teal.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSelected ? 1.2 : 1.0,
                curve: Curves.easeOut,
                child: Icon(
                  icon,
                  color: isSelected ? Colors.teal : Colors.grey,
                  size: 26,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isSelected ? Colors.teal : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
