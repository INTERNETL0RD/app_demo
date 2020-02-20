import 'package:flutter/widgets.dart';
import '../locator.dart';
import '../models/user.dart';
import '../services/authentication_service.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}