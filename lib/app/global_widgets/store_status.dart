import 'package:app_hortifruti/app/data/model/store.dart';
import 'package:flutter/material.dart';

class StoreStatus extends StatelessWidget {
  const StoreStatus({super.key, required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: store.isOnline ? Colors.green : Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          store.isOnline ? 'Aberto' : 'Fechado',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
