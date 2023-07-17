import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:login_demo/config.dart';

import '../../networking/index.dart';
import 'package:login_demo/utilities/general_utils.dart';

class HomeController extends GetxController {

  final PagingController passengerPagingController = PagingController(firstPageKey: 0);
  static const _pageSize = 15;

  List passengerList = [];


  @override
  void onInit() async{
    super.onInit();
    passengerPagingController.addPageRequestListener((pageKey) {
      getPassengerList(pageKey);
    });
  }

  void getPassengerList(pageKey) async {
    try {
      var formData = {
        "page": pageKey,
        "size": _pageSize,
      };

      await apis.call(apiMethods.feed, formData, ApiType.get).then((resData) async {
        /// To check user scrolled or not -> you can see new post popup on top.
        if (resData.isSuccess == true) {
          var data = resData.data['data'];
          if (data != null) {
            passengerList = data;
            var isLastPage = passengerList.length < _pageSize;

            if (pageKey == 0 && !isNullOrBlank(passengerPagingController.itemList)) {
              passengerPagingController.itemList = [];
            }

            if (isLastPage) {
              passengerPagingController.appendLastPage(passengerList);
            } else {
              final nextPageKey = pageKey + passengerList.length;
              passengerPagingController.appendPage(passengerList, nextPageKey);
            }

          }
        } else {
          passengerPagingController.error = resData.message ?? 'something went wrong. Try again after some time';
        }
      });
    } catch (exception, stackTrace) {
      passengerPagingController.error = exception;
    }
  }

  Future refreshData() async {
    return getPassengerList(0);
  }
}