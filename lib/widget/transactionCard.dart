import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/object/transactionData.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget{
  double maxCardHeight;
  TransactionData transaction;

  TransactionCard({
    super.key,
    this.maxCardHeight = 200,
    required this.transaction
  });

  @override
  State<StatefulWidget> createState() {
    return TransactionCardState();
  }

}

class TransactionCardState extends State<TransactionCard>{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightForFinite(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(widget.transaction.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  Text('RM ${widget.transaction.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[700])),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                        widget.transaction.getLabel() ?? "Not Categorized",
                        style: TextStyle(
                            color: widget.transaction.getLabel() == null ? Colors.red : Colors.grey[600]
                        )
                    ),
                  ),
                  Text(DateFormat("dd-MM-yy HH:mm:ss").format(widget.transaction.transactionDate), style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}