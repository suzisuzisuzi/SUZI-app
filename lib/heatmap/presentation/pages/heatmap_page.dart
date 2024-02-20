import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wheel_slider/wheel_slider.dart';

class HeatmapPage extends StatefulWidget {
  const HeatmapPage({super.key});

  @override
  State<HeatmapPage> createState() => _HeatmapPageState();
}

class _HeatmapPageState extends State<HeatmapPage> {
  ValueNotifier<int> categoryVersion = ValueNotifier(0);
  final categories = ["Public Toilets", "Poor Children"];
  final Map<String, dynamic> creationParams = <String, dynamic>{};
  final List<String> viewType = [
    '@views/public-toilet-view',
    '@views/poor-children-view'
  ];
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Center(
          //   child: LoadingAnimationWidget.dotsTriangle(
          //     color: const Color.fromRGBO(255, 230, 180, 1),
          //     size: 42,
          //   ),
          // );
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(
              'https://chandram-dutta.github.io/suzi_google_maps/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
        Uri.parse('https://suzisuzisuzi.github.io/SUZI-googlemaps-web/'));

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Platform.isAndroid
                  ? ValueListenableBuilder(
                      valueListenable: categoryVersion,
                      builder: (context, value, _) {
                        if (value == 0) {
                          return PlatformViewLink(
                            key: UniqueKey(),
                            viewType: "@views/native-view",
                            surfaceFactory: (context, controller) {
                              return AndroidViewSurface(
                                controller: controller as AndroidViewController,
                                gestureRecognizers: const <Factory<
                                    OneSequenceGestureRecognizer>>{},
                                hitTestBehavior:
                                    PlatformViewHitTestBehavior.opaque,
                              );
                            },
                            onCreatePlatformView: (params) {
                              return PlatformViewsService
                                  .initSurfaceAndroidView(
                                id: params.id,
                                viewType: "@views/native-view",
                                layoutDirection: TextDirection.ltr,
                                creationParams: {"heatmap": "public-toilets"},
                                creationParamsCodec:
                                    const StandardMessageCodec(),
                                onFocus: () {
                                  params.onFocusChanged(true);
                                },
                              )
                                ..addOnPlatformViewCreatedListener(
                                    params.onPlatformViewCreated)
                                ..create();
                            },
                          );
                        } else {
                          return PlatformViewLink(
                            key: UniqueKey(),
                            viewType: "@views/native-view",
                            surfaceFactory: (context, controller) {
                              return AndroidViewSurface(
                                controller: controller as AndroidViewController,
                                gestureRecognizers: const <Factory<
                                    OneSequenceGestureRecognizer>>{},
                                hitTestBehavior:
                                    PlatformViewHitTestBehavior.opaque,
                              );
                            },
                            onCreatePlatformView: (params) {
                              return PlatformViewsService
                                  .initSurfaceAndroidView(
                                id: params.id,
                                viewType: "@views/native-view",
                                layoutDirection: TextDirection.ltr,
                                creationParams: {"heatmap": "poor-children"},
                                creationParamsCodec:
                                    const StandardMessageCodec(),
                                onFocus: () {
                                  params.onFocusChanged(true);
                                },
                              )
                                ..addOnPlatformViewCreatedListener(
                                    params.onPlatformViewCreated)
                                ..create();
                            },
                          );
                        }
                      })
                  : WebViewWidget(controller: controller),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    categories[categoryVersion.value],
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
                        categoryVersion.value = val;
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
