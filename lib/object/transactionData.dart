import 'package:hackathon_project/util/const.dart';

class TransactionData {
  final DateTime transactionDate;
  final String transactionPlatform;
  final String description;
  final String detail;
  final double amount;
  String? humanLabel;
  String? aiLabel;
  bool hideLabel;

  TransactionData({
    required this.transactionDate,
    required this.transactionPlatform,
    required this.description,
    required this.detail,
    required this.amount,
    required this.humanLabel,
    required this.aiLabel,
    this.hideLabel = true
  });

  String getLabel(){

    String unCategorized = Const.CATEGORIZING;

    if(hideLabel){
      return unCategorized;
    }

    return humanLabel ?? aiLabel ?? unCategorized;
  }
}