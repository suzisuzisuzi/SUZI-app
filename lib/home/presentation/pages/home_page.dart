import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';
import 'package:suzi_app/home/presentation/controller/log_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wheel_slider/wheel_slider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool showbutton = false;

  final categories = ["Public Toilets", "Poor Children"];

  int categoryVersion = 0;

  @override
  Widget build(BuildContext context) {
    final List<Icon> icons = [
      Icon(
        Icons.wc,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      Icon(
        Icons.child_care,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    ];
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
        surfaceTintColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/icons/appicon.png",
                    width: 50,
                  ),
                ),
                applicationVersion: "1.0.0",
                children: [
                  ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://dscv.it/privacy-policy/"));
                    },
                    child: const Text(
                      "Privacy Policy",
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
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
      body: Column(
        children: [
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                // right: -300,
                child: Image.asset("assets/illustrations/background.png"),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    switch (categoryVersion) {
                      case 0:
                        if (showbutton) {
                          setState(() {
                            showbutton = false;
                          });
                        } else {
                          setState(() {
                            showbutton = true;
                          });
                        }
                      case 1:
                        if (state.isLoading) {
                          return;
                        } else {
                          ref
                              .read(logControllerProvider.notifier)
                              .logData(1, "poor-children");
                        }
                    }
                  },
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
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
              ),
              Positioned(
                top: 1,
                child: !showbutton
                    ? const SizedBox()
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: state.isLoading
                                ? null
                                : () => ref
                                    .read(logControllerProvider.notifier)
                                    .logData(5, "public-toilets"),
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
                                    .logData(0, "public-toilets"),
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
                                    .logData(-5, "public-toilets"),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 28.0, left: 28.0),
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
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    categories[categoryVersion],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Technor',
                        ),
                  ),
                  WheelSlider.customWidget(
                    totalCount: 2,
                    initValue: 0,
                    isInfinite: false,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onValueChanged: (val) {
                      setState(() {
                        categoryVersion = val;
                      });
                    },
                    hapticFeedbackType: HapticFeedbackType.vibrate,
                    showPointer: false,
                    itemSize: 80,
                    children: icons,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
