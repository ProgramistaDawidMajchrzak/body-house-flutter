import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/screens/calendar/session_to_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddTrainingFlow extends StatefulWidget {
  const AddTrainingFlow({super.key});

  @override
  State<AddTrainingFlow> createState() => _AddTrainingFlowState();
}

class _AddTrainingFlowState extends State<AddTrainingFlow> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _goToNextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TrainingSelectionStep(onNext: _goToNextStep),
          TimeSelectionStep(onBack: _goToPreviousStep, onNext: _goToNextStep),
          // RepeatSelectionStep(onBack: _goToPreviousStep),
        ],
      ),
    );
  }
}

class TrainingSelectionStep extends StatelessWidget {
  final VoidCallback onNext;

  const TrainingSelectionStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Wybierz trening",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SessionToAdd(),
                  );
                }),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Dalej"),
          ),
        ],
      ),
    );
  }
}

class TimeSelectionStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const TimeSelectionStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Wybierz czas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              children: <Widget>[
                //            hourMinute12H(),
                hourMinute15Interval(),
                //            hourMinuteSecond(),
                //            hourMinute12HCustomStyle(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    "text",
                    // _dateTime.hour.toString().padLeft(2, '0') + ':' +
                    //     _dateTime.minute.toString().padLeft(2, '0') + ':' +
                    //     _dateTime.second.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Dalej"),
          ),
        ],
      ),
    );
  }
}

Widget hourMinute15Interval() {
  return new TimePickerSpinner(
    spacing: 40,
    minutesInterval: 15,
    // onTimeChange: (time) {
    //   setState(() {
    //     _dateTime = time;
    //   });
    // },
  );
}
