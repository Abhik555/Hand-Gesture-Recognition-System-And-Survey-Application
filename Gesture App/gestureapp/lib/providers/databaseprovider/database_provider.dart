import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
class DatabaseProvider extends _$DatabaseProvider {
  @override
  FirebaseFirestore build() {
    return FirebaseFirestore.instance;
  }

  Future<FirebaseFirestore> get() async {
    return state;
  }
}
