import 'package:bloc/bloc.dart';
import 'package:chat/helper/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMesage: e.code));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMesage: e.code));
      }
    } catch (e) {
      emit(RegisterFailure(errorMesage: 'there is something went wrong !'));
    }
  }
}
