import 'package:flutter/material.dart';

class TransactionHistoryTile extends StatelessWidget {
  final image_url;
  final name;
  final date;
  final amount;



  const TransactionHistoryTile({
    Key? key,
    required this.image_url,
    required this.name,
    required this.date,
    required this.amount,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image_url),
        radius: 20,
      ),
      title: Text(
        '${name}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('${date}'),
      trailing: Text(
        'D ${amount}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: 100 < 0 ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
