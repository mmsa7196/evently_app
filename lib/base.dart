import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class BaseConnector {
  showLoadingDialog({String? message});

  showSuccessDialog({String? message});

  showErrorDialog({String? message});
}

class BaseViewModel<T extends BaseConnector> extends ChangeNotifier {
  T? connector;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseConnector {
  late VM viewModel;

  // className objectName= className() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = iniMyViewModel();
  }

  VM iniMyViewModel();

  @override
  showErrorDialog({String? message}) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text("Something went wrong".tr()),
        content: Text(message ?? ""),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text("OK".tr()))
        ],
      ),
    );
  }

  @override
  showLoadingDialog({String? message}) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        title: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  showSuccessDialog({String? message}) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text("Successfully".tr()),
        content: Text(message ?? ""),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text("OK".tr()))
        ],
      ),
    );
  }
}
