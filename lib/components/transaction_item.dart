import 'dart:math';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.mediaQuery,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final MediaQueryData mediaQuery;
  final void Function(String id) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final colors = [
    Colors.blue,
    Colors.purple,
    Colors.red,
    Colors.black,
    Colors.green,
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    setState(() {
      _backgroundColor = colors[Random().nextInt(colors.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(widget.tr.date),
        ),
        trailing: widget.mediaQuery.size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.onRemove(widget.tr.id),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
