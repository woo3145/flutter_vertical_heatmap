import 'package:flutter/material.dart';
import 'package:flutter_vertical_heatmap/flutter_vertical_heatmap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Vertical Heatmap Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Vertical Heatmap'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              HeatMap(
                startDate: HeatMapUtils.oneYearBefore(DateTime.now()),
                endDate: DateTime.now(),
                monthLabel: HeatMapDefault.monthLabel,
                weekLabel: HeatMapDefault.weekLabel,
                datasets: {
                  DateTime(2024, 5, 6): 3,
                  DateTime(2024, 5, 7): 7,
                  DateTime(2024, 5, 8): 10,
                  DateTime(2024, 5, 9): 13,
                  DateTime(2024, 5, 5): 6,
                },
                size: 32,
                margin: const EdgeInsets.all(3),
                colorsets: {
                  1: Colors.green.shade100,
                  4: Colors.green.shade300,
                  8: Colors.green.shade500,
                  12: Colors.green.shade700,
                },
                onClick: (value) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.toString()),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
