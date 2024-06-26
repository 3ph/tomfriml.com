import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/animated_fade_slide.dart';
import 'package:portfolio/src/common/widgets/selection_area.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/about/presentation/about_section.dart';
import 'package:portfolio/src/features/personal_info/presentation/personal_info_section.dart';
import 'package:portfolio/src/features/main/presentation/widgets/app_bar.dart';
import 'package:portfolio/src/features/project/presentation/project_section.dart';
import 'package:portfolio/src/features/main/provider/scroll_controller.dart';
import 'package:portfolio/src/features/main/provider/section_key_provider.dart';
import 'package:portfolio/src/features/testimonial/presentation/testimonial_section.dart';

class MainDesktop extends ConsumerWidget {
  const MainDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProvider);

    return Column(
      children: [
        const MyAppBar(),
        Expanded(
          // This stack avoid pixel issue where a line is drawn between the two expanded
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
              ),
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Listener(
                            onPointerSignal: (PointerSignalEvent event) {
                              if (event is PointerScrollEvent) {
                                scrollController.position.moveTo(
                                  scrollController.position.pixels +
                                      event.scrollDelta.dy,
                                );
                              }
                            },
                            child: MySelectionArea(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    100, 80, 100, 100),
                                color: Theme.of(context).colorScheme.primary,
                                // child: const Align(
                                //   alignment: Alignment.topRight,
                                // child: AnimatedFadeSlide(
                                //   offset: Offset(-128, 0),
                                child: const PersonalInfoSection(),
                                // ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MySelectionArea(
                            child: Container(
                              padding: const EdgeInsets.only(top: 100),
                              color: Theme.of(context).colorScheme.primary,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 520,
                                  child: AnimatedFadeSlide(
                                    offset: const Offset(128, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: AboutSection(
                                        key: ref.watch(aboutSectionKeyProvider),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 120),
                        // ExperienceSection(
                        //   key: ref
                        //       .watch(experienceSectionKeyProvider),
                        // ),
                      ],
                    ),
                    gapH120,
                    ProjectSection(
                      key: ref.watch(projectSectionKeyProvider),
                    ),
                    gapH48,
                    TestimonialSection(
                        key: ref.watch(testimonialSectionKeyProvider)),
                    gapH64,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
