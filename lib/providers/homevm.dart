import 'dart:io';

import 'package:assesment_project/utils/generalutils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Homevm with ChangeNotifier {
  final titlecontroller = TextEditingController();
  double uploadProgress = 0.0;
  bool filechosen = false;

  Future pickVideoFromGallery() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  Future<void> uploadVideoToFirebase(File videoFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child('videos/$fileName.mp4');

      final uploadTask = storageRef.putFile(videoFile);
      filechosen = true;
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        notifyListeners();
      });

      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      final db = await FirebaseFirestore.instance.collection('videos').doc().set({
        "url": downloadUrl,
        "timestamp": FieldValue.serverTimestamp(),
        "video title": titlecontroller.text.toString(),
      });
      uploadProgress = 0.0;
      filechosen = false;
      titlecontroller.clear();
      notifyListeners();

      print('✅ Video uploaded: $downloadUrl');
    } catch (e) {
      print('❌ Error uploading video: $e');
    }
  }

  Future pickAndUploadVideo(context) async {
    final file = await pickVideoFromGallery();
    if (file != null) {
      await uploadVideoToFirebase(file);

      Generalutils().showSuccessSnackBar(context, 'Upload success');
    } else {
      print('⚠️ No video selected.');
    }
  }
}
