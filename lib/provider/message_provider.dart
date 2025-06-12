import 'package:flutter/widgets.dart';

class MessageProvider extends ChangeNotifier{
  List<Map<String,String>>_msgs = [];
  get getMsgs=> _msgs;
  
  void addMsg(String auth,String msg){
    _msgs.add({"auth":auth,"msg":msg});
    notifyListeners();
  }


  
}