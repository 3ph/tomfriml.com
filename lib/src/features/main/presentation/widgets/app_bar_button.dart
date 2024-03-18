import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarButton extends ConsumerWidget {
  const AppBarButton({
    required this.title,
    this.color,
    this.onPressed,
    super.key,
  });

  final String title;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      hoverColor: Theme.of(context).colorScheme.primary,
      splashColor: Theme.of(context).colorScheme.tertiary,
      color: color,
      shape: const Border(),
      onPressed: onPressed,
      child: SizedBox(
        height: 56,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
