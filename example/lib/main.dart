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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<DateTime, int> datasets = {};

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    datasets[DateTime(now.year, now.month, now.day)] = 1;
    datasets[DateTime(now.year, now.month, now.day - 1)] = 2;
    datasets[DateTime(now.year, now.month, now.day - 2)] = 3;
    datasets[DateTime(now.year, now.month, now.day - 3)] = 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Vertical Heatmap'),
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
                datasets: datasets,
                size: 32,
                margin: const EdgeInsets.all(3),
                colorsets: {
                  1: Colors.green.shade100,
                  2: Colors.green.shade300,
                  3: Colors.green.shade500,
                  4: Colors.green.shade700,
                },
                onClick: (value) {
                  setState(() {
                    datasets[value] =
                        datasets[value] != null ? datasets[value]! + 1 : 1;
                  });
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
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
