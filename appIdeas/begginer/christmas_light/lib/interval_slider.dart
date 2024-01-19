import 'package:flutter/material.dart';

class IntervalSlider extends StatelessWidget {
  const IntervalSlider({
    super.key,
    required this.interval,
    required this.onChanged,
  });

  final int interval;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      width: 400,
      child: Column(
        children: [
          const Text(
            'Interval',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: interval.toDouble(),
            max: 1500,
            min: 500,
            divisions: 10,
            label: interval.toString(),
            onChanged: (value) {
              onChanged(value.toInt());
            },
          ),
        ],
      ),
    );
  }
}
