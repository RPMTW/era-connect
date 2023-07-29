import 'package:era_connect_ui/components/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class StepDialog extends StatefulWidget {
  final List<StepData> steps;
  const StepDialog({super.key, required this.steps}) : assert(steps.length > 1);

  @override
  State<StepDialog> createState() => _StepDialogState();
}

class _StepDialogState extends State<StepDialog> {
  int _currentStep = 0;

  void _nextStep() {
    if (_isLastStep()) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  StepData _getCurrentStep() => widget.steps[_currentStep];
  int _getStepIndex(StepData step) => widget.steps.indexOf(step);
  String _getStepName(StepData step) =>
      step.stepName ?? '0${_getStepIndex(step) + 1}';
  bool _isLastStep() => _currentStep == widget.steps.length - 1;

  @override
  Widget build(BuildContext context) {
    final step = _getCurrentStep();

    return InteractiveDialog(
      title: step.title,
      description: step.description,
      logoBoxText: step.logoBoxText,
      body: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 250),
          child: _buildBody()),
      statusBox: Column(
        children: widget.steps.map((e) {
          return AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            duration: const Duration(milliseconds: 200),
            child: _buildStepState(e),
          );
        }).toList(),
      ),
    );
  }

  RenderObjectWidget _buildStepState(StepData step) {
    final bool isCurrentStep = _getStepIndex(step) == _currentStep;
    if (_getStepIndex(step) > _currentStep) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              _getStepName(step),
              style: TextStyle(
                color: context.theme.accentColor,
                fontSize: 30,
                fontFamily: 'Graduate',
              ),
            ),
            const SizedBox(width: 20),
            Text(
              step.stepDescription,
              style: TextStyle(
                color: isCurrentStep
                    ? context.theme.textColor
                    : context.theme.tertiaryTextColor,
                fontSize: 20,
              ),
            )
          ],
        ),
        Icon(
          isCurrentStep ? Icons.play_arrow_rounded : Icons.done_all_rounded,
          size: 25,
          color: context.theme.accentColor,
        )
      ],
    );
  }

  Builder _buildBody() {
    final step = _getCurrentStep();

    return Builder(
      key: ValueKey(_currentStep),
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 45, bottom: 35, left: 45, right: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: step.contentBuilder(context)),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EraTextButton.secondary(
                    text: step.skippable ? '略過' : '上一步',
                    onPressed: () {
                      if (step.skippable) {
                        _nextStep();
                      } else {
                        setState(() {
                          _currentStep--;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  EraTextButton.primary(
                      text: _isLastStep() ? '完成' : '繼續',
                      onPressed: () {
                        _nextStep();
                      }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class StepData {
  final String? stepName;
  final String stepDescription;
  final String title;
  final String description;
  final String logoBoxText;
  final bool skippable;
  final WidgetBuilder contentBuilder;

  const StepData(
      {this.stepName,
      required this.stepDescription,
      required this.title,
      required this.description,
      required this.logoBoxText,
      this.skippable = false,
      required this.contentBuilder});
}
