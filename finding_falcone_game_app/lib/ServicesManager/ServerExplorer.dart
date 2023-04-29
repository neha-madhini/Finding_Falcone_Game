import 'dart:convert';
import 'package:finding_falcone_app/Helpers/UIHelpers.dart';
import 'package:finding_falcone_app/Models/APIResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServerExplorer {
  //var deviceName = Utility.getDeviceOSName();
  static Future<APIResponse> httpPost({
    Object? requestModel,
    String? requestUrl,
    BuildContext? context,
  }) async {
    UIHelpers.instance.showLoadingDialog(context!);
    try {
      var url = Uri.parse(requestUrl ?? "");
      var encodedBody = json.encode(requestModel);
      var response = await http.post(url,
          body: encodedBody, headers: prepareHeader());
      //var jsonData = json.decode(response.body);
      debugPrint(requestUrl);
      debugPrint(encodedBody);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var jsonData = json.decode(response.body);
          return APIResponse(
            data: jsonData,
            isSuccess: true,
            errorCode: response.statusCode,
            errorMessage: '',
          );
        } else {
          return APIResponse(
            data: "",
            isSuccess: true,
            errorCode: response.statusCode,
            errorMessage: '',
          );
        }
      } else {
        debugPrint("${requestUrl ?? ""} API Failed");
        return APIResponse(
          data: '',
          isSuccess: false,
          errorCode: response.statusCode,
          errorMessage:
              response.body.isNotEmpty ? response.body : response.reasonPhrase,
        );
      }
    } on Exception catch (exception) {
      return APIResponse(
          data: '',
          isSuccess: false,
          errorMessage: "Issue server calling $exception");
    } finally {
      UIHelpers.instance.closeLoadingDialog(context);
    }
  }

  static Future<APIResponse> httpGet({
    String? requestUrl,
    BuildContext? context,
  }) async {
    UIHelpers.instance.showLoadingDialog(context!);
    try {
      var url = Uri.parse(requestUrl ?? "");
      var response = await http.get(
        url,
        headers: prepareHeader(),
      );
      //var jsonData = json.decode(response.body);
      debugPrint(requestUrl);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return APIResponse(
            data: jsonData,
            isSuccess: true,
            errorCode: response.statusCode,
            errorMessage: "");
      } else {
        debugPrint("${requestUrl ?? ""} API Failed");
        return APIResponse(
            data: "",
            isSuccess: false,
            errorCode: response.statusCode,
            errorMessage: response.body);
      }
      //APIResponse.fromJson(jsonData);
    } on Exception catch (exception) {
      return APIResponse(
          data: "",
          isSuccess: false,
          errorCode: '',
          errorMessage: 'Something Went Wrong');
      //APIResponse(
      //  data: null,
      //isSuccess: false,
      //errorMessage: "Issue server calling $exception");
    } finally {
      UIHelpers.instance.closeLoadingDialog(context);
    }
  }

  static Future<APIResponse> httpPut(
      {Object? requestModel,
      String? requestUrl,
      BuildContext? context,
      String token = ''}) async {
    UIHelpers.instance.showLoadingDialog(context!);
    try {
      var url = Uri.parse(requestUrl ?? "");
      var encodedBody = json.encode(requestModel);
      var response = await http.put(url,
          body: encodedBody, headers: prepareHeader());
      debugPrint(requestUrl);
      debugPrint(encodedBody);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return APIResponse(
          data: jsonData,
          isSuccess: true,
          errorCode: response.statusCode,
          errorMessage: '',
        );
      } else {
        debugPrint("${requestUrl ?? ""} API Failed");
        return APIResponse(
          data: '',
          isSuccess: false,
          errorCode: response.statusCode,
          errorMessage:
              response.body.isNotEmpty ? response.body : response.reasonPhrase,
        );
      }
      // var jsonData = json.decode(response.body);
      // return APIResponse.fromJson(jsonData);
    } on Exception catch (exception) {
      return APIResponse(
          data: null,
          isSuccess: false,
          errorMessage: "Issue server calling $exception");
    } finally {
      UIHelpers.instance.closeLoadingDialog(context);
    }
  }

  static Future<APIResponse> httpDelete(
      {Object? requestModel,
      String? requestUrl,
      BuildContext? context,
      String token = ''}) async {
    UIHelpers.instance.showLoadingDialog(context!);
    try {
      var url = Uri.parse(requestUrl ?? "");
      var encodedBody = json.encode(requestModel);
      var response = await http.delete(url,
          body: encodedBody, headers: prepareHeader());
      debugPrint(requestUrl);
      debugPrint(encodedBody);
      debugPrint(response.body);
      //var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return APIResponse(
          data: jsonData,
          isSuccess: true,
          errorCode: response.statusCode,
          errorMessage: '',
        );
      } else {
        debugPrint("${requestUrl ?? ""} API Failed");
        return APIResponse(
          data: '',
          isSuccess: false,
          errorCode: response.statusCode,
          errorMessage:
              response.body.isNotEmpty ? response.body : response.reasonPhrase,
        );
      }
    } on Exception catch (exception) {
      return APIResponse(
          data: null,
          isSuccess: false,
          errorMessage: "Issue server calling $exception");
    } finally {
      UIHelpers.instance.closeLoadingDialog(context);
    }
  }

   static Map<String, String> prepareHeader() {
      return <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json"
      };
  }
}
