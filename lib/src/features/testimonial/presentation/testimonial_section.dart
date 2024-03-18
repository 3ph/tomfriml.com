import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/responsive.dart';
import 'package:portfolio/src/features/testimonial/presentation/testimonial_desktop.dart';

class TestimonialSection extends ConsumerWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Responsive(
      desktop: TestimonialDesktop(),
    );
  }
}
