import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screen/products/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductCardReusable extends StatelessWidget {
  const ProductCardReusable({super.key, required this.product});

  final ProductResModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.network(product.image, height: 100, width: 100),
            CachedNetworkImage(
              height: 100,
              width: 100,
              imageUrl: product.image,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) => CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10),
            Text(
              "${product.title}}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${product.price}"),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
