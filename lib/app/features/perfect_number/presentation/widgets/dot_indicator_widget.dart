import 'package:flutter/material.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';

class DotIndicatorWidget extends StatelessWidget {
  final int count;
  final int current;

  const DotIndicatorWidget({
    super.key,
    required this.count,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                active
                    ? AppColors.of(context).primary
                    : AppColors.of(context).surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
