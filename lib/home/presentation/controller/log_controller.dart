import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';
import 'package:suzi_app/location/repository/datalog_repository.dart';

part 'log_controller.g.dart';

@riverpod
class LogController extends _$LogController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> logData(double rating) async {
    final authRepository = ref.read(firebaseAuthRepositoryProvider);
    final datalogRepository = ref.read(datalogRepositoryProvider);
    final firebaseID = authRepository.currentUser?.uid;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => datalogRepository.postDatalog(firebaseID, rating),
    );
  }
}
