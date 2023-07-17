import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:login_demo/config.dart';
import '../../controllers/home/home_controller.dart';
import '../../widgets/common/app_component.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var homeCtrl = Get.put(HomeController());

  Widget buildPassengerItem(dynamic passenger) {
    final airline = passenger['airline'][0];

    return ListTile(
      leading: Image.network(airline['logo'], width: 60, errorBuilder: (BuildContext context, Object exception,
          StackTrace? stackTrace) {
        return const Text('No Image', textAlign: TextAlign.center,);
      },),
      title: Text(passenger['name']),
      subtitle: Text(airline['name']),
      trailing: Text('Trips: ${passenger['trips']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppComponent(
      child: Scaffold(
        backgroundColor: appCtrl.appTheme.white,
        appBar: AppBar(
          title: Center(child: Image.asset(imageAssets.bullIcon, width: 40)),
          backgroundColor: appCtrl.appTheme.primary,
          elevation: 0,

        ),
        body: GetBuilder<HomeController>(
          builder: (_) => RefreshIndicator(
            onRefresh: homeCtrl.refreshData,
            child: PagedListView(
              pagingController: homeCtrl.passengerPagingController,
              addAutomaticKeepAlives: true,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, passenger, index) {
                  return buildPassengerItem(passenger);
                },
              ),
            ),
          )
        ),

      ),
    );
  }

}