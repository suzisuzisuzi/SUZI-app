import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';

part 'sign_in_page_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> signInWithPassword(String email, String password) async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.signInWithGoogle(),
    );
  }
}
