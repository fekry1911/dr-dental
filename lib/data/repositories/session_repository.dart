
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/session_model.dart';

class SessionRepository {
  final CollectionReference sessionsRef = FirebaseFirestore.instance.collection('sessions');

  Future<List<SessionModel>> getSessions() async {
    final snapshot = await sessionsRef.get();
    return snapshot.docs.map((doc) => SessionModel.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
  }

  Future<void> addSession(SessionModel session) async {
    await sessionsRef.add(session.toJson());
  }

  Future<void> deleteSession(String id) async {
    await sessionsRef.doc(id).delete();
  }
}
