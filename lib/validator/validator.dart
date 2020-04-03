import 'dart:async';

mixin Validators {
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError("Password length should be greater than 4 chars.");
    }
  });
  var usernameOrEmailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError("username length should be greater than 6 chars.");
    }
  });
  final authCheck =
  StreamTransformer<bool, bool>.fromHandlers(handleData: (auth, sink) {
    if (auth == true) {
      sink.add(true);
    } else {
      sink.add(false);
      sink.addError('Must be Authenticated');
    }
  });
}
