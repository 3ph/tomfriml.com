import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/src/features/personal_info/domain/resume.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/button.dart';
import 'package:portfolio/src/features/personal_info/presentation/widgets/resume_language_dialog.dart';
import 'package:portfolio/src/localization/generated/locale_keys.g.dart';
import 'package:portfolio/src/utils/launch_url_helper.dart';
import 'package:portfolio/src/utils/scaffold_messenger_helper.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key, required this.resumes});

  final List<Resume> resumes;

  @override
  Widget build(BuildContext context) {
    return Button(
      title: tr(LocaleKeys.resume),
      icon: FontAwesomeIcons.filePdf,
      onPressed: () => _onPressed(context),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    if (resumes.length > 1) {
      showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => ResumeLanguageDialog(resumes: resumes),
      );
    } else if (resumes.length == 1) {
      final resumeFirstUrl = resumes.first.url;
      if (resumeFirstUrl == null) {
        ScaffoldMessengerHelper.showLaunchUrlError(context);
      } else {
        try {
          await LaunchUrlHelper.launchURL(resumeFirstUrl);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessengerHelper.showLaunchUrlError(
              context,
              url: resumeFirstUrl,
            );
          }
        }
      }
    } else {
      ScaffoldMessengerHelper.showLaunchUrlError(context);
    }
  }
}
