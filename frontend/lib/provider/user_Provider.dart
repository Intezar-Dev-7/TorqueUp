/*
Provider  => 	Gives access to shared data
Consumer	=> Reads the data in widgets
ChangeNotifier	=> Notifies listeners when data changes
notifyListeners()	=> Tells widgets to rebuild with new data
*/

import 'package:flutter/material.dart';
import 'package:frontend/features/admin/models/user.dart';


// UserProvider is used to manage and share the User object across the app.
class UserProvider extends ChangeNotifier {
  // Private _user variable to store the current user's data.
  // Initially set to an empty user.
  User _user = User(
    id: '',
    name: '',
    password: '',
    email: '',
    role: '',
    address: '',
    token: '',
  );

  // Public getter to allow other widgets to access the current user.
  User get user => _user;

  // Sets the user from a JSON string (usually from API response).
  // Converts JSON to User model and notifies listeners to rebuild the UI.
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners(); // Tells widgets listening to UserProvider to rebuild
  }

  // Sets the user from an existing User object.
  // Useful when you already have a User model instance.
  void setUserFromModel(User user) {
    _user = user;
    notifyListeners(); // Tells widgets listening to UserProvider to rebuild
  }
}
