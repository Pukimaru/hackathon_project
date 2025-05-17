import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  Timer? outputTimer;

  List<String> fullText = """
Based on your transaction data, here’s a breakdown of your spending changes from 2024 to 2025: 
 isTab •Food and Groceries: You spent 15% more, likely due to rising grocery prices or more dining out.
 isTab •Housing and Utilities: 10% less, indicating better energy management or lower rent.
 isTab •Transportation: 18% more, possibly due to increased fuel costs or more travel.
 isTab •Healthcare and Insurance: 5% more, which may include routine check-ups or premium adjustments.
 isTab •Entertainment and Leisure: 12% less, perhaps reflecting a shift to more budget-friendly hobbies.
 isTab •Personal Care: 7% more, possibly due to more frequent salon visits or skincare investments.
 isTab •Savings and Investments: 25% more, a solid move towards financial stability.
 isTab •Debt and Loans: 5% less, suggesting reduced liabilities or better debt management.

Overall, you’ve managed to save more, but some categories like transportation and personal care saw noticeable increases.
  """.split(" ");

  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "message": message.trim()});
      });
      _controller.clear();
      _simulateBotResponse();
    }
  }

  void _simulateBotResponse() async {
    String fullResponse = "This is a sample bot response.";
    String currentText = "";

    setState(() {
      _messages.add({"sender": "bot", "message": ""});
    });

    outputTimer ??= Timer.periodic(Duration(milliseconds: 50), (timer) {
      if(fullText.isNotEmpty){
        String toAddText = fullText[0];
        if(toAddText == "isNewline"){toAddText = "\r\n";}
        else if(toAddText == "isTab"){toAddText = "\t";}
        else{toAddText = " $toAddText";}
        setState(() {
          currentText += toAddText;
          (_messages.last)["message"] = currentText.trim();
        });
        fullText.removeAt(0);

      }else{
        outputTimer?.cancel();
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.lightBlueAccent : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["message"]!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF6EC1E4)),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

