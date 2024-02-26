import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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

  void handlePromoButtonTap() {
    if (basicDetails == null) return;
    Get.to(() => ResumeTemplateView(basicDetails: basicDetails!));
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
