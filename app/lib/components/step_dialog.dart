import 'package:era_connect_i18n/era_connect_i18n.dart';
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
  int _contentIndex = 0;

  void _nextStep() {
    final step = _getCurrentStep();
    if (_contentIndex < step.contents.length - 1) {
      setState(() {
        _contentIndex++;
      });
      return;
    }

    if (_isLastStep()) {
      return Navigator.of(context).pop();
    }

    setState(() {
      _contentIndex = 0;
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_contentIndex > 0) {
      setState(() {
        _contentIndex--;
      });
      return;
    }

    final step = _getCurrentStep();
    if (step.skippable) {
      return _nextStep();
    }

    setState(() {
      _contentIndex = 0;
      _currentStep--;
    });
  }

  StepData _getCurrentStep() => widget.steps[_currentStep];
  int _getStepIndex(StepData step) => widget.steps.indexOf(step);
  String _getStepName(StepData step) {
    if (step.stepName != null) {
      return step.stepName!;
    }

    final index = _getStepIndex(step) + 1;
    return index < 10 ? '0$index' : '$index';
  }

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

  Widget _buildBody() {
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
              Expanded(child: step.contents[_contentIndex]),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EraTextButton.secondary(
                    text: step.skippable
                        ? context.i18n['dialog.ui.skip']
                        : context.i18n['dialog.ui.back'],
                    onPressed: () {
                      _previousStep();
                    },
                  ),
                  const SizedBox(width: 10),
                  EraTextButton.primary(
                    text: _isLastStep()
                        ? context.i18n['dialog.ui.done']
                        : context.i18n['dialog.ui.next'],
                    onPressed: () {
                      _nextStep();
                    },
                  ),
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
  final List<Widget> contents;

  const StepData(
      {this.stepName,
      required this.stepDescription,
      required this.title,
      required this.description,
      required this.logoBoxText,
      this.skippable = false,
      required this.contents})
      : assert(contents.length > 0);
}
