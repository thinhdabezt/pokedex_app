import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';
import '../models/item.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemName;
  const ItemDetailScreen({super.key, required this.itemName});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final api = PokeApiService();
  Item? item;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    try {
      final i = await api.fetchItemDetail(widget.itemName);
      setState(() {
        item = i;
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
    if (item == null) {
      return const Scaffold(
        body: Center(child: Text("Failed to load item")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(item!.name.toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(item!.imageUrl, height: 100, width: 100,  fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text("Category: ${item!.category}", style: const TextStyle(fontSize: 16)),
            Text("Cost: ${item!.cost}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text("Effect: ${item!.effect ?? "No effect info"}"),
          ],
        ),
      ),
    );
  }
}
