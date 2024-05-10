# Flutter Vertical Heatmap

🐙 A vertical heatmap chart package for Flutter, offering beautifully crafted UI with ultimate flexibility!

![heatmap](https://github.com/woo3145/flutter_vertical_heatmap/assets/100907484/27755a7e-bdf0-4732-864f-d26aacd6dab9)

## Getting started

### Depend on it.

```
flutter pub add flutter_vertical_heatmap
```

**or**

Add below line to your personal package's `pubspec.yaml`.

```yaml
dependencies:
  flutter_vertical_heatmap: ^1.0.0
```

And run `flutter pub get` to install.

### Import it.

```dart
import 'package:flutter_vertical_heatmap/flutter_vertical_heatmap.dart';
```

## Usage

```dart
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
                  3: Colors.green.shade300,
                  5: Colors.green.shade500,
                  7: Colors.green.shade700,
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
```

## License

```text
MIT License

Copyright (c) 2024 Lee Chang Woo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
