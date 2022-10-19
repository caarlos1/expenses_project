import 'dart:math';
import 'package:expenses_project/components/chart.dart';
import 'package:flutter/material.dart';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo as orientações do App
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final ThemeData theme = ThemeData(
      fontFamily: 'OpenSans',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
    );

    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber[700]),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't0',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't6',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't7',
    //   title: 'Muita coisa...',
    //   value: 350.60,
    //   date: DateTime.now().subtract(const Duration(days: 3)),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    setState(() {
      _transactions.add(
        Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: value,
          date: date,
        ),
      );
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => TransactionForm(_addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
              onPressed: () => {setState(() => _showChart = !_showChart)},
              icon: Icon(_showChart ? Icons.list : Icons.show_chart)),
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add)),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape) // funny ;D
              SizedBox(
                height: availableHeight * (isLandscape ? 0.75 : 0.3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chart(_recentTransactions),
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: TransactionList(_transactions, _removeTransaction),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
