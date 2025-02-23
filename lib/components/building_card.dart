import 'package:flutter/material.dart';

class BuildingCard extends StatelessWidget {
  final String name;
  final String type;
  final bool hasActiveProduction;
  final VoidCallback onProductionTap;

  const BuildingCard({
    super.key,
    required this.name,
    required this.type,
    required this.hasActiveProduction,
    required this.onProductionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              type,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasActiveProduction)
                    const Text(
                      "Current Productions List",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (hasActiveProduction)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("output a/x"),
                        Text("done at 00:00"),
                      ],
                    ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onProductionTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          hasActiveProduction
                              ? "Show Productions"
                              : "Start new Production",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.factory, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
