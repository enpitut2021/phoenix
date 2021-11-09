import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

// 画像をデバイスから取得
final picker = ImagePicker();
File? _image;
//カメラ用
Future getImageFromCamera() async {
  final pickedFile = await picker.getImage(source: ImageSource.camera);
  if (pickedFile != null) {
    _image = File(pickedFile.path);
  } else {
    print('No image selected.');
  }
}

//写真ライブラリの読み込み用
Future _getImage() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    _image = File(pickedFile.path);
  } else {
    print('No image selected.');
  }
}

Widget image_asset() {
  return Stack(children: [
    _image == null ? Text('No image selected.') : Image.file(_image!),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: getImageFromCamera,
          child: Icon(Icons.add_a_photo),
        ),
        FloatingActionButton(
          onPressed: _getImage,
          child: Icon(Icons.image),
        ),
      ],
    )
  ]);
}

// 画像をリサイズ


// 画像をアップロード
