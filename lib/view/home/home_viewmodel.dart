import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/view/resume_template/resume_template_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String name = '';
  BasicDetails? basicDetails;

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    basicDetails = BasicDetails(
      name: fullNameController.text,
      email: emailController.text,
      phone: contactController.text,
      address: addressController.text,
    );

    String data = jsonEncode(basicDetails?.toMap());

    prefs.setString('name', data);

    notifyListeners();
  }

  Future<void> loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = (prefs.getString('name') ?? '');

    if (name.isNotEmpty) {
      basicDetails = BasicDetails.fromMap(jsonDecode(name));

      if (basicDetails != null) {
        fullNameController.text = basicDetails!.name;
        emailController.text = basicDetails!.email;
        contactController.text = basicDetails!.phone;
        addressController.text = basicDetails!.address;
      }
    }

    notifyListeners();
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fullNameController.clear();
    emailController.clear();
    contactController.clear();
    addressController.clear();

    basicDetails = null;

    prefs.remove('name');
    notifyListeners();
  }

  void handlePromoButtonTap() {
    if (basicDetails == null) return;
    Get.to(() => ResumeTemplateView(basicDetails: basicDetails!));
  }

  Future handleCameraOrGalleryButtonTap(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      print('hello');
      if (image == null) return;
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 8.5, ratioY: 5.5),
      );

      if (croppedImage == null) return;

      File imageFile = File.fromUri(Uri.file(croppedImage.path));
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.message}');
    }
  }
}

class BasicDetails {
  String name;
  String email;
  String phone;
  String address;

  BasicDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory BasicDetails.fromMap(Map<String, dynamic> map) {
    return BasicDetails(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
