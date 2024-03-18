import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/testimonial/domain/testimonial.dart';

class TestimonialCard extends ConsumerStatefulWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final Testimonial testimonial;

  @override
  ConsumerState<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends ConsumerState<TestimonialCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Positioned(
                left: 0,
                top: 0,
                child: Icon(
                  FontAwesomeIcons.quoteLeft,
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  FontAwesomeIcons.quoteRight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  widget.testimonial.text!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.testimonial.name?.toUpperCase() ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                gapW16,
                Text(
                  widget.testimonial.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
