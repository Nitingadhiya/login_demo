import 'dart:io';
import 'package:dio/dio.dart';
import '../config.dart';
import '../model/api_data_class.dart';
import '../utilities/general_utils.dart';
import '../utilities/network_utils.dart';
import '../utilities/snack_and_dialogs_utils.dart';

Dio dio = Dio();

bool isApiLoading = false;
List<String> activeApiCall = [];

class Apis {
  //this is compulsory. do not delete

  Apis() {
    //options
    dio.options
      ..baseUrl = 'https://api.instantwebtools.net/'
      ..connectTimeout = const Duration(seconds: (35 * 1000)) // 35 seconds
      ..receiveTimeout = const Duration(seconds: (35 * 1000)) // 35 seconds
      ..validateStatus = (int? status) {
        return status! > 0; //This will always redirect to onResponse method
      }
      ..headers = {
        'Accept': 'application/json',
        'content-type': 'application/json',
      };
    //interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        printLog("Api Url : ${options.uri}");
        printLog("Api header : ${options.headers}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        printLog("Api error : $e");
        return handler.next(e);
      },
    ));
  }

  // ignore: missing_return
  Future<APIDataClass> call(String apiName, body, type) async {
    //default data to class
    APIDataClass apiData = APIDataClass(message: 'No Data', isSuccess: false, validation: false, data: null);

    printLog("Api $apiName init (${DateTime.now()})");

    if (!activeApiCall.contains(apiName)) {
      try {
        bool isInternet = await isNetworkConnection();
        if (isInternet) {
          ///add to request list

          dio.options.headers = {
            ...dio.options.headers,
          };
          dynamic response;

          switch (type) {
            case ApiType.get:
              response = await dio.get(apiName, queryParameters: body);
              break;
            case ApiType.post:
              response = await dio.post(apiName, data: body);
              break;
            case ApiType.delete:
              response = await dio.delete(apiName, data: body);
              break;
            case ApiType.put:
              response = await dio.put(apiName, data: body);
              break;
          }

          printLog("Api $apiName response (${DateTime.now()}) : $response");
          apiData = await checkStatus(response, apiName);

          ///remove from api call
          activeApiCall.remove(apiName);
        } else {
          return APIDataClass(
            isSuccess: false,
            validation: false,
            message: "Couldn't connect to the internet",
            data: null,
          );
          //goToNoInternetScreen();
        }
        return apiData;
      } on DioError catch (ex) {
        ///remove from api call
        activeApiCall.remove(apiName);
        if (ex.type == DioErrorType.connectionTimeout) {
          //throw Exception("Connection  Timeout Exception");
        }
        //throw Exception(ex.message);
        return apiData;
      } on SocketException catch (e) {
        ///remove from api call
        activeApiCall.remove(apiName);

        onSocketException(e);
        return apiData;
      } on Exception catch (e) {
        ///remove from api call
        activeApiCall.remove(apiName);

        onException(e);
        return apiData;
      }
    } else {
      return apiData;
    }
  }

  //#region functions
  Future<APIDataClass> checkStatus(response, apiName) async {
    printLog("Api statusCode ($apiName) : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return APIDataClass(
        isSuccess: true,
        validation: false,
        message: 'Success',
        data: response.data,
        status: response.statusCode,
      );
    } else if (response.statusCode == 422) {
      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'Validation failed',
        data: response.data,
        status: response.statusCode,
      );
    } else if (response.statusCode == 404) {
      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'Not found',
        data: {'message': 'something went wrong. Try again after some time'},
        status: response.statusCode,
      );
    } else if (response.statusCode == 401) {
      if (Get.currentRoute != routeName.login) {
        snackBar('Unauthorised access please login');
        // var settingCtrl = Get.isRegistered<SettingController>() ? Get.find<SettingController>() : Get.put(SettingController());
        // settingCtrl.logOut();
      }

      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: 'Unauthorised access please login',
        data: response.data ?? {'message': 'something went wrong. Try again after some time'},
        status: response.statusCode,
      );
    } else {
      return APIDataClass(
        isSuccess: false,
        validation: true,
        message: response.statusMessage,
        data: response.data ?? {'message': 'something went wrong. Try again after some time'},
        status: response.statusCode,
      );
    }
  }

  onSocketException(e) {
    //do not delete
    snackBar("Couldn't connect to the internet");
  }

  onException(e) {
    //do not delete
    snackBar('Something went wrong. Tap to try again.');
  }

  bool canRequestApi(apiName) {
    if (activeApiCall.contains(apiName)) {
      return false;
    } else {
      return true;
    }
  }
}