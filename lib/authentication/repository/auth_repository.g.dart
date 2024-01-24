// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userStatusChangesHash() => r'54f62c8fc5629883e08c6e3968ca9eed04181302';

/// See also [userStatusChanges].
@ProviderFor(userStatusChanges)
final userStatusChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  userStatusChanges,
  name: r'userStatusChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userStatusChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserStatusChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$firebaseAuthRepositoryHash() =>
    r'8cfdfe8d1ece49ca27ce318453ffcbdc17928bca';

/// See also [firebaseAuthRepository].
@ProviderFor(firebaseAuthRepository)
final firebaseAuthRepositoryProvider =
    AutoDisposeProvider<AuthRepository>.internal(
  firebaseAuthRepository,
  name: r'firebaseAuthRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAuthRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
