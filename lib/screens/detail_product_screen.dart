import 'package:flutter/material.dart';
import 'package:velvet_app/models/product_model.dart';

class DetailProductScreen extends StatefulWidget {
  final ProductModel product;

  const DetailProductScreen({super.key, required this.product});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final TextEditingController searchController = TextEditingController();
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMethod(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              productImage(),

              // Product Title
              productTitle(),

              // Product Star, Rating, Review
              productStarRatingReview(),

              // Price & Quantity
              priceAndQuantity(),

              SizedBox(height: 15),

              // Product Size
              productSize(),

              SizedBox(height: 10),

              // Product Description
              productDescription(),

              // Bottom Bar Add To Cart & Buy Now
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Add To Cart
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red.shade500,
                    side: BorderSide(color: Colors.red.shade500),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10),

              // Buy Now
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Buy Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.red.shade200),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding productDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text(
            widget.product.description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Column productSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),

              // See All
              Text(
                'See All',
                style: TextStyle(color: Colors.red.shade400, fontSize: 16),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        // Size Options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: Text('EU 36.5')),
              SizedBox(width: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: Text('EU 37')),
              SizedBox(width: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: Text('EU 37.5')),
            ],
          ),
        ),
      ],
    );
  }

  Row priceAndQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Product Price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '\$${widget.product.price} USD',
            style: TextStyle(color: Colors.red.shade400, fontSize: 20),
          ),
        ),

        // Quantity
        Row(
          children: [
            // Decrement
            IconButton(
              onPressed: () {
                if (quantity > 0) {
                  setState(() {
                    quantity--;
                  });
                }
              },
              icon: Icon(
                Icons.remove_circle_outline,
                color: Colors.red.shade300,
                size: 30,
              ),
            ),

            // Quantity
            Text(
              quantity.toString(),
              style: TextStyle(fontSize: 20),
            ),

            // Increment
            IconButton(
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.red.shade300,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Padding productStarRatingReview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // star
          Icon(Icons.star, color: Colors.amber),

          // Rating
          Text(
            '4.9 | ',
            style: TextStyle(fontSize: 16),
          ),

          // Review
          Text(
            '50 reviews',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Padding productTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        widget.product.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  SizedBox productImage() {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: widget.product.images.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.product.images[index],
            fit: BoxFit.cover,
            width: double.infinity,
          );
        },
      ),
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      title: TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'What are you looking for?',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width > 600
                ? 18
                : 14, // Responsive hint text
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
      ],
    );
  }
}
