import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final double price;
  final double rating;
  final String? imagePath;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    this.imagePath,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = [
    Product(
      name: "Timberland",
      category: "Men's shoe",
      price: 120,
      rating: 5.0,
      imagePath: "assets/images/shoe1.jpg",
    ),
    Product(
      name: "Jordan 11",
      category: "Men's shoe",
      price: 100,
      rating: 4.5,
      imagePath: "assets/images/shoe2.png",
    ),
    Product(
      name: "Tshirt",
      category: "Men's T-Shirts",
      price: 95,
      rating: 4.0,
      imagePath: "assets/images/tshirt1.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "July 14, 2023",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: "Hello, ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: "Yohannes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.grey,
                            size: 19,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3F51FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 35),

              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: const Icon(Icons.search, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product List
              // Product List
Expanded(
  child: ListView.builder(
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];

      return Padding(
        padding: const EdgeInsets.only(bottom: 40), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imagePath!,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${product.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "(${product.rating})",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  ),
),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF3F51FF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 34, color: Colors.white),
      ),
    );
  }
}
