import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyImage {
  final double image_width = 600;
  final double image_height = 450;
  final image_quality = 80;
  // 画像をデバイスから取得
  final picker = ImagePicker();
  File? _image;
  late Function setstate;
  MyImage();
  //カメラ用
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: image_quality,
      maxHeight: image_height,
      maxWidth: image_width,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // // flutter_image_compressで指定サイズ／品質に圧縮
      // List<int> result = await FlutterImageCompress.compressWithFile(
      //   _image?.absolute.path,
      //   minWidth: 1536,
      //   minHeight: 1536,
      //   quality: 80,
      // );
      setstate(() {});
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

//写真ライブラリの読み込み用
  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: image_quality,
      maxHeight: image_height,
      maxWidth: image_width,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // flutter_image_compressで指定サイズ／品質に圧縮
      // List<int> result = await FlutterImageCompress.compressWithFile(
      //   _image?.absolute.path,
      //   minWidth: 1536,
      //   minHeight: 1536,
      //   quality: 80,
      // );
      setstate(() {});
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  Widget imageAsset() {
    return Stack(children: [
      _image == null
          ? const Text('No image selected.')
          : Image.file(_image!, alignment: Alignment.center),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "add",
            onPressed: getImageFromCamera,
            child: const Icon(Icons.add_a_photo),
          ),
          FloatingActionButton(
            heroTag: "icon",
            onPressed: _getImage,
            child: const Icon(Icons.image),
          ),
        ],
      )
    ]);
  }

// 画像をアップロード
  String _image_url = ".jpeg";
  late Future<String> image_path;
  int _flag = 0;

  void upload(String filename) async {
    if (_flag == 0) {
      _image_url = filename + _image_url;
      _flag += 1;
    }
    // imagePickerで画像を選択する
    // upload
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref(_image_url).putFile(_image!);
      image_path = storage.ref(_image_url).getDownloadURL();
    } catch (e) {
      print(e);
    }
  }
}
