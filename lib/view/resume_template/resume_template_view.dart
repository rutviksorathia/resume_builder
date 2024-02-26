import 'package:flutter/material.dart';
import 'package:resume_builder/view/home/home_viewmodel.dart';
import 'package:resume_builder/view/resume_template/resume_template_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ResumeTemplateView extends StatelessWidget {
  final BasicDetails basicDetails;
  const ResumeTemplateView({
    super.key,
    required this.basicDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResumeTemplateViewModel>.reactive(
      viewModelBuilder: () => ResumeTemplateViewModel(),
      onViewModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              const Text('Resume Template'),
            ],
          ),
        );
      },
    );
  }
}
