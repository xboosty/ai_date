import 'package:flutter/material.dart';

import '../../../../../../config/config.dart' show Genders, Sexuality, Strings;
import '../../../../../common/widgets/widgets.dart' show CustomDropdownButton;

class CardGenderInfo extends StatelessWidget {
  const CardGenderInfo({
    super.key,
    required this.itemsGender,
    required this.itemsSexuality,
    required this.genderSelected,
    required this.sexualitySelected,
    required this.onChangedGender,
    required this.onChangedSexuality,
    required this.onShowGender,
    required this.onShowSexuality,
    this.showGenderProfile,
    this.showSexualityProfile,
  });

  final Genders genderSelected;
  final Sexuality sexualitySelected;

  final List<DropdownMenuItem<Genders>> itemsGender;
  final List<DropdownMenuItem<Sexuality>> itemsSexuality;
  final ValueChanged<Genders?> onChangedGender;
  final ValueChanged<Sexuality?> onChangedSexuality;
  final bool? showGenderProfile;
  final bool? showSexualityProfile;
  final ValueChanged<bool?> onShowGender;
  final ValueChanged<bool?> onShowSexuality;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.90,
        height: size.height * 0.38,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF0FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            CustomDropdownButton<Genders>(
              hintText: const Text('Gender'),
              items: itemsGender,
              dropdownValue: genderSelected,
              onChanged: onChangedGender,
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Show my gender in my profile',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: showGenderProfile,
              onChanged: onShowGender,
            ),
            CustomDropdownButton<Sexuality>(
              hintText: const Text('Sexual Orientation'),
              items: itemsSexuality,
              dropdownValue: sexualitySelected,
              onChanged: onChangedSexuality,
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Show my sexuality in my profile',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: showSexualityProfile,
              onChanged: onShowSexuality,
            )
          ],
        ),
      ),
    );
  }
}
