import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/responsive.dart';
import 'package:portfolio/src/features/testimonial/data/testimonial_repository.dart';
import 'package:portfolio/src/features/testimonial/presentation/widgets/testimonial_card.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class TestimonialDesktop extends ConsumerWidget {
  const TestimonialDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testimonials =
        ref.watch(testimonialRepositoryProvider).getTestimonials();
    var count = 1;
    if (Responsive.isDesktop(context)) {
      count = 2;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.testimonialSectionTitle).toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Text(
              tr(LocaleKeys.testimonialSectionLongTitle),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          DynamicHeightGridView(
            shrinkWrap: true,
            itemCount: testimonials.length,
            crossAxisCount: count,
            mainAxisSpacing: 50,
            crossAxisSpacing: 40,
            builder: (context, index) {
              final testimonial = testimonials[index];
              return TestimonialCard(testimonial: testimonial);
            },
          ),
          Row(
            children: [
              Text(
                'Convinced? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () => launchUrl(
                  Uri.parse('mailto:${tr(LocaleKeys.email)}'),
                ),
                child: Text(
                  'Talk to me',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
