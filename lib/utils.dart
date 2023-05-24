// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:my_gym_book/common/models/events_model.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<EventModel>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => EventModel('Event $item | ${index + 1}')) }
  ..addAll({
    kToday: [
      const EventModel('Today\'s Event 1'),
      const EventModel('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
