import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(firebaseAuthRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(
          "suzi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {},
          child: const Text("Log"),
        ),
      ),
    );
  }
}
