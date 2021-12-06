import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';

class MyImage {
  final double imageWidth = 300;
  final double imageHeight = 200;
  final imageQuality = 30;
  // 画像をデバイスから取得
  final picker = ImagePicker();
  File? _image;
  late Function setstate;
  MyImage();
  //カメラ用
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: imageHeight,
      maxWidth: imageWidth,
    );
    if (pickedFile != null) {
      await _cropImage(pickedFile.path);
      //  _image = File(pickedFile.path);
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

  bool isImageEmpty() {
    if (_image == null) {
      return true;
    } else {
      return false;
    }
  }

//写真ライブラリの読み込み用
  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
      maxHeight: imageHeight,
      maxWidth: imageWidth,
    );

    if (pickedFile != null) {
      await _cropImage(pickedFile.path);
      // _image = File(pickedFile.path);
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

  Widget imageAsset(Size screenSize) {
    return Stack(children: [
      _displayImage(screenSize),
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

  Widget _displayImage(Size screenSize) {
    Widget imageWidget;
    if (isImageEmpty()) {
      // ignore: sized_box_for_whitespace
      imageWidget = Container(
        child: const Center(child: Text('No image selected.')),
        width: screenSize.width,
        height: screenSize.width / 2,
        alignment: Alignment.center,
      );
    } else {
      imageWidget = SizedBox(
        child: Image.file(_image!,
            alignment: Alignment.center, fit: BoxFit.contain),
        width: screenSize.width,
        height: screenSize.width / 2,
      );
    }
    return imageWidget;
  }

// 画像をアップロード
  String _imageUrl = ".jpeg";
  late Future<String> imagePath;
  int _flag = 0;

  Future<String> upload(String filename) async {
    if (_flag == 0) {
      _imageUrl = filename + _imageUrl;
      _flag += 1;
    }
    // imagePickerで画像を選択する
    // upload
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref(_imageUrl).putFile(_image!);
      imagePath = storage.ref(_imageUrl).getDownloadURL();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return Future<String>.value(imagePath);
  }

  //画像の切り抜き
  Future _cropImage(String imagePath) async {
    var cropImage = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [CropAspectRatioPreset.ratio3x2],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.orange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 0.6,
      ),
    );

    if (cropImage != null) {
      _image = File(cropImage.path);
    } else {
      // ignore: avoid_print
      print('cannot select image');
    }
  }
}
