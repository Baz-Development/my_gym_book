import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/user_model.dart';

class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'groups';

  Future<void> createGroup(GroupModel group) async {
    await _firestore.collection(_collectionPath).doc(group.groupId).set(group.toJson());
  }

  Future<GroupModel?> getGroup(String groupId) async {
    final DocumentSnapshot doc =
    await _firestore.collection(_collectionPath).doc(groupId).get();
    if (doc.exists) {
      return GroupModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<GroupModel>> getAllGroups() async {
    final QuerySnapshot snapshot =
    await _firestore.collection(_collectionPath).get();
    return snapshot.docs
        .map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<GroupModel>> getMyGroups(UserModel user) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(_collectionPath)
        .where('users', arrayContains: user.toJson())
        .get();
    return snapshot.docs
        .map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateGroup(String groupId, GroupModel group) async {
    await _firestore
        .collection(_collectionPath)
        .doc(groupId)
        .update(group.toJson());
  }

  Future<void> deleteGroup(String groupId) async {
    await _firestore.collection(_collectionPath).doc(groupId).delete();
  }

  Future<void> addMember(String groupId, UserModel user) async {
    var group = await getGroup(groupId);
    if(group == null) {
      return;
    }
    group.users.add(user);
    updateGroup(groupId, group);
  }
}
