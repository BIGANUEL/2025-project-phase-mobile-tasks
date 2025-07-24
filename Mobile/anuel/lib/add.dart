import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Color(0xFF3F51FF),
                  ),
                  const SizedBox(width: 100),
                  const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image, size: 36, color: Colors.black54),
                    SizedBox(height: 16),
                    Text(
                      'upload image',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView(
                  children: [
                    const _InputField(label: 'name'),
                    const _InputField(label: 'category'),
                    const _InputField(label: 'Price',isPrice: true),
                    const _InputField(label: 'description', maxLines: 4),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: const Color(0xFF3F51FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "ADD", style: TextStyle(color: Colors.white),
                      ),
                    ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: (){}, 
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "DELETE", style: TextStyle(color: Colors.red
                      ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final int maxLines;
  final bool isPrice;

  const _InputField({required this.label, this.maxLines = 1, this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: isPrice ? TextInputType.number : TextInputType.text,
                    maxLines: maxLines,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                if (isPrice)
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Text("\$", style: TextStyle(fontSize: 16)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
