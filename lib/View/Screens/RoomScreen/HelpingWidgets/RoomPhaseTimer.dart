import 'dart:async';
import 'package:flutter/material.dart';

class RoomPhaseTimer extends StatefulWidget {
  final DateTime createdAt;
  final int workDuration;
  final int breakDuration;
  final int totalSessions;

  const RoomPhaseTimer({
    Key? key,
    required this.createdAt,
    required this.workDuration,
    required this.breakDuration,
    required this.totalSessions,
  }) : super(key: key);

  @override
  State<RoomPhaseTimer> createState() => _RoomPhaseTimerState();
}

class _RoomPhaseTimerState extends State<RoomPhaseTimer> {
  Timer? _timer; // Changed to nullable
  late int elapsedMinutes;
  String currentPhase = "";
  int timeInPhase = 0;

  void updatePhase() {
    final now = DateTime.now();
    final elapsed = now.difference(widget.createdAt);
    elapsedMinutes = elapsed.inMinutes;

    final fullCycle = widget.workDuration + widget.breakDuration;
    final cyclesPassed = elapsedMinutes ~/ fullCycle;
    final remTime = elapsedMinutes % fullCycle;

    if (cyclesPassed >= widget.totalSessions) {
      setState(() {
        currentPhase = "Finished all sessions";
        timeInPhase = 0;
      });
      _timer?.cancel(); // Safely cancel the timer if it exists
      return;
    }

    if (remTime < widget.workDuration) {
      setState(() {
        currentPhase = "Work";
        timeInPhase = remTime;
      });
    } else {
      setState(() {
        currentPhase = "Break";
        timeInPhase = remTime - widget.workDuration;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updatePhase();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updatePhase();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Safely cancel the timer if it exists
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Current Phase: $currentPhase"),
        Text("Minutes in Current Phase: $timeInPhase"),
        Text("Elapsed Time: $elapsedMinutes minutes"),
      ],
    );
  }
}
