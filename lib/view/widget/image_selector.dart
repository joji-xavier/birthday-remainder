// ignore_for_file: deprecated_member_use

import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageSelector extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ImageSelector(this.imagePick);
  final Function(File pickedImage) imagePick;
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  void filePicker() async {
    final _image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    final PickedImageFile = File(_image!.path);
    setState(() {
      pickedImage = PickedImageFile;
    });
    widget.imagePick(PickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: primaryClr,
          radius: 35,
          backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
        ),
        FlatButton.icon(
          onPressed: filePicker,
          icon: const Icon(Icons.image),
          label: const Text('Choose image'),
        ),
      ],
    );
  }
}
