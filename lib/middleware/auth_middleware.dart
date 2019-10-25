import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:vastram/actions/auth_actions.dart';
import 'package:vastram/actions/loading_actions.dart';
import 'package:vastram/keys.dart';
import 'package:vastram/models/app_state.dart';
import 'package:vastram/routes.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final sendOTP = _createSendOTPMiddleware();
  final verifyOTP = _createVerifyOTPMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
    TypedMiddleware<AppState, SendOTP>(sendOTP),
    TypedMiddleware<AppState, VerifyOTP>(verifyOTP),
    TypedMiddleware<AppState, LogOut>(logOut),
  ];
}

Middleware<AppState> _createSendOTPMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is SendOTP) {
      try {
        store.dispatch(StartLoading());
        await _auth.verifyPhoneNumber(
          phoneNumber: action.phone,
          codeAutoRetrievalTimeout: action.codeAutoRetrievalTimeout,
          codeSent: action.codeSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: action.verificationCompleted,
          verificationFailed: action.verificationFailed
        );
        store.dispatch(StopLoading());
      }
      catch (error) {
        print(error);
      }
    }
    next(action);
  };
}

Middleware<AppState> _createVerifyOTPMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is VerifyOTP) {
      try {
        store.dispatch(StartLoading());
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: action.verificationId,
          smsCode: action.otp,
        );
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        Keys.navigatorKey.currentState.pushReplacementNamed(Routes.homeScreen);
        store.dispatch(StopLoading());
        store.dispatch(LogInSuccessful(user: user));
      }
      catch (error) {
        print(error);
        store.dispatch(LogInFail(error: error));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
		final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logging out...');
      store.dispatch(new LogOutSuccessful());
    } catch (error) {
      print(error);
    }
	};
}