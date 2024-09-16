import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute
        .of(context)
        ?.isCurrent != true;

showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

hideLoading(BuildContext context) {
  if (!isThereCurrentDialogShowing(context)) return;
  Navigator.pop(context);
}

showMessage(BuildContext context,
    {String? title,
      String? body,
      String? posButtonTitle,
      String? negButtonTitle,
      Function? onPosButtonClick,
      Function? onNegButtonClick}) {
  showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onPosButtonClick?.call();
                    Navigator.pop(context);
                  },
                  child: Text(posButtonTitle)),
            if (negButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onNegButtonClick?.call();
                    Navigator.pop(context);
                  },
                  child: Text(negButtonTitle))
          ],
        );
      });
}
