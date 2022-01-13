import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/alert_action.dart';

class LoginVC extends StatelessWidget {
  const LoginVC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン画面'),
      ),
      body: const LoginBodyVC(),
    );
  }

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class LoginBodyVC extends StatefulWidget {
  const LoginBodyVC({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBodyVC> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(labelText: "メールアドレス"),
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: "パスワード"),
          obscureText: true,
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
        Container(
          width: double.infinity,
          color: Colors.orange.shade100,
          child: ElevatedButton(
            child: const Text("新規登録"),
            onPressed: () async {
              if (password.length < 8) {
                ErrorAction.errorMessage(context, "パスワードを8文字以上で入力してくだい");
              } else {
                await _register(email: email, password: password)
                    .then((user) async {
                  if (user != null) {
                    await ButtonAction.buttonPressed(context, "表示する名前を決めてください")
                        .then((displayname) async {
                      await user.updateDisplayName(displayname);
                    });

                    Navigator.of(context)
                        .pop(FirebaseAuth.instance.currentUser!.displayName);
                  } else {
                    ErrorAction.errorMessage(context, "登録に失敗しました。");
                  }
                });
              }
            },
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.orange.shade100,
          child: ElevatedButton(
            child: const Text("ログイン"),
            onPressed: () async {
              await _login(email: email, password: password).then((user) {
                if (user != null) {
                  Navigator.of(context).pop(user.displayName!);
                } else {
                  ErrorAction.errorMessage(context, "ログインに失敗しました。");
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

Future<User?> _login({required String email, required String password}) async {
  final auth = FirebaseAuth.instance;
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  } catch (e) {}
  return Future<User?>.value(auth.currentUser);
}

Future<User?> _register(
    {required String email, required String password}) async {
  final auth = FirebaseAuth.instance;
  try {
    final auth = FirebaseAuth.instance;
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return Future<User?>.value(result.user);
  } catch (e) {
    auth.signOut();
  }

  return Future<User?>.value(auth.currentUser);
}
