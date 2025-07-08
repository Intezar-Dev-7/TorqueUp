
import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class CustomCalendarWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final Color? primaryColor;
  final Color? backgroundColor;

  const CustomCalendarWidget({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.primaryColor,
    this.backgroundColor,
  });

  @override
  _CustomCalendarWidgetState createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
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
      constraints: BoxConstraints(
        maxWidth: 400,
        minWidth: 300,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey30,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildWeekDays(),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousMonth,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Text(
            _getMonthYearString(currentDate),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    final weekDays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: weekDays.map((day) {
          return Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: _buildWeeks(),
      ),
    );
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = [];
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    // Calculate start date (first Sunday of the calendar)
    DateTime startDate = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    DateTime currentWeekStart = startDate;

    while (currentWeekStart.isBefore(lastDayOfMonth) ||
        currentWeekStart.month == currentDate.month) {
      weeks.add(_buildWeekRow(currentWeekStart));
      currentWeekStart = currentWeekStart.add(Duration(days: 7));

      // Break if we've shown enough weeks
      if (weeks.length >= 6) break;
    }

    return weeks;
  }

  Widget _buildWeekRow(DateTime weekStart) {
    List<Widget> days = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = weekStart.add(Duration(days: i));
      days.add(_buildDayCell(day));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: days,
      ),
    );
  }

  Widget _buildDayCell(DateTime day) {
    bool isCurrentMonth = day.month == currentDate.month;
    bool isSelected = selectedDate != null &&
        day.year == selectedDate!.year &&
        day.month == selectedDate!.month &&
        day.day == selectedDate!.day;
    bool isToday = day.year == DateTime.now().year &&
        day.month == DateTime.now().month &&
        day.day == DateTime.now().day;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onDaySelected(day),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white
                : isToday
                ? Colors.white24
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.black
                    : isCurrentMonth
                    ? Colors.black
                    : Colors.white.withOpacity(0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      selectedDate = day;
    });

    if (widget.onDateSelected != null) {
      widget.onDateSelected!(day);
    }
  }

  void _previousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    });
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
