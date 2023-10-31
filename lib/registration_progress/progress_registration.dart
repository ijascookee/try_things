import 'package:flutter/material.dart';

// This widget represents the main registration process.
class RegistrationProcess extends StatefulWidget {
  const RegistrationProcess({super.key});

  @override
  _RegistrationProcessState createState() => _RegistrationProcessState();
}

class _RegistrationProcessState extends State<RegistrationProcess> {
  // Current page index in the PageView
  int _currentPage = 0;
  // Controller for the PageView
  final PageController _pageController = PageController();

  // This function calculates the progress of each registration step
  // based on the current page index.
  double calculateProgress(int stepIndex) {
    int totalPreviousPages = 0;
    for (int i = 0; i < stepIndex; i++) {
      totalPreviousPages += registrationSteps[i].items.length;
    }
    if (_currentPage < totalPreviousPages) return stepIndex == 0 ? 1.0 / registrationSteps[0].items.length : 0.0;
    if (_currentPage >= totalPreviousPages + registrationSteps[stepIndex].items.length) return 1.0;
    return (_currentPage - totalPreviousPages + 1) / registrationSteps[stepIndex].items.length;
  }

  @override
  Widget build(BuildContext context) {
    // List to hold all pages from all steps
    List<Widget> allPages = [];
    for (var step in registrationSteps) {
      allPages.addAll(step.items);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Process"),
      ),
      body: Column(
        children: [
          // Display multiple progress indicators in a row, one for each registration step
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: registrationSteps.map((step) {
                int stepIndex = registrationSteps.indexOf(step);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    // Linear progress indicator that shows the progress of the current registration step
                    child: LinearProgressIndicator(
                      value: calculateProgress(stepIndex),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Display all pages in a PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: allPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return allPages[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Class representing a single registration step, with a title and a list of pages (items).
class RegistrationStep {
  final String title;
  final List<Widget> items;

  RegistrationStep({required this.title, required this.items});
}

// Sample data for registration steps
List<RegistrationStep> registrationSteps = [
  RegistrationStep(title: "Personal Information", items: [BasicDataForm(), ReligionDataForm(), LocationDataForm()]),
  RegistrationStep(title: "Family Information", items: [FamilyDataForm()]),
  RegistrationStep(title: "Partner Preference Information", items: [PersonalDataForm(), EducationDataForm(), AdditionalDataForm()]),
];

// Below are widgets representing different forms/pages for the registration process.

class BasicDataForm extends StatelessWidget {
  const BasicDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Basic Data Form"));
  }
}

class ReligionDataForm extends StatelessWidget {
  const ReligionDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Religion Data Form"));
  }
}

class LocationDataForm extends StatelessWidget {
  const LocationDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Location Data Form"));
  }
}

class FamilyDataForm extends StatelessWidget {
  const FamilyDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Family Data Form"));
  }
}

class PersonalDataForm extends StatelessWidget {
  const PersonalDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Personal Data Form"));
  }
}

class EducationDataForm extends StatelessWidget {
  const EducationDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Education Data Form"));
  }
}

class AdditionalDataForm extends StatelessWidget {
  const AdditionalDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Additional Data Form"));
  }
}
