import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/constants/sizes.dart';
import 'package:portfolio/src/features/project/domain/project.dart';
import 'package:portfolio/src/features/project/presentation/widgets/project_description.dart';
import 'package:portfolio/src/features/project/presentation/widgets/project_image.dart';
import 'package:portfolio/src/common/widgets/responsive.dart';
import 'package:portfolio/src/utils/launch_url_helper.dart';
import 'package:portfolio/src/utils/scaffold_messenger_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends ConsumerStatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  bool _isHovered = false;
  void _scaleUp() => setState(() => _isHovered = true);
  void _scaleDown() => setState(() => _isHovered = false);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _scaleUp(),
      onExit: (_) => _scaleDown(),
      child: GestureDetector(
        onLongPress: _scaleUp,
        onLongPressUp: _scaleDown,
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: _onTap,
            borderRadius: BorderRadius.circular(20),
            hoverColor: Theme.of(context).colorScheme.tertiary.withAlpha(40),
            splashColor: Theme.of(context).colorScheme.tertiary.withAlpha(30),
            highlightColor:
                Theme.of(context).colorScheme.tertiary.withAlpha(20),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildResponsiveProjectCardContent(context),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() async {
    final url = widget.project.url;
    if (url == null) return;
    try {
      await LaunchUrlHelper.launchURL(url);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessengerHelper.showLaunchUrlError(context, url: url);
      }
    }
  }

  Widget _buildResponsiveProjectCardContent(BuildContext context) {
    final projectName = widget.project.name;
    if (!Responsive.isTablet(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProjectTitle(projectName: projectName),
          gapH8,
          ProjectImage(project: widget.project, isHovered: _isHovered),
          gapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.project.googlePlayUrl != null)
                IconButton(
                  onPressed: () =>
                      launchUrl(Uri.parse(widget.project.googlePlayUrl!)),
                  icon: Image.asset(
                    'assets/images/google-play-badge.png',
                    height: 50,
                    width: 130,
                  ),
                ),
              if (widget.project.appStoreUrl != null)
                IconButton(
                  onPressed: () =>
                      launchUrl(Uri.parse(widget.project.appStoreUrl!)),
                  icon: Image.asset(
                    'assets/images/app-store-badge.png',
                    height: 50,
                    width: 130,
                  ),
                ),
            ],
          ),
          ProjectDescription(project: widget.project),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              _ProjectTitle(projectName: projectName),
              gapH8,
              ProjectImage(project: widget.project, isHovered: _isHovered),
            ],
          ),
        ),
        gapW12,
        Expanded(
          flex: 10,
          child: ProjectDescription(project: widget.project),
        ),
      ],
    );
  }
}

class _ProjectTitle extends StatelessWidget {
  const _ProjectTitle({
    super.key,
    required this.projectName,
  });

  final String? projectName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          projectName != null ? "$projectName " : "",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
