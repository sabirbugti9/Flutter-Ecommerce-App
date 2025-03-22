import 'package:flutter/material.dart';
import 'package:velvet_app/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  const ProductWidget({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            // Product Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 40);
                  },
                ),
              ),
            ),

            /* New Label
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 20,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text('New!',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
            */
            // Favorite Icon
            Positioned(
              top: 115,
              right: 5,
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.favorite_border,
                  size: 24,
                ),
              ),
            ),

            // Product Name
            Positioned(
              bottom: 12,
              right: 5,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),

                  // Poduct Price After Discount
                  Text('\$${product.price}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                  // Product Discount
                  Row(
                    children: [
                      // Discount Percent
                      Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 222, 233),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '6%',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Product Price Before Discount
                      Text(
                        product.price.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),

                  // Product Star, Rating & Sold
                  Row(
                    children: [
                      // Product Star
                      Icon(Icons.star, color: Colors.amber),

                      SizedBox(width: 5),

                      // Product Rating
                      Text(
                        '4.9',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                      ),

                      SizedBox(width: 5),

                      // Product Sold
                      Text(
                        '56 Sold',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                      ),
                    ],
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
