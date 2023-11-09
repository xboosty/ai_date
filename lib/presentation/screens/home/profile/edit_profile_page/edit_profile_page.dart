import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        Genders,
        HandlerNotification,
        NtsErrorResponse,
        Sexuality,
        SharedPref,
        Strings,
        UserEntity,
        UserRegisterStatus,
        convertFileListToMultipartFileList,
        getIt;
import '../../../../common/widgets/widgets.dart'
    show CustomAlertDialog, FilledColorizedButton, ProfilePicturePhoto;
import 'widgets/card_gender_info.dart';
import 'widgets/card_personal_info.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final _notifications = getIt<HandlerNotification>();
  File? imageUrlSelectedOne;
  File? imageUrlSelectedTwo;
  File? imageUrlSelectedThree;
  File? imageUrlSelectedFour;
  File? imageUrlSelectedFive;
  File? imageUrlSelectedSix;

  // Secondary Image Network
  String? imageNetworkUrlOne;
  String? imageNetworkUrlTwo;
  String? imageNetworkUrlThree;
  String? imageNetworkUrlFour;
  String? imageNetworkUrlFive;
  String? imageNetworkUrlSix;

  UserEntity? user;

  late Genders genderSelected;
  late Sexuality sexualitySelected;
  bool showGenderProfile = false;
  bool showSexualityProfile = false;

  final List<Genders> _genders = const [
    Genders(id: 1, name: 'Female'),
    Genders(id: 0, name: 'Male'),
    Genders(id: 3, name: 'Non Binary'),
  ];

  final List<Sexuality> _sexualities = const [
    Sexuality(id: 4, name: 'Prefer not to say'),
    Sexuality(id: 0, name: 'Hetero'),
    Sexuality(id: 1, name: 'Bisexual'),
    Sexuality(id: 2, name: 'Homosexual'),
    Sexuality(id: 3, name: 'Transexual'),
  ];

  String? _validateDate(String value) {
    if (value.isEmpty) {
      return 'The date of birth cannot be empty';
    }
    return null;
  }

  Future<void> _handleSaveChanges({required Size size}) async {
    List<File?> pictures = [
      imageUrlSelectedOne,
      imageUrlSelectedTwo,
      imageUrlSelectedThree,
      imageUrlSelectedFour,
      imageUrlSelectedFive,
      imageUrlSelectedSix
    ];

    List<MultipartFile> itemsImg =
        await convertFileListToMultipartFileList(pictures);

    final formData = FormData.fromMap({
      "BirthDate": DateFormat.yMd().parse(dateCtrl.text).toIso8601String(),
      "FullName": nameCtrl.text,
      "GenderId": genderSelected.id,
      "Gender": genderSelected.name,
      "SexualOrientation": sexualitySelected.name,
      "IsGenderVisible": showGenderProfile,
      "IsSexualityVisible": showSexualityProfile,
      "files": itemsImg
    });
    try {
      if (!mounted) return;
      await context.read<AccountCubit>().editAccount(formData);
      if (!mounted) return;
      await _notifications.ntsSuccessNotification(
        context,
        message: 'Profile updated successfully',
        height: size.height * 0.12,
        width: size.width * 0.90,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (e is NtsErrorResponse) {
        if (!mounted) return;
        await _notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: size.height * 0.15,
          width: size.width * 0.90,
        );
      }

      if (!mounted) return;
      if (e is DioException) {
        await _notifications.ntsErrorNotification(
          context,
          message: 'Sorry. Something went wrong. Please try again later',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> userMap = jsonDecode(SharedPref.pref.account);
      user = UserEntity.fromJson(userMap);
      nameCtrl.text = user?.name ?? '';
      lastNameCtrl.text = '';
      emailCtrl.text = user?.email ?? '';
      dateCtrl.text =
          DateFormat.yMd().format(user?.birthDate ?? DateTime.now());
      // '${user?.birthDate.year}-${user?.birthDate.month}-${user?.birthDate.day}';
      showGenderProfile = user?.isGenderVisible ?? false;
      showSexualityProfile = user?.isSexualityVisible ?? false;
      switch (user?.genderId) {
        case 0:
          genderSelected = _genders[1];
          break;
        case 1:
          genderSelected = _genders[0];
          break;
        default:
          genderSelected = _genders[2];
      }
      switch (user?.sexualityId) {
        case 0:
          sexualitySelected = _sexualities[1];
          break;
        case 1:
          sexualitySelected = _sexualities[2];
          break;
        case 2:
          sexualitySelected = _sexualities[3];
          break;
        case 3:
          sexualitySelected = _sexualities[0];
          break;
        default:
          sexualitySelected = _sexualities[0];
      }
      // imageNetworkUrlOne = lookupMimeType(user?.pictures[0] ?? '');
      // imageNetworkUrlTwo = base64Decode(user?.pictures[1] ?? '').toString();
      // imageNetworkUrlThree = base64Decode(user?.pictures[2] ?? '').toString();
      // imageNetworkUrlFour = base64.decode(user?.pictures[3] ?? '').toString();
      // imageNetworkUrlFive = base64.decode(user?.pictures[4] ?? '').toString();
      // imageNetworkUrlSix = base64.decode(user?.pictures[5] ?? '').toString();
    } catch (e) {
      print('Ocurrio un error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardPersonalInfo(
              size: size,
              initialDate: user?.birthDate ?? DateTime.now(),
              dateCtrl: dateCtrl,
              nameCtrl: nameCtrl,
              lastNameCtrl: lastNameCtrl,
              emailCtrl: emailCtrl,
              onDateSelected: (date) {
                dateCtrl.text = date.toIso8601String();
              },
              validator: (value) => _validateDate(value ?? ''),
            ),
            CardGenderInfo(
              itemsGender:
                  _genders.map<DropdownMenuItem<Genders>>((Genders item) {
                return DropdownMenuItem<Genders>(
                  alignment: Alignment.centerLeft,
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              itemsSexuality: _sexualities
                  .map<DropdownMenuItem<Sexuality>>((Sexuality item) {
                return DropdownMenuItem<Sexuality>(
                  alignment: Alignment.centerLeft,
                  value: item,
                  child: Text(item.name),
                );
              }).toList(),
              genderSelected: genderSelected,
              sexualitySelected: sexualitySelected,
              showGenderProfile: showGenderProfile,
              showSexualityProfile: showSexualityProfile,
              onChangedGender: (Genders? value) {
                setState(() {
                  genderSelected = value ?? _genders[2];
                });
              },
              onChangedSexuality: (Sexuality? value) {
                setState(() {
                  sexualitySelected = value ?? _sexualities[0];
                });
              },
              onShowGender: (value) {
                setState(() {
                  showGenderProfile = value ?? false;
                });
              },
              onShowSexuality: (value) {
                setState(() {
                  showSexualityProfile = value ?? false;
                });
              },
            ),
            const ListTile(
              leading: Icon(Icons.add_photo_alternate_outlined, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              title: Text(
                'PROFILE PICTURES',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Users who have uploaded 2 or more pictures have a higher likelihood of finding matches.',
                style: TextStyle(
                  color: Color(0xFF9CA4BF),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicturePhoto(
                        width: size.width * 0.50,
                        height: size.height * 0.31,
                        imageQuality: 100,
                        maxHeight: 720,
                        maxWidth: 480,
                        urlImgNetwork: null,
                        initialImageUrl: imageUrlSelectedOne,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedOne = value;
                          });
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePicturePhoto(
                            width: size.width * 0.25,
                            height: size.height * 0.15,
                            imageQuality: 100,
                            maxHeight: 480,
                            maxWidth: 480,
                            urlImgNetwork: imageNetworkUrlTwo,
                            initialImageUrl: imageUrlSelectedTwo,
                            imageUrl: (File? value) {
                              setState(() {
                                imageUrlSelectedTwo = value;
                              });
                            },
                          ),
                          const SizedBox(height: 5.0),
                          ProfilePicturePhoto(
                            width: size.width * 0.25,
                            height: size.height * 0.15,
                            imageQuality: 100,
                            maxHeight: 480,
                            maxWidth: 480,
                            urlImgNetwork: imageNetworkUrlThree,
                            initialImageUrl: imageUrlSelectedThree,
                            imageUrl: (File? value) {
                              setState(() {
                                imageUrlSelectedThree = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicturePhoto(
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                        imageQuality: 100,
                        maxHeight: 480,
                        maxWidth: 480,
                        urlImgNetwork: imageNetworkUrlFour,
                        initialImageUrl: imageUrlSelectedFour,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedFour = value;
                          });
                        },
                      ),
                      ProfilePicturePhoto(
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                        imageQuality: 100,
                        maxHeight: 480,
                        maxWidth: 480,
                        urlImgNetwork: imageNetworkUrlFive,
                        initialImageUrl: imageUrlSelectedFive,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedFive = value;
                          });
                        },
                      ),
                      ProfilePicturePhoto(
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                        imageQuality: 100,
                        maxHeight: 480,
                        maxWidth: 480,
                        urlImgNetwork: imageNetworkUrlSix,
                        initialImageUrl: imageUrlSelectedSix,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedSix = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
            FilledColorizedButton(
              width: size.width,
              height: 50,
              title: 'SAVE CHANGES',
              isTrailingIcon: false,
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, save the form and perform an action.
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) => switch (state.status) {
                        UserRegisterStatus.initial => CustomAlertDialog(
                            title: 'Save Changes',
                            content:
                                'Are you sure you want to save the changes?',
                            onPressedCancel: () => Navigator.of(context).pop(),
                            onPressedOk: () {
                              _handleSaveChanges(size: size);
                            }),
                        UserRegisterStatus.loading => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        UserRegisterStatus.failure => CustomAlertDialog(
                            title: 'Save Changes',
                            content:
                                'Are you sure you want to save the changes?',
                            onPressedCancel: () => Navigator.of(context).pop(),
                            onPressedOk: () {
                              _handleSaveChanges(size: size);
                            }),
                        UserRegisterStatus.loading => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        UserRegisterStatus.success => Container(),
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
