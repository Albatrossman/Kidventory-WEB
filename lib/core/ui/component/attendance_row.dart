import 'package:flutter/cupertino.dart';
import 'package:kidventory_flutter/core/domain/model/attendance.dart';

class AttendanceRow extends StatelessWidget {
  final String name;
  final Attendance attendance;
  final Function(Attendance) onAttendanceChanged;

  const AttendanceRow({
    super.key,
    required this.name,
    required this.attendance,
    required this.onAttendanceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIconButton(
              Attendance.late,
              CupertinoIcons.clock,
              CupertinoIcons.clock_solid,
              attendance == Attendance.late,
              CupertinoColors.activeOrange,
            ),
            _buildIconButton(
              Attendance.absent,
              CupertinoIcons.xmark_circle,
              CupertinoIcons.xmark_circle_fill,
              attendance == Attendance.absent,
              CupertinoColors.destructiveRed,
            ),
            _buildIconButton(
              Attendance.present,
              CupertinoIcons.check_mark_circled,
              CupertinoIcons.check_mark_circled_solid,
              attendance == Attendance.present,
              CupertinoColors.activeGreen,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(
    Attendance type,
    IconData unselectedIcon,
    IconData selectedIcon,
    bool selected,
    Color color,
  ) {
    return CupertinoButton(
      onPressed: () => onAttendanceChanged(type),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Icon(
          key: ValueKey<bool>(selected),
          selected ? selectedIcon : unselectedIcon,
          color: selected ? color : null,
          size: 24,  // Optional: Adjust size to suit your UI design
        ),
      ),
    );
  }
}
