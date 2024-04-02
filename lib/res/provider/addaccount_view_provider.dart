import 'package:ClickHub/model/addaccount_view_model.dart';
import 'package:ClickHub/model/withdrawhistory_model.dart';
import 'package:flutter/material.dart';


class AddacountViewProvider with ChangeNotifier {
  List<AddacountViewModel> _viewList = [];

  List<AddacountViewModel> get viewlist => _viewList;

  void setwithdrawList(List<AddacountViewModel> accountviews) {
    _viewList = accountviews;
    notifyListeners();
  }
}
