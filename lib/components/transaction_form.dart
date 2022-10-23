import 'package:expenses_project/components/adaptative/adaptative_datepicker.dart';

import './adaptative/adaptative_button.dart';
import './adaptative/adaptative_textfield.dart';

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    final title = _titleController.text;
    final value = _valueController.text;

    if (title.isEmpty || value.isEmpty || _selectedDate == null) return;

    widget.onSubmit(
      _titleController.text,
      double.parse(_valueController.text),
      _selectedDate!,
    );
  }

  _onDateChanged(DateTime? pickDate) {
    if (pickDate == null) return;
    setState(() {
      _selectedDate = pickDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 +
                  mediaQuery.viewInsets.bottom, // teclado cria espaço inferior
            ),
            child: Column(
              children: <Widget>[
                //...
                AdaptativeTextField(
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm,
                  label: 'Título',
                ),
                //...
                AdaptativeTextField(
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  label: 'Valor (R\$)',
                ),
                //...
                AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: _onDateChanged,
                ),
                //...
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: AdaptativeButton(
                        onPressed: _submitForm,
                        label: 'Nova Transação',
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
