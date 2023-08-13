import 'package:era_connect_ui/components/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

const _iconSize = 30.0;

/// A dialog that displays a series of steps. Each step has a title, description, content, etc.
/// The step dialog must have at least 2 steps.
class StepDialog extends StatefulWidget {
  final List<StepData> steps;
  const StepDialog({super.key, required this.steps}) : assert(steps.length > 1);

  @override
  State<StepDialog> createState() => _StepDialogState();
}

class _StepDialogState extends State<StepDialog> {
  int _currentStep = 0;
  int _contentPageIndex = 0;

  /// Calls the event handler of the current step and if it returns true, calls the callback.
  void _callEvent(StepData step, StepEvent event, VoidCallback callback) {
    final eventHandler = step.onEvent;
    final success = eventHandler == null ? true : eventHandler(event);

    if (success) {
      callback();
    }
  }

  void _moveToStep(int stepIndex, int contentPageIndex) {
    setState(() {
      _currentStep = stepIndex;
      _contentPageIndex = contentPageIndex;
    });
  }

  void _nextStep() {
    final step = _getCurrentStep();

    if (_contentPageIndex < step.contentPages.length - 1) {
      setState(() {
        _contentPageIndex++;
      });
      return;
    }

    if (_isLastStep()) {
      _callEvent(step, StepEvent.done, () {
        Navigator.of(context).pop();
      });
      return;
    }

    _callEvent(step, StepEvent.next, () {
      _moveToStep(_currentStep + 1, 0);
    });
  }

  void _previousStep() {
    if (_contentPageIndex > 0) {
      setState(() {
        _contentPageIndex--;
      });
      return;
    }

    final step = _getCurrentStep();
    _callEvent(step, StepEvent.previous, () {
      final previousStep = widget.steps[_currentStep - 1];
      _moveToStep(_currentStep - 1, previousStep.contentPages.length - 1);
    });
  }

  StepData _getCurrentStep() => widget.steps[_currentStep];
  int _getStepIndex(StepData step) => widget.steps.indexOf(step);

  /// Returns the step index with a leading zero if it is less than 10.
  ///
  /// For example, if the step index is 0, it will return '01'.
  /// If the step index is 10, it will return '10'.
  String _getStepIndexName(StepData step) {
    final index = _getStepIndex(step) + 1;
    return index < 10 ? '0$index' : '$index';
  }

  bool _isLastStep() =>
      _currentStep == widget.steps.length - 1 &&
      _contentPageIndex == _getCurrentStep().contentPages.length - 1;
  bool _isFirstStep() => _currentStep == 0;

  @override
  Widget build(BuildContext context) {
    final step = _getCurrentStep();

    return InteractiveDialog(
      title: step.title,
      description: step.description,
      hasBrandText: step.hasBrandText,
      logoBoxText: step.logoBoxText ?? _getStepIndexName(step),
      isWide: _isLastStep(),
      body: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          layoutBuilder: (currentChild, previousChildren) {
            if (_isLastStep()) {
              return currentChild ?? const SizedBox.shrink();
            }

            return AnimatedSwitcher.defaultLayoutBuilder(
                currentChild, previousChildren);
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
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            duration: const Duration(milliseconds: 200),
            child: _buildStepState(e),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepState(StepData step) {
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
              step.stepName ?? _getStepIndexName(step),
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

    return Padding(
      key: ValueKey(_currentStep),
      padding: const EdgeInsets.only(top: 45, bottom: 35, left: 45, right: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: step.contentPages[_contentPageIndex]),
          const SizedBox(height: 25),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              direction: _isLastStep() ? Axis.vertical : Axis.horizontal,
              verticalDirection: VerticalDirection.up,
              spacing: 10,
              children: [
                if (!_isFirstStep())
                  EraDialogButton.iconSecondary(
                    icon: const Icon(Icons.skip_previous_rounded,
                        size: _iconSize),
                    isWide: _isLastStep(),
                    onPressed: () {
                      _previousStep();
                    },
                  ),
                EraDialogButton.iconPrimary(
                  icon: _isLastStep()
                      ? const Icon(Icons.check_rounded, size: _iconSize)
                      : const Icon(Icons.skip_next_rounded, size: _iconSize),
                  onPressed: () {
                    _nextStep();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StepData {
  final String? stepName;
  final String stepDescription;
  final String title;
  final String description;
  final String? logoBoxText;
  final bool hasBrandText;
  final List<Widget> contentPages;
  final bool Function(StepEvent event)? onEvent;

  const StepData(
      {this.stepName,
      required this.stepDescription,
      required this.title,
      required this.description,
      this.logoBoxText,
      this.hasBrandText = false,
      required this.contentPages,
      this.onEvent})
      : assert(contentPages.length > 0);
}

enum StepEvent {
  next,
  previous,
  done,
}
