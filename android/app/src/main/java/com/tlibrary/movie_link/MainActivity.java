package com.tlibrary.movie_link;

import android.view.LayoutInflater;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import com.tlibrary.movie_link.NativeAdFactoryExample;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        flutterEngine.getPlugins().add(new GoogleMobileAdsPlugin());
        super.configureFlutterEngine(flutterEngine);

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample",new  NativeAdFactoryExample(LayoutInflater.from(MainActivity.this)) );
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
    }
}

