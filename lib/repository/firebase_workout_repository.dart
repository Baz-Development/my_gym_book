import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';

class WorkoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'workout';

  Future<void> createWorkout(WorkoutModel workout) async {
    await _firestore.collection(_collectionPath).doc(workout.workoutId).set(workout.toJson());
  }

  Future<WorkoutModel?> getWorkout(String workoutId) async {
    final DocumentSnapshot doc = await _firestore.collection(_collectionPath).doc(workoutId).get();
    if (doc.exists) {
      return WorkoutModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<WorkoutModel>> getAllWorkouts() async {
    final QuerySnapshot snapshot = await _firestore.collection(_collectionPath).get();
    return snapshot.docs
        .map((doc) => WorkoutModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateWorkout(String workoutId, WorkoutModel workout) async {
    await _firestore
        .collection(_collectionPath)
        .doc(workoutId)
        .update(workout.toJson());
  }

  Future<void> deleteWorkout(String workoutId) async {
    await _firestore.collection(_collectionPath).doc(workoutId).delete();
  }

  Future<List<WorkoutModel>> getWorkoutsByIds(List<String> workoutIds) async {
    final List<WorkoutModel> workouts = [];

    for (String workoutId in workoutIds) {
      final WorkoutModel? workout = await getWorkout(workoutId);
      if (workout != null) {
        workouts.add(workout);
      }
    }

    return workouts;
  }

  Future<List<WorkoutModel>> getItemsExcept(List<String> excludedDocuments) async {
    List<WorkoutModel> items = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(_collectionPath).get();

    for (var doc in querySnapshot.docs) {
      if (!excludedDocuments.contains(doc.id)) {
        items.add(WorkoutModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }
    return items;
  }
}
