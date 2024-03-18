import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/features/testimonial/domain/testimonial.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';
import 'package:portfolio/src/localization/json_list_translation.dart';
import 'package:portfolio/src/localization/locale_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'testimonial_repository.g.dart';

@riverpod
TestimonialRepository testimonialRepository(TestimonialRepositoryRef ref) {
  return TestimonialRepository(ref);
}

class TestimonialRepository {
  TestimonialRepository(this._ref);

  final Ref _ref;

  List<Testimonial> getTestimonials() {
    final locale = _ref.watch(localeControllerProvider).locale;
    final jsonTestimonials = trList(locale, LocaleKeys.testimonials);
    final testimonials = jsonTestimonials.map((jsonTestimonial) {
      return Testimonial.fromJson(jsonTestimonial);
    }).toList();
    return testimonials;
  }
}
