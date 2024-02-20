package me.chandramdutta.suzi_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
//        flutterEngine
//            .platformViewsController
//            .registry
//            .registerViewFactory(
//                "@views/public-toilet-view",
//                PublicToiletViewFactory()
//            )
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "@views/native-view",
                NativeViewFactory()
            )
    }


}

//import android.os.Bundle
//import com.google.android.gms.maps.MapView
//import com.google.android.gms.maps.MapsInitializer
//import com.google.android.gms.maps.OnMapReadyCallback
//import com.google.android.gms.maps.GoogleMap
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity : FlutterActivity(), OnMapReadyCallback {
//
//    private lateinit var mapView: MapView
//    private var googleMap: GoogleMap? = null
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_main)
//
//        mapView = findViewById(R.id.mapView)
//        mapView.onCreate(savedInstanceState)
//        mapView.getMapAsync(this)
//    }
//
//    override fun onMapReady(googleMap: GoogleMap) {
//        MapsInitializer.initialize(this)
//        this.googleMap = googleMap
//        // Set up your map here
//    }
//
//    override fun onResume() {
//        super.onResume()
//        mapView.onResume()
//    }
//
//    override fun onPause() {
//        super.onPause()
//        mapView.onPause()
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        mapView.onDestroy()
//    }
//
//    override fun onLowMemory() {
//        super.onLowMemory()
//        mapView.onLowMemory()
//    }
//}