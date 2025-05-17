import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_project/screen/SetupScreen2.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final Map<String, double> _estimates = {
    'Food & Groceries': 20,
    'Housing & Utilities': 10,
    'Transportation': 100,
    'Healthcare & Insurance': 30,
    'Entertainment & Leisure': 50,
    'Personal Care': 70,
    'Savings & Investments': 20,
  };

  final Map<String, IconData> _icons = {
    'Food & Groceries': Icons.shopping_basket_outlined,
    'Housing & Utilities': Icons.home_outlined,
    'Transportation': Icons.directions_car_outlined,
    'Healthcare & Insurance': Icons.health_and_safety_outlined,
    'Entertainment & Leisure': Icons.theaters_outlined,
    'Personal Care': Icons.brush_outlined,
    'Savings & Investments': Icons.account_balance_wallet_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Soft light background
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEAF6FF), Color(0xFFF0F4F8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text(
          'Set Your Spending Estimates',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),

        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Estimate how much you usually spend per transaction in each category.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _estimates.keys.map((category) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(_icons[category], color: Colors.lightBlueAccent),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              'RM${_estimates[category]!.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _estimates[category]!,
                          min: 0,
                          max: 500,
                          divisions: 100,
                          activeColor: Colors.lightBlueAccent,
                          inactiveColor: Colors.grey[300],
                          onChanged: (value) {
                            setState(() {
                              _estimates[category] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetupScreen2()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6EC1E4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

