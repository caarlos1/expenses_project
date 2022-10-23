import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime?) onDateChanged;

  const AdaptativeDatePicker(
      {required this.selectedDate, required this.onDateChanged, super.key});

  _showDataPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      onDateChanged(pickDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 120,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(2019),
                maximumDate: DateTime.now(),
                onDateTimeChanged: onDateChanged,
              ),
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada: ${DateFormat('dd/M/y').format(selectedDate!)}'),
                ),
                TextButton(
                  onPressed: () => _showDataPicker(context),
                  child: Text('Selecionar Data',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
            ),
          );
  }
}
