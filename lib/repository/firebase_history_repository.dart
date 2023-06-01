import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_gym_book/common/models/history_model.dart';

class HistoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'history';

  Future<void> createHistory(HistoryModel history) async {
    await _firestore.collection(_collectionPath).doc(history.userId).set(history.toJson());
  }

  Future<HistoryModel?> getMyHistories(String userId) async {
    final DocumentSnapshot doc = await _firestore.collection(_collectionPath).doc(userId).get();
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
}
