package org.apache.cordova.xinge;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import com.tencent.android.tpush.XGIOperateCallback;
import com.tencent.android.tpush.XGPushClickedResult;
import com.tencent.android.tpush.XGPushManager;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * This class echoes a string called from JavaScript.
 */
public class XGPush extends CordovaPlugin {

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

    Activity activity = this.cordova.getActivity();
    XGPushClickedResult clickResult = XGPushManager.onActivityStarted(activity);

    /** click message */
    if (clickResult != null) {
      Log.d("XGPush", "onResumeXGPushClickedResult:" + clickResult);
    }

    Context context = this.cordova.getActivity();

    if (action.equals("registerAccount")) {  //register
      String account = args.getString(0);
      this.registerAccount(context, callbackContext, account);
      return true;
    } else if (action.equals("unregisterAccount")) {  //unregister
      String account = args.getString(0);
      this.unregisterAccount(context, callbackContext, account);
      return true;
    }
    return false;
  }

  private void registerAccount(final Context context, final CallbackContext callbackContext, final String account) {

    if (account == null || account.isEmpty()) {
      Log.d("XGPush", "registerAccount: account is empty");
      return;
    }

    Log.d("XGPush", "Start registerAccount:" + account);
    cordova.getThreadPool().execute(new Runnable() {
      @Override
      public void run() {
        XGPushManager.bindAccount(context, account, new XGIOperateCallback() {
          @Override
          public void onSuccess(Object data, int flag) {
            Log.d("XGPush", "registerAccount success:" + data + ",flag:" + flag);
            callbackContext.success();
          }

          @Override
          public void onFail(Object data, int errCode, String msg) {
            Log.d("XGPush", "registerAccount error:" + data + ",errCode:" + errCode + ",msg:" + msg);
            callbackContext.error(msg);
          }
        });
      }
    });
  }

  private void unregisterAccount(final Context context, final CallbackContext callbackContext, final String account) {

    if (account == null || account.isEmpty()) {
      Log.d("XGPush", "unregisterAccount: account is empty");
      return;
    }

    Log.d("XGPush", "Start unregisterAccount:" + account);
    cordova.getThreadPool().execute(new Runnable() {
      @Override
      public void run() {
        XGPushManager.delAccount(context, account, new XGIOperateCallback() {
          @Override
          public void onSuccess(Object data, int flag) {
            Log.d("XGPush", "unregisterAccount success:" + data + ",flag:" + flag);
            callbackContext.success();
          }

          @Override
          public void onFail(Object data, int errCode, String msg) {
            Log.d("XGPush", "unregisterAccount error:" + data + ",errCode:" + errCode + ",msg:" + msg);
            callbackContext.error(msg);
          }
        });
      }
    });
  }
}
