import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';

class AppImagePicker extends StatefulWidget {
  final void Function(File) onImageSelected;
  final double width;
  final double height;
  final String currentImage;

  const AppImagePicker(
      {super.key,
      required this.onImageSelected,
      this.width = 56.0,
      this.height = 56.0,
      this.currentImage = ""});

  @override
  State<AppImagePicker> createState() {
    return _AppImagePickerState();
  }
}

class _AppImagePickerState extends State<AppImagePicker> {
  late ImagePicker _picker;
  File? _image;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  Future<void> _pickAndCropImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxHeight: 400,
        maxWidth: 400,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );

      if (cropped != null) {
        setState(() {
          _image = File(cropped.path);
        });
        widget.onImageSelected(File(cropped.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: _pickAndCropImage,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(96),
        ),
        child: _image == null
            ? _placeholder(context)
            : ClipOval(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.file(_image!),
                ),
              ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return widget.currentImage.isEmpty
        ? Icon(
            CupertinoIcons.photo_fill,
            size: widget.width / 3,
            color: Colors.grey[400],
          )
        : ClipOval(
            child: FittedBox(
              fit: BoxFit.cover,
              child: CachedNetworkImage(
                imageUrl: widget.currentImage,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            ),
          );
  }
}
