import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HeatmapPage extends StatelessWidget {
  HeatmapPage({super.key});

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
        Uri.parse('https://chandram-dutta.github.io/suzi_google_maps/'));

  @override
  Widget build(BuildContext context) {
    const String viewType = '@views/native-view';
    const Map<String, dynamic> creationParams = <String, dynamic>{};
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Map",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Technor',
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: Platform.isAndroid
              ? PlatformViewLink(
                  viewType: viewType,
                  surfaceFactory: (context, controller) {
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <Factory<
                          OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                  },
                  onCreatePlatformView: (params) {
                    return PlatformViewsService.initSurfaceAndroidView(
                      id: params.id,
                      viewType: viewType,
                      layoutDirection: TextDirection.ltr,
                      creationParams: creationParams,
                      creationParamsCodec: const StandardMessageCodec(),
                      onFocus: () {
                        params.onFocusChanged(true);
                      },
                    )
                      ..addOnPlatformViewCreatedListener(
                          params.onPlatformViewCreated)
                      ..create();
                  },
                )
              : WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}
