import 'package:flutter/material.dart';

const _colorMap = <String, Color>{
  'Black': Color(0xFF1F2937),
  'White': Color(0xFFF9FAFB),
  'Navy': Color(0xFF1E3A8A),
  'Blue': Color(0xFF3B82F6),
  'Red': Color(0xFFDC2626),
  'Grey': Color(0xFF9CA3AF),
  'Olive': Color(0xFF6B7A3A),
  'Brown': Color(0xFF78502D),
  'Tan': Color(0xFFD2B48C),
  'Beige': Color(0xFFE7D8C0),
  'Silver': Color(0xFFCBD5E1),
};

Color colorFromName(String name) => _colorMap[name] ?? Colors.grey;

class VariantSection extends StatelessWidget {
  const VariantSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selected,
    required this.onSelected,
  });

  final List<String> sizes;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final s in sizes)
          ChoiceChip(
            label: Text(s),
            selected: s == selected,
            onSelected: (_) => onSelected(s),
          ),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<String> colors;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final name in colors)
          Tooltip(
            message: name,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => onSelected(name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: name == selected ? scheme.primary : scheme.outlineVariant,
                    width: name == selected ? 2.5 : 1,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorFromName(name),
                    border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  child: name == selected
                      ? Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: ThemeData.estimateBrightnessForColor(colorFromName(name)) ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black87,
                        )
                      : null,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
