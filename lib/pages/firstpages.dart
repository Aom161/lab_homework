import 'package:flutter/material.dart';
import 'package:lab_homework/pages/secondpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double bmiResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab_Homework"),
        backgroundColor: const Color.fromARGB(255, 182, 202, 238),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://mp-cms.medparkhospital.com/assets/4ff4b4cf-25b4-446d-a101-4be50f3827e6/shutterstock-1824590093--converted--1-.jpeg',
                height: 200,
                width: 400,
              ),
              const SizedBox(height: 20),
              const Text(
                'โปรแกรมคำนวณหาค่าดัชนีมวลกาย (BMI)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "ชื่อ-นามสกุล"),
              ),
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "รหัสนิสิต"),
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'น้ำหนัก กิโลกรัม(kg)'),
              ),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'ส่วนสูง เซนติเมตร(cm)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  calculateBMI();
                  _showResultDialog();
                },
                child: const Text('คำนวณ BMI'),
              ),
              const SizedBox(height: 20),
              bmiResult != 0.0
                  ? Column(
                      children: [
                        Text(
                          'BMI Result: ${bmiResult.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _getBMIStatus(),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      double heightInMeters = height / 100;
      bmiResult = weight / (heightInMeters * heightInMeters);
    } else {
      bmiResult = 0.0;
    }
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

  // first_page.dart

  void _showResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          name: _nameController.text,
          id: _idController.text,
          bmiResult: bmiResult,
        ),
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ผลลัพธ์ BMI'),
          backgroundColor: Color.fromARGB(255, 255, 235, 145),
          content: Column(
            children: [
              Text('ชื่อ-นามสกุล: ${_nameController.text}'),
              Text('รหัสนิสิต: ${_idController.text}'),
              Text('BMI: ${bmiResult.toStringAsFixed(2)}'),
              _getBMIStatus(),
              const SizedBox(height: 25),
              Image.network(
                'https://img.kapook.com/u/2020/sireeporn/Health-21/c2.jpg',
                height: 150,
                width: 300,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ปิด'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showResultScreen();
              },
              child: const Text('แสดงทั้งหน้าจอ'),
            ),
          ],
        );
      },
    );
  }
}
