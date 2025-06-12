import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class MessageTextWidget extends StatelessWidget {
  final String msg;
  final String auth;
  const MessageTextWidget({super.key, required this.msg, required this.auth});

  @override
  Widget build(BuildContext context) {
    double bottomMargin = 0;
    bool isUser = (auth=="user");


    !isUser ? bottomMargin=16 : bottomMargin=0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: isUser ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.only(bottom: bottomMargin),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isUser ? Colors.limeAccent : Colors.amberAccent,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(padding: EdgeInsetsGeometry.all(16),
                child: isUser ?  Text(msg,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
                ),) : GptMarkdown(msg,style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
                ),)
                ),
              ),
          
              !isUser ?
               Positioned(
                bottom: -20,
                right: 0,
                child: GestureDetector(
                  onTap: () async{
                   await Clipboard.setData(ClipboardData(text: msg));
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Response copied to clipboard.")));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.copy,size: 16,color: Colors.black,),
                    )),
                ),
                             ) : SizedBox(),
    
    
            ],
          ),
        ),
      ),
    );
  }
}