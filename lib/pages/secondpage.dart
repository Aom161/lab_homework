import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String name;
  final String id;
  final double bmiResult;

  ResultScreen({
    required this.name,
    required this.id,
    required this.bmiResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์ BMI'),
        backgroundColor: Color.fromARGB(255, 255, 235, 145),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ชื่อ-นามสกุล: $name'),
            Text('รหัสนิสิต: $id'),
            Text('BMI: ${bmiResult.toStringAsFixed(2)}'),
            _getBMIStatus(),
            SizedBox(height: 30),
            Image.network(
              'https://img.kapook.com/u/2020/sireeporn/Health-21/c2.jpg',
              height: 500,
              width: 1000,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBMIStatus() {
    if (bmiResult < 18.5) {
      return Text('สถานะ: น้ำหนักน้อย/ผอม');
    } else if (bmiResult >= 18.5 && bmiResult < 24.9) {
      return Text('สถานะ: น้ำหนักปกติ');
    } else if (bmiResult >= 25 && bmiResult < 29.9) {
      return Text('สถานะ: น้ำหนักเกิน');
    } else {
      return Text('สถานะ: อ้วน');
    }
  }
}
