import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BmiCalculator {
  double calculateBMI(double weight, double height) {
    // Convert height from centimeters to meters
    height = height / 100;
    // Implement your BMI calculation logic here
    return weight / (height * height);
  }

  String formattedBmi(double bmi) {
    // Implement your BMI formatting logic here
    return bmi.toStringAsFixed(2);
  }

  String getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}

class BmiCalculationPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final weightValue = useState(60.0);
    final heightValue = useState(170.0);

    void updateBmi({
      required double weight,
      required double height,
      required TextEditingController bmiController,
    }) {
      final bmi = BmiCalculator().calculateBMI(weight, height);
      if (bmi != null) {
        final formatted = BmiCalculator().formattedBmi(bmi);
        final category = BmiCalculator().getBmiCategory(bmi);
        bmiController.text = '$formatted - $category';
      } else {
        bmiController.text = 'BMI is null';
      }
    }

    final bmiController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight (kg)'),
                Text(weightValue.value.toString()),
              ],
            ),
            Slider(
              value: weightValue.value,
              min: 20,
              max: 150,
              divisions: 130,
              label: weightValue.value.round().toString(),
              onChanged: (value) => weightValue.value = value,
              onChangeEnd: (_) => updateBmi(
                  weight: weightValue.value,
                  height: heightValue.value,
                  bmiController: bmiController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Height (Cm)'),
                Text(heightValue.value.toString()),
              ],
            ),
            Slider(
              value: heightValue.value,
              min: 100,
              max: 250,
              divisions: 150,
              label: heightValue.value.round().toString(),
              onChanged: (value) => heightValue.value = value,
              onChangeEnd: (_) => updateBmi(
                  weight: weightValue.value,
                  height: heightValue.value,
                  bmiController: bmiController),
            ),
            TextField(
              controller: bmiController,
              decoration: InputDecoration(labelText: 'BMI'),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
