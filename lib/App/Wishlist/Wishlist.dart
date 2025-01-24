import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';
// If you want to use line_icons, add this

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Category Tags (like the "swiper" in HTML)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _buildCategoryTag('All', true),
                    _buildCategoryTag('Child', false),
                    _buildCategoryTag('Man', false),
                    _buildCategoryTag('Woman', false),
                    _buildCategoryTag('Dress', false),
                    _buildCategoryTag('Unisex', false),
                  ],
                ),
              ),
            ),
            // Wishlist Items (using GridView for 2 items per row)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true, // Allow GridView to take only required space
                physics: NeverScrollableScrollPhysics(), // Disable internal scroll of GridView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10, // Space between columns
                  mainAxisSpacing: 10, // Space between rows
                  childAspectRatio: 0.7, // Aspect ratio for items
                ),
                itemCount: 4, // Number of wishlist items
                itemBuilder: (context, index) {
                  return _buildWishlistItem(
                    imageUrl: 'assets/images/products/${index-1 + 10}.png',
                    title: 'bluebell hand block tiered dress',
                    price: 80.0,
                    originalPrice: 95.0,
                    rating: 2000,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category Tag Widget
  Widget _buildCategoryTag(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isActive ? Colors.blue : Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Wishlist Item Widget
  Widget _buildWishlistItem({
    required String imageUrl,
    required String title,
    required double price,
    required double originalPrice,
    required int rating,
  }) {
    return Container(
      child: Column(
        children: <Widget>[
          // Product Image and Add to Cart Button
          Stack(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 200, // Adjust this height for better scaling
                  fit: BoxFit.cover,
                ),
              ),
              // Close Icon Overlay
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              // Add to Cart Button
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text('Add To Cart', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Product Details
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title and Link
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Price and Original Price
                Row(
                  children: <Widget>[
                    Text('\$$price', style: TextStyle(fontSize: 14, color: Colors.green)),
                    SizedBox(width: 5),
                    Text('\$$originalPrice', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough)),
                  ],
                ),
                SizedBox(height: 5),
                // Rating
                Row(
                  children: <Widget>[
                    Icon(Icons.star, size: 16, color: Colors.yellow),
                    Text('($rating Reviews)', style: TextStyle(fontSize: 12)),
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
