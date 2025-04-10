import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  String _type = 'Expense'; // default
  bool loading = false;

  void _submitForm() async {
    setState(() {
      loading = true;
    });

    if (_formKey.currentState!.validate()) {
      final message = _messageController.text.trim();
      final value = double.parse(_valueController.text.trim());

      double? newBalance = await makeTransaction(
        message,
        _type.toUpperCase(),
        value,
      );

      if (newBalance == null) return;
      Navigator.pop(context, newBalance);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Type dropdown
            DropdownButtonFormField<String>(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'Expense', child: Text('Expense')),
                DropdownMenuItem(value: 'Income', child: Text('Income')),
              ],
              decoration: const InputDecoration(
                labelText: 'Transaction Type',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _type = value!);
              },
            ),
            const SizedBox(height: 16),

            // Value
            TextFormField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an amount';
                }
                final parsed = double.tryParse(value);
                if (parsed == null || parsed <= 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Message Field that grows
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Scrollbar(
                child: TextFormField(
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // ⬅ makes it grow
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ActionButton(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ElevatedButton ActionButton() {
    return ElevatedButton(
      onPressed: !loading ? _submitForm : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child:
          loading
              ? Loader()
              : Text(
                "Submit",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: 1.8,
                ),
              ),
    );
  }
}
