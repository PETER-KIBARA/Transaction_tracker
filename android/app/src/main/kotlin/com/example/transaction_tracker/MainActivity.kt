package com.example.transaction_tracker

import android.provider.Telephony
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.example.transaction_tracker/sms_reader"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            if (call.method != "readAllInbox") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            try {
                val projection = arrayOf(Telephony.Sms.ADDRESS, Telephony.Sms.BODY, Telephony.Sms.DATE)
                val messages = mutableListOf<Map<String, Any?>>()
                contentResolver.query(
                    Telephony.Sms.Inbox.CONTENT_URI,
                    projection,
                    null,
                    null,
                    "${Telephony.Sms.DATE} DESC"
                )?.use { cursor ->
                    val address = cursor.getColumnIndexOrThrow(Telephony.Sms.ADDRESS)
                    val body = cursor.getColumnIndexOrThrow(Telephony.Sms.BODY)
                    val date = cursor.getColumnIndexOrThrow(Telephony.Sms.DATE)
                    while (cursor.moveToNext()) {
                        messages.add(mapOf(
                            "address" to cursor.getString(address),
                            "body" to cursor.getString(body),
                            "date" to cursor.getLong(date)
                        ))
                    }
                }
                result.success(messages)
            } catch (error: Exception) {
                result.error("SMS_READ_FAILED", error.message, null)
            }
        }
    }
}
