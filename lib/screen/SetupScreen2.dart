import 'package:flutter/material.dart';
import 'package:hackathon_project/screen/DashboardScreen.dart';

class SetupScreen2 extends StatefulWidget {
  @override
  _SetupScreen2State createState() => _SetupScreen2State();
}

class _SetupScreen2State extends State<SetupScreen2> {
  bool _monthlyEnabled = false;
  bool _dailyPromptEnabled = false;

  Map<String, bool> linkedServices = {
    'Maybank': false,
    'CIMB': false,
    'RHB': false,
    'Public Bank': false,
    'TnG eWallet': false,
    'ShopeePay': false,
  };

  final Map<String, String> serviceLogos = {
    'Maybank': 'assets/maybank.png',
    'CIMB': 'assets/cimb.png',
    'RHB': 'assets/rhb.png',
    'Public Bank': 'assets/publicbank.png',
    'TnG eWallet': 'assets/tng.png',
    'ShopeePay': 'assets/shopeepay.png',
  };

  void _showServiceLinkDialog() {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text('Select a Service to Link or Unlink'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: linkedServices.keys.map((service) {
                  final isLinked = linkedServices[service]!;
                  return ListTile(
                    leading: Image.asset(
                      serviceLogos[service]!,
                      width: 32,
                      height: 32,
                    ),
                    title: Text(service),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(isLinked ? 'Unlink $service' : 'Link $service'),
                            content: Text(
                              isLinked
                                  ? 'Are you sure you want to unlink your $service account?'
                                  : 'Would you like to proceed to link your $service account?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    linkedServices[service] = !isLinked;
                                  });
                                  setStateDialog(() {});
                                  Navigator.of(context).pop();
                                },
                                child: Text('Continue'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLinked ? Colors.red : Colors.green,
                      ),
                      child: Text(
                        isLinked ? 'Unlink' : 'Link',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
          'Smart Spending Setup',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Live Transaction Tracking Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Transaction Tracking',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Instantly track and categorize your payments by linking your Malaysian bank accounts and e-wallets such as TnG and ShopeePay.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _showServiceLinkDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Link Now', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Monthly Statement Upload
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CheckboxListTile(
                value: _monthlyEnabled,
                onChanged: (val) {
                  setState(() {
                    _monthlyEnabled = val!;
                  });
                },
                title: Text(
                  'Monthly Bank Statement',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'At the end of each month, upload a PDF version of your bank statement. The system will automatically analyze and categorize your transactions.',
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Daily Prompt
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CheckboxListTile(
                value: _dailyPromptEnabled,
                onChanged: (val) {
                  setState(() {
                    _dailyPromptEnabled = val!;
                  });
                },
                title: Text(
                  'Daily Expense Prompt',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Receive a daily reminder to manually log any cash-based or unlinked expenses.',
                ),
              ),
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preferences saved.')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6EC1E4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

