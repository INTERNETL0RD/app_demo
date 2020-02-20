import 'package:prototipo_agifreu/viewmodels/base_model.dart';
import '../locator.dart';
import '../services/firestore_service.dart';
import '../utils/image_selector.dart';
import '../services/cloud_storage_service.dart';
import '../models/cloud_storage_result.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class ProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  var isEditting = true;
  File selectedProfilePic;
  File selectedBkdPic;
  void toggleEdit() {
    isEditting = !isEditting;
    notifyListeners();
  }

  void saveChanges(String date, String role) async {
    setBusy(true);
    CloudStorageResult storageResultProfile;
    CloudStorageResult storageResultBkd;
    if (selectedProfilePic != null) {
      storageResultProfile = await _cloudStorageService.uploadImage(
        imageToUpload: selectedProfilePic,
        title: "profile",
      );
    }
    if (selectedBkdPic != null) {
      storageResultBkd = await _cloudStorageService.uploadImage(
        imageToUpload: selectedBkdPic,
        title: "bkd",
      );
    }
    await _firestoreService.updateUser(currentUser.id, date, role, storageResultProfile.imageUrl, storageResultBkd.imageUrl);
    currentUser.bkdPicUrl = storageResultBkd.imageUrl;
    currentUser.picUrl = storageResultProfile.imageUrl;
    currentUser.date = date;
    currentUser.userRole = role;
    setBusy(false);
  }

  Future selectProfilePic() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      selectedProfilePic = tempImage;
      notifyListeners();
    }
  }

  Future selectBkdPic() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      selectedBkdPic = tempImage;
      notifyListeners();
    }
  }
}
