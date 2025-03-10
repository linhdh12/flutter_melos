
import 'package:flutter/material.dart';
import 'package:home/domain/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntities productEntities;
  const ProductWidget({super.key, required this.productEntities});

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(productEntities.imageUrl),
            fit: BoxFit.cover, // Sử dụng cover để ảnh phủ kín container
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(height: 10),
      Text(
        productEntities.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 5),
      Text(
        productEntities.description,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey.shade600,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${productEntities.price.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.green.shade700,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Xử lý khi nhấn nút yêu thích
                },
                icon: Icon(Icons.favorite_outline, color: Colors.grey.shade600),
              ),
              IconButton(
                onPressed: () {
                  // Xử lý khi nhấn nút giỏ hàng
                },
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);

  }
}