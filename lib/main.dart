import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // states
  final _formKey = GlobalKey<FormState>();
  double height = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      weight = double.parse(value);
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter height';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      height = double.parse(value);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      // Perform calculations or further actions with weight and height values
                      // For example: calculate BMI
                      double bmi = weight / ((height / 100) * (height / 100));
                      // Display the calculated result or perform any desired actions
          
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => BMIpage(bmi: bmi)),
                      );
          
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all the fields')),
                      );
                    }
                  },
                  child: const Text('Calculate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class BMIpage extends StatelessWidget {
  final double bmi;

  const BMIpage({super.key, required this.bmi});

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Normal weight";
    } else if (bmi >= 25 && bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  @override
  Widget build(BuildContext context) {

    final bmiStatus = getBMICategory(bmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Your Results: "),
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bmiStatus,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      )
    );
  }
}