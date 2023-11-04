import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({
    super.key,
    required Size size,
    required this.imageUrl,
    this.initialImageUrl,
    required this.imageQuality,
    required this.maxHeight,
    required this.maxWidth,
  }) : _size = size;

  final Size _size;
  final String? initialImageUrl;
  final ValueChanged<File?>? imageUrl;
  final int imageQuality;
  final double maxHeight;
  final double maxWidth;

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> {
  File? imageFile;
  String? initialImg;

  @override
  void initState() {
    super.initState();
    initialImg = widget.initialImageUrl;
  }

  void _selectFile() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: widget.maxHeight,
      maxWidth: widget.maxWidth,
      imageQuality: widget.imageQuality,
    );

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
        widget.imageUrl!(imageFile);
        initialImg = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: widget._size.height * 0.25,
          width: widget._size.width * 0.50,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: widget._size.height * 0.25,
                  width: widget._size.width * 0.50,
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown.shade300,
                      image: (initialImg != null && imageFile == null)
                          ? DecorationImage(
                              image: NetworkImage(initialImg ?? ''),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) =>
                                  const AssetImage(
                                'assets/imgs/no-image.jpg',
                              ),
                            )
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: (initialImg == null ||
                            (!(initialImg?.contains('.jpg') ?? false) ||
                                !(initialImg?.contains('.png') ?? false)))
                        ? (imageFile != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ((imageFile?.path.contains('.jpg') ??
                                              false) ||
                                          (imageFile?.path.contains('.png') ??
                                              false))
                                      ? Image.file(
                                          File(imageFile!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(
                                          child: Text('Añadir Imagen'),
                                        ),
                                ),
                              )
                            : const Center(
                                child: Text('Añadir Imagen'),
                              )
                        : null,
                  ),
                ),
                Positioned(
                    top: 140,
                    left: 120,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FloatingActionButton(
                        onPressed: () => _selectFile(),
                        heroTag: 'image_product',
                        tooltip: 'Añadir Imagen',
                        child: const Icon(Icons.add),
                      ),
                    )
                    // CircleAvatar(
                    //   radius: _size.height * 0.025,
                    //   backgroundColor: Colors.blue,
                    //   child: Icon(FontAwesomeIcons.plus),
                    // ),
                    )
              ],
            ),
          ),
        ),
        SizedBox(height: widget._size.height * 0.04),
        (initialImg != null &&
                imageFile == null &&
                ((initialImg?.contains('.jpg') ?? false) ||
                    (initialImg?.contains('.png') ?? false)))
            ? Text(
                '${initialImg!.split('_').first.split('/').last}.${initialImg!.split('.').last}')
            : (imageFile != null &&
                    ((imageFile?.path.contains('.jpg') ?? false) ||
                        (imageFile?.path.contains('.png') ?? false)))
                ? Text(imageFile!.path.split('/').last)
                : const Text('Cargar Imagen')
      ],
    );
  }
}
