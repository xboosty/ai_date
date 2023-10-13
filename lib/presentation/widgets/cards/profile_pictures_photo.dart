import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProfilePicturePhoto extends StatelessWidget {
  const ProfilePicturePhoto({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF0FB),
        borderRadius: BorderRadius.circular(15),
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
                //                   ElevatedButton(
                //   onPressed: (){},
                //   style: ButtonStyle(
                //     backgroundColor: ,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(radius),
                //     ),
                //   ),
                //   child: Text(
                //     text,
                //     style: TextStyle(color: Colors.white),
                //   ),
                // );
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.all(5.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Center(
                      child: const Icon(
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
    );
  }
}
