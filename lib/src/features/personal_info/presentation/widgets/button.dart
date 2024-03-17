import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';

class Button extends ConsumerStatefulWidget {
  const Button({
    required this.title,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  ConsumerState<Button> createState() => _ButtonState();
}

class _ButtonState extends ConsumerState<Button> {
  bool _isHovered = false;
  void _hoverEffectOn() => setState(() => _isHovered = true);
  void _hoverEffectOff() => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => _hoverEffectOn(),
      onExit: (_) => _hoverEffectOff(),
      child: GestureDetector(
        onLongPress: _hoverEffectOn,
        onLongPressUp: _hoverEffectOff,
        child: SelectionContainer.disabled(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: _isHovered
                  ? theme.colorScheme.tertiary.withOpacity(0.1)
                  : null,
              side: BorderSide(
                width: _isHovered ? 2 : 1,
                color: theme.colorScheme.tertiary,
              ),
              elevation: 16,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            ),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Icon(
                  widget.icon,
                  color: theme.colorScheme.inverseSurface,
                ),
                gapW12,
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
