import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_gym_book/common/models/events_model.dart';
import 'package:my_gym_book/common/models/history_model.dart';

class HistoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'history';

  Future<void> createHistory(HistoryModel history) async {
    await _firestore.collection(_collectionPath).doc(history.userEmail).set(history.toJson());
  }

  Future<HistoryModel?> getMyHistories(String email) async {
    final DocumentSnapshot doc = await _firestore.collection(_collectionPath).doc(email).get();
    if (doc.exists) {
      return HistoryModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<HistoryModel>> getAllHistories() async {
    final QuerySnapshot snapshot = await _firestore.collection(_collectionPath).get();
    return snapshot.docs
        .map((doc) => HistoryModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateHistory(String historyId, HistoryModel history) async {
    await _firestore
        .collection(_collectionPath)
        .doc(historyId)
        .update(history.toJson());
  }

  Future<void> deleteHistory(String historyId) async {
    await _firestore.collection(_collectionPath).doc(historyId).delete();
  }

  Future<List<EventModel>> getEventsByEmailAndDate(String email, String date) async {
    // Obtém uma instância do Firestore
    var history = await getMyHistories(email);
    if(history == null) {
      return [];
    }
    for (var event in history.historyEvents) {
      if (event.date == date) {
        // Retorna o campo "events" do objeto encontrado
        return event.events;
      }
    }
    return [];
  }

  String formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> addEvent({required DateTime date, required EventModel event}) async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if(email == null) {
      return;
    }
    var history = await getMyHistories(email);
    if(history == null) {
      return;
    }

    try {
      var eventDate = history.historyEvents.singleWhere((element) => element.date == formatDateTime(date));
      eventDate.events.add(event);
    } catch (e) {
      var eventDate = EventDateModel(date: formatDateTime(date), events: [event]);
      history.historyEvents.add(eventDate);
    }

    // Save the updated history object
    await updateHistory(email, history);

  }
}
