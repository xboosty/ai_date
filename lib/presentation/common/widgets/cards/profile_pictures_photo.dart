import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePhoto extends StatefulWidget {
  const ProfilePicturePhoto({
    super.key,
    required this.width,
    required this.height,
    this.initialImageUrl,
    required this.imageUrl,
    required this.imageQuality,
    required this.maxHeight,
    required this.maxWidth,
    this.urlImgNetwork,
  });

  final double width;
  final double height;
  final String? urlImgNetwork;
  final File? initialImageUrl;
  final ValueChanged<File?> imageUrl;
  final int imageQuality;
  final double maxHeight;
  final double maxWidth;

  @override
  State<ProfilePicturePhoto> createState() => _ProfilePicturePhotoState();
}

class _ProfilePicturePhotoState extends State<ProfilePicturePhoto> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.initialImageUrl;
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
        widget.imageUrl(imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectFile(),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF0FB),
          borderRadius: BorderRadius.circular(5),
          image: (imageFile != null)
              ? DecorationImage(
                  image: FileImage(
                    File(imageFile!.path),
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => const AssetImage(
                    'assets/imgs/no-image.jpg',
                  ),
                )
              : widget.urlImgNetwork != null
                  ? DecorationImage(
                      image: NetworkImage(
                        widget.urlImgNetwork ?? '',
                      ),
                    )
                  : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: DottedBorder(
            color: const Color(0xFF9CA4BF),
            strokeWidth: 3,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      iconSize: 10,
                      padding: EdgeInsets.zero,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF6C2EBC),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
