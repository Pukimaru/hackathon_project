import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/dial/uploadDial.dart';
import 'package:hackathon_project/object/transactionData.dart';
import 'package:hackathon_project/screen/ChatBotScreen.dart';
import 'package:hackathon_project/screen/SettingScreen.dart';
import 'package:hackathon_project/util/const.dart';
import 'package:hackathon_project/widget/transactionCard.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  List<TransactionData> transactions = [];
  Map<String, double> pieData = {};
  Timer? categorizingTimer;
  bool isCategorizing = false;
  @override
  void initState() {
    //setTransactionDataSample();
    //setPieData(transactions);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Finance'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              showUploadDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              navigateToSettingScreen();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: "May 2025",
                  items: [
                    DropdownMenuItem(
                      value: 'May 2025',
                      child: Text('May 2025', style: TextStyle(fontSize: 18),),
                    ),
                  ],
                  onChanged: (value) {},
                  underline: SizedBox.shrink(),
                  hint: Text('Select Month'),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: buildPieChartAndLegend(pieData),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: buildTransactionList(),
                ),
              ],
            ),
          ),
          if(isCategorizing) Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(170),
              child: Center(
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    Text("Categorizing...")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToChatBotScreen,
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget buildPieChartAndLegend(Map<String, double> pieData) {

    if(pieData.isEmpty){
      pieData["Empty"] = 1;
    }else{
      pieData.remove("Empty");
    }

    List<MapEntry<String, double>> pieDataEntries = pieData.entries.toList();
    double totalValue = 0;
    pieDataEntries.forEach((element) => totalValue += element.value,);

    Widget child = Row(
      children: [
        // Pie Chart (3 parts)
        Expanded(
          flex: 3,
          child: PieChart(
            PieChartData(
              sections: List.generate(pieDataEntries.length, (index) {
                MapEntry<String, double> entry = pieDataEntries.toList()[index];
                String title = entry.key;
                double value = entry.value;
                return PieChartSectionData(
                  title: title,
                  value: value,
                  color: title == Const.CATEGORIZING ? Colors.white : Const.colorPalette[index],
                  showTitle: false,
                  radius: 80,
                );
              }),
              sectionsSpace: 2,
            ),
          ),
        ),
        SizedBox(width: 5,),
        // Legend (1 part)
        Expanded(
          flex: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.builder(
              itemCount: pieDataEntries.length,
              itemBuilder: (context, index) {
                MapEntry<String, double> entry = pieDataEntries.toList()[index];
                Color color = Const.colorPalette[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${entry.key} (${(entry.value * 100 / totalValue).toStringAsFixed(1)}%)',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );

    if(pieData.containsKey("Empty")){
      return Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(150),
              child: Center(
                child: Text(
                  "Please Upload Financial Statement.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        // Pie Chart (3 parts)
        Expanded(
          flex: 3,
          child: PieChart(
            PieChartData(
              sections: List.generate(pieDataEntries.length, (index) {
                MapEntry<String, double> entry = pieDataEntries.toList()[index];
                return PieChartSectionData(
                  title: '',
                  value: entry.value,
                  color: Const.colorPalette[index],
                  showTitle: false,
                  radius: 80,
                );
              }),
              sectionsSpace: 2,
            ),
          ),
        ),
        SizedBox(width: 5,),
        // Legend (1 part)
        Expanded(
          flex: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.builder(
              itemCount: pieDataEntries.length,
              itemBuilder: (context, index) {
                MapEntry<String, double> entry = pieDataEntries.toList()[index];
                Color color = Const.colorPalette[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${entry.key} (${(entry.value * 100 / totalValue).toStringAsFixed(1)}%)',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTransactionList(){

    if(transactions.isEmpty){
      return Center(
        child: Text("No Transaction Record.", style: TextStyle(color: Colors.grey),),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionCard(transaction: transactions[index]);
      },
    );
  }

  void setPieData(List<TransactionData> datas){
    pieData.clear();
    for(TransactionData transactionData in datas){

      String? label = transactionData.getLabel();

      //Insert to pieData if label is valid and not added
      if(!pieData.containsKey(label)){
        pieData[label] = 0;
      }

      pieData[label] = pieData[label]! + transactionData.amount;
    }
  }

  void setTransactionDataSample(){
    transactions = [
      // Food and Groceries
      TransactionData(
        transactionDate: DateTime(2025, 5, 1),
        transactionPlatform: 'Maybank',
        description: 'Payment to Tesco Sdn Bhd',
        detail: 'Weekly groceries',
        amount: 120.0,
        humanLabel: 'Food and Groceries',
        aiLabel: 'Supermarket',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 3),
        transactionPlatform: 'Touch \'n Go eWallet',
        description: 'Payment to Starbucks',
        detail: 'Morning coffee',
        amount: 15.0,
        humanLabel: 'Food and Groceries',
        aiLabel: 'Beverage',
      ),

      // Housing and Utilities
      TransactionData(
        transactionDate: DateTime(2025, 5, 5),
        transactionPlatform: 'CIMB Bank',
        description: 'Payment to TNB',
        detail: 'Monthly electric bill',
        amount: 200.0,
        humanLabel: 'Housing and Utilities',
        aiLabel: 'Electricity Bill',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 6),
        transactionPlatform: 'Public Bank',
        description: 'Payment to ABC Water Sdn Bhd',
        detail: 'Monthly water bill',
        amount: 50.0,
        humanLabel: 'Housing and Utilities',
        aiLabel: 'Water Bill',
      ),

      // Transportation
      TransactionData(
        transactionDate: DateTime(2025, 5, 8),
        transactionPlatform: 'GrabPay',
        description: 'Payment to Grab Sdn Bhd',
        detail: 'Ride to office',
        amount: 12.0,
        humanLabel: 'Transportation',
        aiLabel: 'Ride Hailing',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 10),
        transactionPlatform: 'Petronas',
        description: 'Fuel refill',
        detail: 'Full tank refill',
        amount: 120.0,
        humanLabel: 'Transportation',
        aiLabel: 'Fuel',
      ),

      // Healthcare and Insurance
      TransactionData(
        transactionDate: DateTime(2025, 5, 12),
        transactionPlatform: 'HongLeong Bank',
        description: 'Payment to ABC Clinic',
        detail: 'Dental check-up',
        amount: 150.0,
        humanLabel: 'Healthcare and Insurance',
        aiLabel: 'Medical Bill',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 13),
        transactionPlatform: 'RHB Bank',
        description: 'Insurance premium payment',
        detail: 'Monthly health insurance',
        amount: 200.0,
        humanLabel: 'Healthcare and Insurance',
        aiLabel: 'Insurance Premium',
      ),

      // Entertainment and Leisure
      TransactionData(
        transactionDate: DateTime(2025, 5, 15),
        transactionPlatform: 'CIMB Bank',
        description: 'Payment to Netflix',
        detail: 'Monthly subscription',
        amount: 50.0,
        humanLabel: 'Entertainment and Leisure',
        aiLabel: 'Streaming Subscription',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 16),
        transactionPlatform: 'Maybank',
        description: 'Payment to Cinemax Sdn Bhd',
        detail: 'Movie night',
        amount: 30.0,
        humanLabel: 'Entertainment and Leisure',
        aiLabel: 'Movies',
      ),

      // Personal Care
      TransactionData(
        transactionDate: DateTime(2025, 5, 18),
        transactionPlatform: 'AmBank',
        description: 'Payment to ABC Barber',
        detail: 'Haircut',
        amount: 25.0,
        humanLabel: 'Personal Care',
        aiLabel: 'Haircut',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 20),
        transactionPlatform: 'UOB',
        description: 'Payment to Sephora Sdn Bhd',
        detail: 'Skincare products',
        amount: 150.0,
        humanLabel: 'Personal Care',
        aiLabel: 'Cosmetics',
      ),

      // Savings and Investments
      TransactionData(
        transactionDate: DateTime(2025, 5, 22),
        transactionPlatform: 'Bank Islam',
        description: 'Transfer to Savings Account',
        detail: 'Monthly savings',
        amount: 500.0,
        humanLabel: 'Savings and Investments',
        aiLabel: 'Emergency Fund',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 23),
        transactionPlatform: 'OCBC Bank',
        description: 'Stock purchase',
        detail: 'Buying 10 shares',
        amount: 1000.0,
        humanLabel: 'Savings and Investments',
        aiLabel: 'Stock Purchase',
      ),

      // Debt and Loans
      TransactionData(
        transactionDate: DateTime(2025, 5, 25),
        transactionPlatform: 'Maybank',
        description: 'Credit card payment',
        detail: 'Monthly credit card bill',
        amount: 500.0,
        humanLabel: 'Debt and Loans',
        aiLabel: 'Credit Card Payment',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 27),
        transactionPlatform: 'CIMB Bank',
        description: 'Student loan repayment',
        detail: 'Monthly installment',
        amount: 300.0,
        humanLabel: 'Debt and Loans',
        aiLabel: 'Student Loan',
      ),

      // Credit
      TransactionData(
        transactionDate: DateTime(2025, 5, 30),
        transactionPlatform: 'AmBank',
        description: 'Cashback from AmBank',
        detail: 'Monthly cashback rewards',
        amount: 20.0,
        humanLabel: 'Credit',
        aiLabel: 'Cashback',
      ),
      TransactionData(
        transactionDate: DateTime(2025, 5, 31),
        transactionPlatform: 'RHB Bank',
        description: 'Credit Interest',
        detail: 'Monthly interest earned',
        amount: 10.0,
        humanLabel: 'Credit',
        aiLabel: 'Interest',
      ),
    ];

    transactions.sort((a, b) => b.transactionDate.compareTo(a.transactionDate),);
  }

  Future<void> showUploadDialog() async {
    showDialog(
      context: context,
      builder: (context) => UploadDialog(),
    ).then((value){
      setState(() {
        setTransactionDataSample();
        setPieData(transactions);
      });
      startCategorizing();
    },);
  }

  void navigateToChatBotScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatbotScreen()),
    );
  }

  void navigateToSettingScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingScreen()),
    );
  }

  void startCategorizing(){
    setState(() {
      isCategorizing = true;
    });
    categorizingTimer ??= Timer.periodic(
      Duration(milliseconds: 250),
          (timer){

        bool hasHideLabel = false;
        for(TransactionData data in transactions){
          if(data.hideLabel){
            setState(() {
              data.hideLabel = false;
              setPieData(transactions);
            });

            hasHideLabel = true;
            break;
          }
        }

        if(!hasHideLabel){
          pieData.remove(Const.CATEGORIZING);
          categorizingTimer?.cancel();
          setState(() {
            isCategorizing = false;
          });
        }
      },
    );
  }
}