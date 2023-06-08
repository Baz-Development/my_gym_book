import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<dynamic>> getEventsByEmailAndDate(String email, String date) async {
    // Obtém uma instância do Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Realiza uma consulta para obter o documento com o e-mail fornecido
    QuerySnapshot querySnapshot = await firestore
        .collection(_collectionPath)
        .where('Email', isEqualTo: email)
        .limit(1)
        .get();

    // Verifica se o resultado da consulta possui algum documento
    if (querySnapshot.docs.isNotEmpty) {
      // Obtém o primeiro documento retornado pela consulta
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;

      // Obtém o mapa de dados do documento
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // Obtém o campo "historyEvents"
      List<dynamic> historyEvents = data['historyEvents'];

      // Procura pelo objeto correspondente à data fornecida
      for (var event in historyEvents) {
        if (event['date'] == date) {
          // Retorna o campo "events" do objeto encontrado
          return event['events'];
        }
      }
    }

    // Caso não encontre um documento com o e-mail fornecido, não encontre um objeto
    // com a data especificada ou não haja eventos, retorna uma lista vazia
    return [];
  }
}
