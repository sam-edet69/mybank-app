import 'package:flutter/material.dart';

void main() {
  runApp(BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTech Bank',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BankDashboard(),
    );
  }
}

class BankDashboard extends StatefulWidget {
  const BankDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BankDashboardState createState() => _BankDashboardState();
}

class _BankDashboardState extends State<BankDashboard> {
  double balance = 15000.00;
  List<String> transactions = [];

  void sendMoney(double amount, String recipient) {
    if (amount <= 0 || amount > balance) return;

    setState(() {
      balance -= amount;
      transactions.insert(0, 'Sent ₦$amount to $recipient');
    });
  }

  void showSendMoneyDialog() {
    final recipientController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Money'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: recipientController, decoration: InputDecoration(labelText: 'Recipient')),
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Send'),
            onPressed: () {
              final recipient = recipientController.text;
              final amount = double.tryParse(amountController.text) ?? 0;
              Navigator.pop(context);
              sendMoney(amount, recipient);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to FinTech Bank')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Account Balance', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('₦${balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Send Money'),
              onPressed: showSendMoneyDialog,
            ),
            SizedBox(height: 30),
            Text('Transaction History', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(transactions[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}