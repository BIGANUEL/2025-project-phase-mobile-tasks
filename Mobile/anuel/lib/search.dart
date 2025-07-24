import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final double rating;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.rating,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  final TextEditingController categoryController = TextEditingController();
  RangeValues priceRange = const RangeValues(0, 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF3F51FF)),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Search Product",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Search Field and Filter Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Leather",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: Color(0xFF3F51FF),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F51FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list_sharp, color: Colors.white, size: 26),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 34),

            // Product List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ProductCard(product: products[index]),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),

            // Filter Section (Category, Price, Apply Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Price",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      activeTrackColor: const Color(0xFF3F51FF),
                      inactiveTrackColor: Colors.grey[300],
                      thumbColor: const Color(0xFF3F51FF),
                      overlayColor: const Color(0xFF3F51FF).withOpacity(0.2),
                    ),
                    child: RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 200,
                      onChanged: (RangeValues values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F51FF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Apply filter logic can go here
                      },
                      child: const Text(
                        "APPLY",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              product.imagePath,
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Name and Category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.category,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                // Right: Price and Rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "(${product.rating})",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
