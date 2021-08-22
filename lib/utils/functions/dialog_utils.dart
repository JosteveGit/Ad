import 'package:flutter/material.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

ProgressDialog _progressDialog = ProgressDialog(barrierDismissible: false);

void showLoader(BuildContext context) {
  _progressDialog.context = context;
  _progressDialog.showMaterial(
    layout: MaterialProgressDialogLayout.overlayCircularProgressIndicator,
  );
}

void popLoader() {
  _progressDialog.dismiss();
}
