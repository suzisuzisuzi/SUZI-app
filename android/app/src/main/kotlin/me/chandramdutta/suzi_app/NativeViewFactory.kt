@file:Suppress("UNCHECKED_CAST")

package me.chandramdutta.suzi_app

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PublicToiletViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return PublicToiletView(context, viewId, args as Map<String, String>)
    }
}