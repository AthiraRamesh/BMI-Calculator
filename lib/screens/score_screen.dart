import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ScoreScreen extends StatelessWidget {
  final double bmiScore;
  final int age;
  String? bmiStatus, bmiInterpretation;
  Color? bmiStatusColor;
  ScoreScreen({super.key, required this.bmiScore, required this.age});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretattion();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(12),
            child: Card(
                elevation: 12,
                shape: const RoundedRectangleBorder(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "BMI(kg/m^2)",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.blueGrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PrettyGauge(
                        gaugeSize: 300,
                        minValue: 0,
                        maxValue: 40,
                        segments: [
                          GaugeSegment("UnderWeight", 18.5, Colors.blue),
                          GaugeSegment("Normal", 6.4, Colors.green),
                          GaugeSegment("OverWeight", 5, Colors.orange),
                          GaugeSegment("Obese", 10.1, Colors.red),
                        ],
                        valueWidget: Text(
                          bmiScore.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 40),
                        ),
                        currentValue: bmiScore.toDouble(),
                        needleColor: Colors.black87,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bmiStatus!,
                        style: TextStyle(fontSize: 20, color: bmiStatusColor!,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        bmiInterpretation!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Re-Calculate")),
                          const SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Share.share(
                                    "Your BMI is ${bmiScore.toStringAsFixed(1)} at the age $age");
                              },
                              child: const Text("Share")),
                              
                        ],
                      ),const SizedBox(
                            height: 20,
                          ),
              Column(
        children: [
        //   Text(
        // 'BMI Range:',
        // style: TextStyle(
        //   fontSize: 24.0,
        //   color: Colors.blueGrey,
        //   fontWeight: FontWeight.bold,
        // ),
        //   ),
          SizedBox(height: 10.0),
          ListTile(leading: CircleAvatar(backgroundColor: Colors.blue),
        title: Text('Underweight: < 18.5', style: TextStyle(fontSize: 18.0)),
          ),
          ListTile(leading: CircleAvatar(backgroundColor: Colors.green),
        title: Text('Normal: 18.5 - 24.9', style: TextStyle(fontSize: 18.0)),
          ),
          ListTile(leading: CircleAvatar(backgroundColor: Colors.orange),
        title: Text('Overweight: 25.0 - 29.9', style: TextStyle(fontSize: 18.0)),
          ),
          ListTile(leading: CircleAvatar(backgroundColor: Colors.red),
        title: Text('Obese: >= 30.0', style: TextStyle(fontSize: 18.0)),
          ),
          SizedBox(height: 10.0),
        ],
      )
      
                    ]))),
      ),
    );
  }

  void setBmiInterpretattion() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.red;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce your weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit !";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase your weight";
      bmiStatusColor = Colors.blue;
    }
  }
}
