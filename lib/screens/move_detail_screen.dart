import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';
import '../models/move.dart';
import '../utils/type_colors.dart';

class MoveDetailScreen extends StatefulWidget {
  final String moveName;
  const MoveDetailScreen({super.key, required this.moveName});

  @override
  State<MoveDetailScreen> createState() => _MoveDetailScreenState();
}

class _MoveDetailScreenState extends State<MoveDetailScreen> {
  final api = PokeApiService();
  Move? move;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMove();
  }

  Future<void> _loadMove() async {
    try {
      final m = await api.fetchMoveDetail(widget.moveName);
      setState(() {
        move = m;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (move == null) {
      return const Scaffold(
        body: Center(child: Text("Failed to load move")),
      );
    }

    final color = typeColors[move!.type] ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(title: Text(move!.name.toUpperCase()), backgroundColor: color),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${move!.type}", style: const TextStyle(fontSize: 16)),
            Text("Damage Class: ${move!.damageClass}", style: const TextStyle(fontSize: 16)),
            if (move!.power != null) Text("Power: ${move!.power}"),
            if (move!.pp != null) Text("PP: ${move!.pp}"),
            if (move!.accuracy != null) Text("Accuracy: ${move!.accuracy}%"),
            const SizedBox(height: 16),
            Text("Effect: ${move!.effect ?? "No effect info"}"),
          ],
        ),
      ),
    );
  }
}
