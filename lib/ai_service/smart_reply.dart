
import 'package:firebase_ai/firebase_ai.dart';

class SmartReplyService {
   late ChatSession chat;
   SmartReplyService(){ 
     final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash');
     chat = model.startChat();
   }
    

   Future<String> talk(String msg)async{
    
    final response = await chat.sendMessage(Content.text(msg));
    return response.text ??"...";
   }
}