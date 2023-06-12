import 'dart:async';
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
  final HistoryRepository _historyRepository = HistoryRepository();
  final StreamController<List<EventModel>> _eventsStreamController = StreamController<List<EventModel>>();
  final kToday = DateTime.now();
  late DateTime kFirstDay;
  late DateTime kLastDay;
  List<EventModel> events = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() { //
    super.initState();
    initializeDateFormatting("pt_BR", null);
    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    _selectedDay = _focusedDay;
    verify();
    _getEvents();
  }

  @override
  void dispose() {
    _eventsStreamController.close();
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

  String formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> _getEvents() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if(email == null) {
      return;
    }
    var date = formatDateTime(_focusedDay);
    var eventsRes = await _historyRepository.getEventsByEmailAndDate(
        email,
        date
    );
    setState(() {
      events = eventsRes;
    });
    _eventsStreamController.add(events);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });
      _getEvents();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTableCalendar(),
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Eventos:",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 8.0),
          StreamBuilder<List<EventModel>>(
            stream: _eventsStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Sem dados disponiveis.'),
                );
              }
              events = snapshot.data!;
              return buildEventList(eventsData: events);
            },
          ),
        ],
      ),
    );
  }

  Widget buildEventList({required List<EventModel> eventsData}) {
    return Expanded(
      child: ListView.builder(
        itemCount: eventsData.length,
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
              onTap: () => debugPrint(eventsData[index].title),
              title: Text(
                eventsData[index].title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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
      eventLoader: (day) => [], // Fazer nova listagem de eventos por data
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mês'
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      onDaySelected: _onDaySelected,
    );
  }
}