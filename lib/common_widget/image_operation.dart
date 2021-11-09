import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MyImage {
  // 画像をデバイスから取得
  final picker = ImagePicker();
  File? _image;
  late Function setstate;
  MyImage();
  //カメラ用
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setstate(() {});
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

//写真ライブラリの読み込み用
  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setstate(() {});
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  Widget imageAsset() {
    return Stack(children: [
      _image == null ? const Text('No image selected.') : Image.file(_image!),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            onPressed: getImageFromCamera,
            child: const Icon(Icons.add_a_photo),
          ),
          FloatingActionButton(
            onPressed: _getImage,
            child: const Icon(Icons.image),
          ),
        ],
      )
    ]);
  }

// 画像をリサイズ

// 画像をアップロード

}
