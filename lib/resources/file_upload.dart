import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileStoreMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String applicationType = '';
  SettableMetadata? metadata;

  Future<String> uploadFile(
    File file,
    String mainFolderName,
    String caseName,
    String fileid,
  ) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(mainFolderName)
        .child(FirebaseAuth.instance.currentUser!.displayName!)
        .child(caseName)
        .child(fileid);

    String fileExtension = file.path.split('.').last.toLowerCase();

    if (fileExtension == 'pdf') {
      metadata = SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {
          'description': 'Files',
          'file_id': fileid,
        },
        contentEncoding: 'utf-8',
        cacheControl: 'no-cache',
        contentLanguage: 'en',
        contentDisposition: 'inline',
      );
    } else if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
      metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'description': 'Photo',
          'file_id': fileid,
        },
      );
    } else if (fileExtension == 'png') {
      metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {
          'description': 'Photo',
          'file_id': fileid,
        },
      );
    } else if (fileExtension == 'heic') {
      metadata = SettableMetadata(
        contentType: 'image/heic',
        customMetadata: {
          'description': 'Photo',
          'file_id': fileid,
        },
      );
    } else if (fileExtension == 'mp4') {
      metadata = SettableMetadata(
        contentType: 'vfile_ideo/mp4',
        customMetadata: {
          'description': 'Vfile_ideo',
          'file_id': fileid,
        },
      );
    } else if (fileExtension == 'mp3') {
      metadata = SettableMetadata(
        contentType: 'audio/mpeg',
        customMetadata: {
          'description': 'Audio',
          'file_id': fileid,
        },
      );
    } else {
      // Handle other media types as needed
    }
    UploadTask uploadTask = ref.putFile(file, metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<String> fileUpload(
    File file,
    String mainFolderName,
    String caseName,
    String fileid,
    String caseNo,
  ) async {
    String res = "Some Error Occured";
    try {
      String url = await uploadFile(file, mainFolderName, caseName, fileid);
      DocumentReference userDoc;

      userDoc = FirebaseFirestore.instance.collection('files').doc(fileid);

      String fileName = file.path.split('/').last;
      String fileExtension = file.path.split('.').last.toLowerCase();

      if (fileExtension == 'pdf') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      } else if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      } else if (fileExtension == 'png') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      } else if (fileExtension == 'heic') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      }
      if (fileExtension == 'mp4') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      } else if (fileExtension == 'mp3') {
        await userDoc.set({
          'fileName': fileName,
          'file_url': url,
          'file_id': fileid,
          'lawyer_uid': FirebaseAuth.instance.currentUser!.uid,
          'caseNo': caseNo,
        });
      } else {
        // Handle other media types as needed
      }
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
