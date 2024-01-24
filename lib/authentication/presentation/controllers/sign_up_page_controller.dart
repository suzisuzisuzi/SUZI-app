import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';

part 'sign_up_page_controller.g.dart';

@riverpod
class SignUpScreenController extends _$SignUpScreenController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> signUpWithPassword(
      String email, String password, String name) async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }
}
