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
}
