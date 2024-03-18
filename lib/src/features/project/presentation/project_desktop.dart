import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/common/widgets/responsive.dart';
import 'package:portfolio/src/features/project/data/project_repository.dart';
import 'package:portfolio/src/features/project/presentation/widgets/project_card.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';

class ProjectDesktop extends ConsumerWidget {
  const ProjectDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectRepositoryProvider).getProjects();
    var count = 1;
    if (Responsive.isTablet(context)) {
      count = 2;
    } else if (Responsive.isDesktop(context)) {
      count = 3;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.projectsBarTitle).toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Text(
              tr(LocaleKeys.projectsSectionTitle),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          DynamicHeightGridView(
            shrinkWrap: true,
            itemCount: projects.length,
            crossAxisCount: count,
            mainAxisSpacing: 50,
            crossAxisSpacing: 40,
            builder: (context, index) {
              final project = projects[index];
              return ProjectCard(project: project);
            },
          ),
        ],
      ),
    );
  }
}
