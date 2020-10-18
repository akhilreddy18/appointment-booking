import 'package:flutter/material.dart';
import 'package:maniva/components/app_drawer.dart';
import 'package:maniva/screens/appointments/confirm_slot.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalender extends StatefulWidget {
    static const String routeName = 'event-calender';
  @override
  _EventCalenderState createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    int day = calendarTapDetails.date.weekday;
    if (!(day == 7 || day == 6)) {
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              AppointmentEditor(calendarTapDetails.date),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book time"),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 0, bottom: 50),
        child: SfCalendar(
          onTap: onCalendarTapped,
          showNavigationArrow: true,
          monthViewSettings: MonthViewSettings(numberOfWeeksInView: 6),
          view: CalendarView.month,
        ),
      ),
    );
  }
}
