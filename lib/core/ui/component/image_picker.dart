import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class AppImagePicker extends StatefulWidget {
  final void Function(File) onImageSelected;
  final double width;
  final double height;

  const AppImagePicker({
    super.key,
    required this.onImageSelected,
    this.width = 56.0,
    this.height = 56.0,
  });

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
    return ClipOval(
      child: InkWell(
        onTap: _pickAndCropImage,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(96),
          ),
          child: _image == null
              ? Icon(
                  Icons.photo_size_select_actual,
                  size: widget.width / 3,
                  color: Colors.grey[400],
                )
              : FittedBox(
                  fit: BoxFit.cover,
                  child: Image.file(_image!),
                ),
        ),
      ),
    );
  }
}
