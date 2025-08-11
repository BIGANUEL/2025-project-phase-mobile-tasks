import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final double price;
  final double rating;
  final String? imagePath;
  final String description;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    this.imagePath,
    required this.description,
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
      description:
          "The Timberland Classic 6-Inch Boot is the original waterproof boot built to withstand harsh weather while keeping your feet dry and comfortable. Made from premium full-grain waterproof leather with seam-sealed construction, these rugged yet refined boots feature a padded collar for enhanced comfort and ankle support, along with a durable rubber lug outsole for superior traction on all terrains. Designed with Timberland's commitment to sustainability, these boots incorporate recycled materials without compromising quality. The removable OrthoLite footbed provides all-day comfort with anti-fatigue technology, making them ideal for both outdoor adventures and urban wear.",
    ),
    Product(
      name: "Jordan 11",
      category: "Men's shoe",
      price: 100,
      rating: 4.5,
      imagePath: "assets/images/shoe2.png",
      description:
          "The Air Jordan 11 Retro is a legendary basketball sneaker that blends heritage design with modern performance. Originally released in 1995 and worn by Michael Jordan during his championship run, this iconic shoe features a sleek combination of patent leather and ballistic mesh for a bold yet refined look. A full-length Air-Sole unit provides responsive cushioning, while a carbon fiber shank and translucent rubber outsole offer stability and traction on and off the court. Known for its timeless silhouette and premium construction, the Jordan 11 remains a staple in both streetwear and sneaker culture, perfect for collectors, athletes, and style-conscious individuals alike.",
    ),
    Product(
      name: "Jordan 1",
      category: "Men's shoe",
      price: 95,
      rating: 4.0,
      imagePath: "assets/images/shoe3.png",
      description:
          "An icon born in 1985, the Air Jordan 1 revolutionized sneaker culture with its bold design and rebellious spirit. Originally banned by the NBA, its legacy only grew stronger, becoming a symbol of self-expression on and off the court. Featuring premium materials, a high-top silhouette, and the legendary Wings logo, the AJ1 blends heritage, style, and performance like no other. Timeless, versatile, and always in demand  it’s more than a sneaker, it’s a statement.",
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
                  Row(
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
                        child: IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline_outlined,
                            color: Colors.grey,
                            size: 19,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                  const SizedBox(width: 8),
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
                ],
              ),
              const SizedBox(height: 2),

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
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.grey),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: product,
                        );
                      },
                      child: Padding(
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        height: 240,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
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
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add');
          if (result != null && result is Product) {
            setState(() {
              products.add(result);
            });
          }
        },
        backgroundColor: const Color(0xFF3F51FF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 34, color: Colors.white),
      ),
    );
  }
}
