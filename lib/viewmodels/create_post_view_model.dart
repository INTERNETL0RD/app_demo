import 'dart:io';

import 'package:prototipo_agifreu/services/authentication_service.dart';

import '../locator.dart';
import '../models/post.dart';
import '../models/cloud_storage_result.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';
import '../utils/image_selector.dart';
import '../services/cloud_storage_service.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>(); 
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage {
    return _selectedImage != null ? _selectedImage : null;
  } 

  Post _edittingPost;

  bool get _editting => _edittingPost != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting) {
      if (_selectedImage != null) {
        storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage,
          title: title,
        );
      }
    }

    var result;

    if (!_editting) {
      result = await _firestoreService.addPost(Post(
        title: title,
        userId: currentUser.id,
        imageUrl: storageResult != null ? storageResult.imageUrl : null,
        imageFileName: storageResult != null ? storageResult.imageFileName : null,
      ));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'No se pudo crear el post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post creado correctamente',
        description: 'Su post ha sido creado.',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
