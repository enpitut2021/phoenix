import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NewMyImage extends StatefulWidget {
  Function updateurl;
  double screensize;
  File? image;
  NewMyImage(this.updateurl, this.screensize, this.image);

  @override
  _NewMyImageState createState() => _NewMyImageState();
}

class _NewMyImageState extends State<NewMyImage> {
  final double imageWidth = 300;
  final double imageHeight = 200;
  final imageQuality = 30;

  final picker = ImagePicker();

  late Future<String> imagePath;

  Widget _displayImage(double screenSize) {
    Widget imageWidget;
    if (isImageEmpty()) {
      // ignore: sized_box_for_whitespace
      imageWidget = Container(
        child: const Center(child: Text('No image selected.')),
        width: screenSize,
        height: screenSize / 2,
        alignment: Alignment.center,
      );
    } else {
      imageWidget = Image.file(
        widget.image!,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        width: screenSize,
        height: screenSize / 2,
      );
    }
    return imageWidget;
  }

  bool isImageEmpty() {
    if (widget.image == null) {
      return true;
    } else {
      return false;
    }
  }

  //画像の切り抜き
  Future _cropImage(String imagePath) async {
    var cropImage = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
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
      widget.image = File(cropImage.path);
    } else {
      // ignore: avoid_print
      print('cannot select image');
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
      setState(() {
        if (widget.image != null) {
          widget.updateurl(url: pickedFile.path, image: widget.image);
        }
      });
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  //カメラ用
  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: imageHeight,
      maxWidth: imageWidth,
    );
    if (pickedFile != null) {
      await _cropImage(pickedFile.path);
      setState(() {
        widget.updateurl(url: pickedFile.path, image: widget.image);
      });
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _displayImage(widget.screensize),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "add",
            onPressed: _getImageFromCamera,
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
}
