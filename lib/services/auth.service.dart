import 'dart:async';
import 'dart:math';

class AuthService{
  Future<bool> login() async {
    //todo update with api and storage
    // Simulate a future for response after 2 second.
    return await new Future<bool>.delayed(
        new Duration(
            seconds: 2
        ), () => new Random().nextBool()
    );
  }

  Future<bool> isLoggedIn() async {
    return true;
  }

  // Logout
  Future<void> logout() async {
    //todo update with api and storage
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(
        new Duration(
            seconds: 1
        )
    );
  }
}