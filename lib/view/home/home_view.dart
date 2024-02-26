// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/view/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => {
        model.loadCounter(),
      },
      builder: (context, model, child) {
        return Scaffold(
          body: GetMaterialApp(
            home: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                TextField(
                  controller: model.fullNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your full name',
                  ),
                ),
                TextField(
                  controller: model.contactController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your contact name',
                  ),
                ),
                TextField(
                  controller: model.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email name',
                  ),
                ),
                TextField(
                  controller: model.addressController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your address  name',
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () =>
                      model.handleCameraOrGalleryButtonTap(ImageSource.gallery),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.yellow,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    model.saveData();
                  },
                  child: const Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: () => model.handlePromoButtonTap(),
                  child: const Text('View resume template'),
                ),
                ElevatedButton(
                  onPressed: () => model.clearData(),
                  child: const Text('Clear Data'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
