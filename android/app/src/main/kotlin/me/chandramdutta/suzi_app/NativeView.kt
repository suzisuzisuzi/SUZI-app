package me.chandramdutta.suzi_app

import android.content.Context
import android.net.ConnectivityManager
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageButton
import android.widget.Toast

import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.maps.model.TileOverlayOptions
import com.google.maps.android.heatmaps.HeatmapTileProvider
import com.google.maps.android.heatmaps.WeightedLatLng
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONArray
internal class NativeView(private val context: Context, id: Int, creationParams: Map<String?, Any?>?) :
    PlatformView, OnMapReadyCallback  {

    private val ioDispatcher: CoroutineDispatcher = Dispatchers.IO

    private lateinit var mMap: GoogleMap
    private lateinit var heatmapTileProvider: HeatmapTileProvider

//    private val mapView: MapView = MapView(context)
    private val view: View
    private val mapView: MapView

    override fun getView(): View {
        return view
    }

    override fun dispose() {}

    init {
        val inflater = LayoutInflater.from(context)
        view = inflater.inflate(R.layout.activity_main, null)

        mapView = view.findViewById(R.id.mapView)

        mapView.onCreate(null)
        mapView.getMapAsync(this)
        val btnChangeMapType = view.findViewById<ImageButton>(R.id.btnChangeMapType)
        var currentMapType = GoogleMap.MAP_TYPE_NORMAL
        btnChangeMapType.setOnClickListener {
            currentMapType = when (currentMapType) {
                GoogleMap.MAP_TYPE_NORMAL -> GoogleMap.MAP_TYPE_SATELLITE
                GoogleMap.MAP_TYPE_SATELLITE -> GoogleMap.MAP_TYPE_TERRAIN
                GoogleMap.MAP_TYPE_TERRAIN -> GoogleMap.MAP_TYPE_HYBRID
                GoogleMap.MAP_TYPE_HYBRID -> GoogleMap.MAP_TYPE_NORMAL
                else -> GoogleMap.MAP_TYPE_NORMAL
            }
            mMap.mapType = currentMapType
        }
    }
    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap

        with(mMap.uiSettings) {
            isZoomControlsEnabled = true
            isCompassEnabled = true
            isMyLocationButtonEnabled = true
            isMapToolbarEnabled = true
            isScrollGesturesEnabled = true
            isZoomGesturesEnabled = true
            isTiltGesturesEnabled = true
            isRotateGesturesEnabled = true
        }
        // Example of adding a marker with an info window
        mMap.addMarker(
            MarkerOptions()
                .position(LatLng(19.0, 73.0))
                .title("Hot Women")
                .snippet("Test Category for SUZI development")
        )


        val defaultLocation = LatLng(19.0, 73.0)
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(defaultLocation, 8f))

        addHeatmap()
    }

    private fun addHeatmap() {
        if (isNetworkAvailable()) {
            CoroutineScope(ioDispatcher).launch {
                val geoJsonData = fetchGeoJsonData("https://suzi-backend.onrender.com/gheatmap/test")
                val list = parseGeoJsonData(geoJsonData)

                withContext(Dispatchers.Main) {
                    heatmapTileProvider = HeatmapTileProvider.Builder()
                        .weightedData(list)
                        .radius(50)
                        .opacity(1.0) // opacity of heatmap overlay
                        .build()

                    mMap.addTileOverlay(TileOverlayOptions().tileProvider(heatmapTileProvider))
                }
            }
        } else {
            Toast.makeText(context, "No network connection available.", Toast.LENGTH_SHORT).show()
        }
    }

    private fun isNetworkAvailable(): Boolean {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networkInfo = connectivityManager.activeNetworkInfo
        return networkInfo != null && networkInfo.isConnected
    }

    private suspend fun fetchGeoJsonData(url: String): String = withContext(ioDispatcher) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .url(url)
            .build()
        val response = client.newCall(request).execute()
        return@withContext response.body?.string() ?: ""
    }

    private fun parseGeoJsonData(data: String): List<WeightedLatLng> {
        val list = ArrayList<WeightedLatLng>()
        val jsonArray = JSONArray(data)
        for (i in 0 until jsonArray.length()) {
            val jsonObject = jsonArray.getJSONObject(i)
            val lat = jsonObject.getDouble("latitude")
            val lng = jsonObject.getDouble("longitude")
            val rating = jsonObject.getDouble("rating")
            list.add(WeightedLatLng(LatLng(lat, lng), rating))
        }
        return list
    }
}