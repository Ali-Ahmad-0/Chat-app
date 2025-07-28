import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMesage: e.code));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMesage: e.code));
      }
    } catch (e) {
      emit(LoginFailure(errorMesage: 'Something went wrong'));
    }
  }
}
