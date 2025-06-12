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
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("H e l l o",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: SizedBox(
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
            ),
        
        
        
        
        
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
                          border: InputBorder.none,
                          suffixIcon: IconButton(onPressed: ()async{
                           addMsg();
                      }, icon: Consumer<IsLoading>(builder: (_, provider,_) => provider.isloading() ? CircularProgressIndicator() : Icon(Icons.send),
                      ),
                      iconSize: 28,
                      color: Colors.black,),               
                          ),
                          
                          ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
