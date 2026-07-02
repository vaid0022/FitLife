import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FitLife/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentUserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;


  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Method 1: Fetch current user data ONCE
  Future<void> fetchCurrentUser(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get ONLY the specific user document using their UID
      final DocumentSnapshot doc =
      await _firestore.collection('User').doc(userId).get();

      if (doc.exists) {
        _currentUser = UserModel.fromFirestore(doc);
      } else {
        _error = 'User document not found in Firestore';
      }

      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }


  // Clear user data on logout
  void clearUserData() {
    _currentUser = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}


class ThemeProvider extends ChangeNotifier{

  bool IsDarkMode = true;

  bool get Dark => IsDarkMode;

  void SetTheme({required bool Istheme}){

    IsDarkMode = Istheme;
    notifyListeners();
  }
}