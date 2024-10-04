import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserDetailCalendarScreen extends StatefulWidget {
  const UserDetailCalendarScreen({Key? key}) : super(key: key);

  @override
  _UserDetailCalendarScreenState createState() =>
      _UserDetailCalendarScreenState();
}

class _UserDetailCalendarScreenState extends State<UserDetailCalendarScreen> {
  late MeetingDataSource _events;
  late List<Appointment> _shiftCollection;
  late List<CalendarResource> _employeeCalendarResource;
  late List<TimeRegion> _specialTimeRegions;

  @override
  void initState() {
    addResourceDetails();
    addAppointments();
    addSpecialRegions();
    _events = MeetingDataSource(_shiftCollection, _employeeCalendarResource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCalendar(
          view: CalendarView.timelineDay, // Gün olarak göster
          firstDayOfWeek: 1,
          timeSlotViewSettings:
              const TimeSlotViewSettings(startHour: 9, endHour: 18),
          dataSource: _events,
          specialRegions: _specialTimeRegions,
        ),
      ),
    );
  }

  void addAppointments() {
    var subjectCollection = [
      'John Dog',
      'Support',
      'Tiny running',
      'Care Day',
      'Tine Vet Day ',
      'Happy Hour'
    ];

    var colorCollection = [
      const Color(0xFF0F8644),
      const Color(0xFF8B1FA9),
      const Color(0xFFD20100),
      const Color(0xFFFC571D),
      const Color(0xFF85461E),
      const Color(0xFF3D4FB5),
      const Color(0xFFE47C73),
      const Color(0xFF636363)
    ];

    _shiftCollection = <Appointment>[];
    for (var calendarResource in _employeeCalendarResource) {
      var employeeIds = [calendarResource.id];

      for (int j = 0; j < 365; j++) {
        for (int k = 0; k < 2; k++) {
          final DateTime date = DateTime.now().add(Duration(days: j + k));
          int startHour = 9 + Random().nextInt(6);
          startHour =
              startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
              DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
            startTime: _shiftStartTime,
            endTime: _shiftStartTime.add(const Duration(hours: 1)),
            subject: subjectCollection[Random().nextInt(5)],
            color: colorCollection[Random().nextInt(7)],
            startTimeZone: '',
            endTimeZone: '',
            resourceIds: employeeIds,
          ));
        }
      }
    }
  }

  void addResourceDetails() {
    var nameCollection = [
      'John',
      'Bryan',
      'Robert',
      'Kenny',
      'Tia',
      'Theresa',
    ];

    var userImages = [
      'images/People_Circle5.png',
      'images/People_Circle8.png',
      'images/People_Circle18.png',
      'images/People_Circle23.png',
      'images/People_Circle25.png',
    ];

    _employeeCalendarResource = <CalendarResource>[];
    for (var i = 0; i < nameCollection.length; i++) {
      _employeeCalendarResource.add(CalendarResource(
        id: '000' + i.toString(),
        displayName: nameCollection[i],
        color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255), 1),
        image: i < userImages.length ? ExactAssetImage(userImages[i]) : null,
      ));
    }
  }

  void addSpecialRegions() {
    final DateTime date = DateTime.now();
    _specialTimeRegions = [
      TimeRegion(
        startTime: DateTime(date.year, date.month, date.day, 13, 0, 0),
        endTime: DateTime(date.year, date.month, date.day, 14, 0, 0),
        text: 'Lunch',
        resourceIds: _employeeCalendarResource.map((e) => e.id).toList(),
        recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
        enablePointerInteraction: false,
      )
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection,
      List<CalendarResource> employeeCalendarResource) {
    appointments = shiftCollection;
    resources = employeeCalendarResource;
  }
}
