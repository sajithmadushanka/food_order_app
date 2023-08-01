import 'package:flutter/material.dart';

class MyShopItemCard extends StatelessWidget {
  final String name;
  final String price;
  final String url;
  const MyShopItemCard(
      {super.key, required this.name, required this.price, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.amber),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 80,
                width: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 2),
                Text(price, style: const TextStyle(fontSize: 16)),
              ],
            )
          ],
        ));
  }
}
