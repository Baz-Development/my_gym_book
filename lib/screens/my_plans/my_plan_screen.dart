import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/events_model.dart';
import 'package:my_gym_book/common/models/history_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_history_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uuid/uuid.dart';

class MyPlansScreen extends StatefulWidget {
  const MyPlansScreen({super.key});

  @override
  _MyPlansScreenState createState() => _MyPlansScreenState();
}
class _MyPlansScreenState extends State<MyPlansScreen>{
  late final ValueNotifier<List<EventModel>> _selectedEvents;
  final HistoryRepository _historyRepository = HistoryRepository();
  final kToday = DateTime.now();
  late DateTime kFirstDay;
  late DateTime kLastDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pt_BR", null);
    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    verify();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<void> verify() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return;
    }
    var history = await _historyRepository.getMyHistories(email);
    if(history == null) {
      await createHistory();
    }
  }

  Future<void> createHistory() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if(email == null) {
      return;
    }
    var history = HistoryModel(
        userEmail: email,
        historyId: const Uuid().v4()
    );
    await _historyRepository.createHistory(history);
    FirebaseAnalyticsService.logEvent(
        "history_create_home",
        {}
    );
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return getKEvents()[day] ?? [];
  }

  LinkedHashMap getKEvents() {
    return LinkedHashMap<DateTime, List<EventModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )
      ..addAll(getKEventSource());
  }

  getKEventSource() {
    return {
      for (var item in List.generate(50, (index) => index)) DateTime.utc(
          kFirstDay.year, kFirstDay.month, item * 5): List.generate(
          item % 4 + 1, (index) =>
          EventModel(title: 'Event $item | ${index + 1}',
              exercises: []))
    }
      ..addAll({
        kToday: [
          EventModel(title: 'Today\'s Event 1',
              exercises: []),
          EventModel(title: 'Today\'s Event 2',
              exercises: []),
        ],
      });
    }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gym Book'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                debugPrint("add event");
              },
              icon: const Icon(
                  Icons.add
              )
          )
        ],
      ),
      body: Column(
        children: [
          buildTableCalendar(),
          const SizedBox(height: 8.0),
          buildEventList(),
        ],
      ),
    );
  }

  Expanded buildEventList() {
    return Expanded(
      child: ValueListenableBuilder<List<EventModel>>(
        valueListenable: _selectedEvents,
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () => debugPrint('${value[index]}'),
                  title: Text(
                    '${value[index]}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  TableCalendar<EventModel> buildTableCalendar() {
    return TableCalendar<EventModel>(
      locale: 'pt_BR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      eventLoader: _getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mês'
      },
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

}