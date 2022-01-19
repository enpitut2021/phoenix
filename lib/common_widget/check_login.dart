import 'package:firebase_auth/firebase_auth.dart';

//when return true, user loged in.
Future<bool> checkLoginStatus() {
  final user = FirebaseAuth.instance.currentUser;
  return Future<bool>.value((user != null));
}
