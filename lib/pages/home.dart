import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello/ai_service/smart_reply.dart';
import 'package:hello/provider/loading_provider.dart';
import 'package:hello/provider/message_provider.dart';
import 'package:hello/widgets/message_text_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    TextEditingController msg_controller = TextEditingController();
    SmartReplyService smartReplyService = SmartReplyService();


    Future<void> addMsg() async {
    String msg = msg_controller.text.toString().trim();
    bool isloading = Provider.of<IsLoading>(context,listen: false).isloading();
    if(msg.isNotEmpty && !isloading){ 
      msg_controller.clear();
      Provider.of<IsLoading>(context,listen: false).loading();
      String data = await smartReplyService.talk(msg);
      Provider.of<MessageProvider>(context,listen: false).addMsg("user", msg);
      Provider.of<MessageProvider>(context,listen: false).addMsg("ai", data.trim());
      Provider.of<IsLoading>(context,listen: false).finished();


    }
  }

    return  Scaffold(
      appBar: AppBar(
        title: Text("H e l l o",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.76,
              child:  Consumer<MessageProvider>(
                builder: (BuildContext context, MessageProvider value, Widget? child) { 
                  List<Map<String,String>> msgs = value.getMsgs;
                  return msgs.isEmpty ? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        width: 300,
                        alignment: Alignment.center,
                        "assets/chat.png"),
                        SizedBox(
                          height: 20,
                        ),
                      Text("Start a Chat ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
                    ],
                  )) :
                   ListView.builder(
                  itemCount: msgs.length,
                  itemBuilder:(context, index) => MessageTextWidget(msg: msgs[index]["msg"].toString(),auth: msgs[index]["auth"].toString(),));
                  }
              ),
  
               
            ),
        
        
        
        
        
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    keyboardType: TextInputType.text,
                    controller: msg_controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question",
                      hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    fillColor: Colors.black,
                    border: UnderlineInputBorder(borderSide: BorderSide(
                      color: Colors.black
                    )) ,
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                      color: Colors.black
                    ))                      
                    ),
                    
                  ),
                ),
              ),
              IconButton(onPressed: ()async{
                addMsg();
              }, icon: Consumer<IsLoading>(builder: (_, provider,_) => provider.isloading() ? CircularProgressIndicator() : Icon(Icons.send),
              ),
              iconSize: 28,
              color: Colors.black,),
              
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}