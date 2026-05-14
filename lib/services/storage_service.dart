import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String userId, String documentId) async {
    final extension = p.extension(file.path);
    final ref = _storage.ref().child('users/$userId/documents/$documentId$extension');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteFile(String url) async {
    final ref = _storage.refFromURL(url);
    await ref.delete();
  }
}
