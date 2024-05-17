import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';

class AppImagePicker extends StatefulWidget {
  final void Function(XFile) onImageSelected;
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
  XFile? _image;
  Uint8List? _imageBytes;

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
        uiSettings: [
          // ignore: use_build_context_synchronously
          WebUiSettings(context: context, enableZoom: true)
        ],
      );

      if (cropped != null) {
        _image = XFile(cropped.path);
        await _image!.readAsBytes().then((value) => {
              setState(() {
                _imageBytes = value;
              })
            });
        widget.onImageSelected(XFile(cropped.path));
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
                  child: Image.memory(_imageBytes!),
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

extension XFileAsync on XFile {
  Future<Uint8List> readAsBytesAsync() async {
    late Uint8List bytes;
    await readAsBytes().then((value) => {
      bytes = value
    });

    return bytes;
  }
}
