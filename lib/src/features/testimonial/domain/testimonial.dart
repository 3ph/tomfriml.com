import 'package:freezed_annotation/freezed_annotation.dart';

part 'testimonial.freezed.dart';
part 'testimonial.g.dart';

@freezed
class Testimonial with _$Testimonial {
  const factory Testimonial({
    String? text,
    String? name,
    String? title,
  }) = _Testimonial;

  factory Testimonial.fromJson(Map<String, dynamic> json) =>
      _$TestimonialFromJson(json);
}
