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
    final theme = Theme.of(context);
    
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("LOADING..."),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: theme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                "LOADING ITEM DATA...",
                style: theme.textTheme.bodyLarge?.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    if (item == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ERROR"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                "FAILED TO LOAD ITEM",
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "PLEASE TRY AGAIN LATER",
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item!.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item image card
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(12),
                  color: theme.cardColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: theme.scaffoldBackgroundColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          item!.imageUrl,
                          width: 116,
                          height: 116,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.inventory_2,
                              size: 60,
                              color: theme.primaryColor,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item!.name.toUpperCase(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Item details cards
            _buildInfoCard(
              context,
              "CATEGORY",
              item!.category.toUpperCase(),
              Icons.category,
            ),
            
            const SizedBox(height: 16),
            
            _buildInfoCard(
              context,
              "COST",
              item!.cost.toString() + " POKÉDOLLARS",
              Icons.monetization_on,
            ),
            
            const SizedBox(height: 16),
            
            _buildInfoCard(
              context,
              "EFFECT",
              item!.effect?.toUpperCase() ?? "NO EFFECT INFORMATION AVAILABLE",
              Icons.info,
              isLargeText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, 
    String title, 
    String content, 
    IconData icon,
    {bool isLargeText = false}
  ) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: theme.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: theme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
              color: theme.scaffoldBackgroundColor,
            ),
            child: Text(
              content,
              style: isLargeText 
                ? theme.textTheme.bodyLarge?.copyWith(
                    letterSpacing: 0.5,
                    height: 1.4,
                  )
                : theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
