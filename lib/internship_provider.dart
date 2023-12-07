import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InternShipProvider extends ChangeNotifier {
  //  INTERNSHIP FORM

  File? _chosenfile;
  File? get chosenfile => _chosenfile;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _chosenfile = File(result.files.single.path!);
      notifyListeners();
    } else {
      log('No file picked');
    }
  }

  emptyFile() {
    _chosenfile = null;
    notifyListeners();
  }

  uploadFile(
      String name,
      String lastname,
      String preferedName,
      String regNum,
      String departmentName,
      String fileofstudy,
      String cgpa,
      String promoCode,
      String permanentAddress,
      String experience) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('internship-docs')
        .child('${FirebaseAuth.instance.currentUser!.uid}resume');
    final taskSnapshot = await ref.putFile(_chosenfile!);
    try {
      final url = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('internship')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'resume': url,
        'name': name,
        'last name': lastname,
        'preffered name': preferedName,
        'reg num': regNum,
        'department': departmentName,
        'file of study': fileofstudy,
        'cgpa': cgpa,
        'promo code': promoCode,
        'permanent address': permanentAddress,
        'experience': experience,
      }).then((value) {
        emptyFile();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //  PROFILE UPLOAD

  final ImagePicker _picker = ImagePicker();

  File? _profile;
  File? get profile => _profile;

  Future<void> uploadImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      _profile = File(image.path);
      notifyListeners();
      uploadProfile();
    } else {
      log('No file picked');
    }
  }

  uploadProfile() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(FirebaseAuth.instance.currentUser!.uid);
    try {
      await ref.putFile(_profile!).then((p0) {});

      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profile': url}).then((value) {
        print('image uploaded successfully');
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
