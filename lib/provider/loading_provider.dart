
import 'package:flutter/widgets.dart' show ChangeNotifier;

class IsLoading with ChangeNotifier{
  bool _isloading = false;

  bool isloading()=> _isloading;

  void loading(){
    _isloading = true;
    notifyListeners();
  }
  void finished(){
    _isloading = false;
    notifyListeners();
  }

}