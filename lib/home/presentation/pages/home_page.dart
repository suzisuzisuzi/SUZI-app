import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';
import 'package:suzi_app/home/presentation/controller/log_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool showbutton = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<void> state = ref.watch(logControllerProvider);
    ref.listen<AsyncValue>(
      logControllerProvider,
      (_, state) {
        if (!state.isLoading && state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.toString())),
          );
        }
        if (!state.isLoading && state.hasValue) {
          setState(() {
            showbutton = false;
          });
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
        title: Text(
          "suzi",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Technor',
              ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            // right: -300,
            child: Image.asset("assets/illustrations/background.png"),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (showbutton) {
                  setState(() {
                    showbutton = false;
                  });
                } else {
                  setState(() {
                    showbutton = true;
                  });
                }
              },
              // onTap: state.isLoading
              //     ? null
              //     : () => ref.read(logControllerProvider.notifier).logData(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Stack(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: RiveAnimation.asset(
                          "assets/rive/blob.riv",
                        ),
                      ),
                    ],
                  ),
                  state.isLoading
                      ? LoadingAnimationWidget.dotsTriangle(
                          color: Theme.of(context).colorScheme.onBackground,
                          size: 42,
                        )
                      : showbutton
                          ? Icon(
                              Icons.close,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSecondary,
                            )
                          : Text(
                              "log",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Technor',
                                  ),
                            ).animate().rotate(),
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
          Positioned(
            top: 100,
            child: !showbutton
                ? const SizedBox()
                : Row(
                    children: [
                      GestureDetector(
                        onTap: state.isLoading
                            ? null
                            : () => ref
                                .read(logControllerProvider.notifier)
                                .logData(-5),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 28.0, right: 28.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                height: 100,
                                child: RiveAnimation.asset(
                                  "assets/rive/blob.riv",
                                ),
                              ),
                              state.isLoading
                                  ? LoadingAnimationWidget.dotsTriangle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      size: 18,
                                    )
                                  : Text(
                                      "👎🏻",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: state.isLoading
                            ? null
                            : () => ref
                                .read(logControllerProvider.notifier)
                                .logData(0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 28.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                height: 100,
                                child: RiveAnimation.asset(
                                  "assets/rive/blob.riv",
                                ),
                              ),
                              state.isLoading
                                  ? LoadingAnimationWidget.dotsTriangle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      size: 18,
                                    )
                                  : Text(
                                      "😐",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: state.isLoading
                            ? null
                            : () => ref
                                .read(logControllerProvider.notifier)
                                .logData(5),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28.0, left: 28.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                height: 100,
                                child: RiveAnimation.asset(
                                  "assets/rive/blob.riv",
                                ),
                              ),
                              state.isLoading
                                  ? LoadingAnimationWidget.dotsTriangle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      size: 18,
                                    )
                                  : Text(
                                      "👍🏻",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
