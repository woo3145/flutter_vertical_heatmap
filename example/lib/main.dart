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
                // If you do not want to use a color tip, leave colorTipSize blank or pass null.
                colorTipSize: 20,
                margin: const EdgeInsets.all(3),
                colorsets: {
                  1: Colors.green.shade100,
                  3: Colors.green.shade300,
                  5: Colors.green.shade500,
                  7: Colors.green.shade700,
                },
                colorTipLabel: const ["1~3", "3~5", "5~7", "7+"],
                onClick: (value) {
                  setState(() {
                    datasets[value] =
                        datasets[value] != null ? datasets[value]! + 1 : 1;
                  });
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${value.toString()} - ${datasets[value]}'),
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
