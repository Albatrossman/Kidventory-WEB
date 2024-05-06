import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

class WeekdayPicker extends StatefulWidget {
  final List<WeekDay> initialSelectedDays;
  final Function(List<WeekDay>) onSelectionChanged;

  const WeekdayPicker({
    super.key,
    required this.initialSelectedDays,
    required this.onSelectionChanged,
  });

  @override
  State<WeekdayPicker> createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  late List<WeekDay> _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = List.from(widget.initialSelectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.spaceEvenly,
        runAlignment: WrapAlignment.center,
        children: WeekDay.values.map((weekday) {
          bool isSelected = _selectedDays.contains(weekday);
          return GestureDetector(
            onTap: () => _onClick(weekday),
            child: Transform.scale(
              scale: isSelected ? 1.25 : 1.0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  weekday.label.substring(0, 3),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _onClick(WeekDay weekday) {
    setState(() {
      if (_selectedDays.contains(weekday)) {
        _selectedDays.remove(weekday);
      } else {
        _selectedDays.add(weekday);
      }
    });
    widget.onSelectionChanged(_selectedDays);
  }
}
