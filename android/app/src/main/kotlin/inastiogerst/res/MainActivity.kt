package inastiogerst.res

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.telephony.TelephonyManager

class MainActivity: FlutterActivity() {
  private val CHANNEL = "sim_card"
  

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "getSimCardStatus") {
        val status = getSimCardStatus()

        result.success(status)
      } else {
        result.notImplemented()
      }
    }
  }


  private fun getSimCardStatus(): Boolean {
    val manager: TelephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

    if (TelephonyManager.SIM_STATE_READY == manager.getSimState()) {
      return true;
    } else {
      return false;
    }
    
  }
}