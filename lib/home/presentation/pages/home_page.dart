import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';
import 'package:suzi_app/home/presentation/controller/log_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<void> state = ref.watch(logControllerProvider);
    ref.listen<AsyncValue>(
      logControllerProvider,
      (_, state) {
        if (!state.isLoading && state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.toString())),
          );
        }
      },
    );
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
        child: GestureDetector(
          onTap: state.isLoading
              ? null
              : () => ref.read(logControllerProvider.notifier).logData(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 200,
                height: 200,
                child: RiveAnimation.asset(
                  "assets/rive/blob.riv",
                ),
              ),
              state.isLoading
                  ? LoadingAnimationWidget.dotsTriangle(
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 42,
                    )
                  : Text(
                      "log",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Technor',
                              ),
                    ),
            ],
          ),
        ),
        // child: FilledButton(
        //   onPressed: state.isLoading
        //       ? null
        //       : () => ref.read(logControllerProvider.notifier).logData(),
        //   child: state.isLoading
        //       ? const CupertinoActivityIndicator()
        //       : const Text("Log"),
        // ),
      ),
    );
  }
}
