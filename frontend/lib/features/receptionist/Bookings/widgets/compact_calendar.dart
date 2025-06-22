// Alternative Compact Calendar for smaller spaces
import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class CompactCalendarWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;

  const CompactCalendarWidget({Key? key, this.initialDate, this.onDateSelected})
    : super(key: key);

  @override
  _CompactCalendarWidgetState createState() => _CompactCalendarWidgetState();
}

class _CompactCalendarWidgetState extends State<CompactCalendarWidget> {
  late DateTime currentDate;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.initialDate ?? DateTime.now();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300, minWidth: 250),
      decoration: BoxDecoration(
        color: AppColors.grey30,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCompactHeader(),
          SizedBox(height: 8),
          _buildCompactWeekDays(),
          SizedBox(height: 4),
          _buildCompactGrid(),
        ],
      ),
    );
  }

  Widget _buildCompactHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              currentDate = DateTime(currentDate.year, currentDate.month - 1);
            });
          },
          icon: Icon(Icons.chevron_left, color: Colors.white, size: 20),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 24, minHeight: 24),
        ),
        Text(
          _getMonthYearString(currentDate),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              currentDate = DateTime(currentDate.year, currentDate.month + 1);
            });
          },
          icon: Icon(Icons.chevron_right, color: Colors.white, size: 20),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 24, minHeight: 24),
        ),
      ],
    );
  }

  Widget _buildCompactWeekDays() {
    final weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Row(
      children:
          weekDays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCompactGrid() {
    return Column(children: _buildCompactWeeks());
  }

  List<Widget> _buildCompactWeeks() {
    List<Widget> weeks = [];
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime lastDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month + 1,
      0,
    );

    DateTime startDate = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    DateTime currentWeekStart = startDate;

    while (currentWeekStart.isBefore(lastDayOfMonth) ||
        currentWeekStart.month == currentDate.month) {
      weeks.add(_buildCompactWeekRow(currentWeekStart));
      currentWeekStart = currentWeekStart.add(Duration(days: 7));

      if (weeks.length >= 6) break;
    }

    return weeks;
  }

  Widget _buildCompactWeekRow(DateTime weekStart) {
    List<Widget> days = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = weekStart.add(Duration(days: i));
      days.add(_buildCompactDayCell(day));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Row(children: days),
    );
  }

  Widget _buildCompactDayCell(DateTime day) {
    bool isCurrentMonth = day.month == currentDate.month;
    bool isSelected =
        selectedDate != null &&
        day.year == selectedDate!.year &&
        day.month == selectedDate!.month &&
        day.day == selectedDate!.day;
    bool isToday =
        day.year == DateTime.now().year &&
        day.month == DateTime.now().month &&
        day.day == DateTime.now().day;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDate = day;
          });
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(day);
          }
        },
        child: Container(
          height: 28,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Colors.white
                    : isToday
                    ? Colors.white24
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color:
                    isSelected
                        ? Color(0xFF9CA3AF)
                        : isCurrentMonth
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
