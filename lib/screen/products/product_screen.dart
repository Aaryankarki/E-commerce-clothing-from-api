import 'package:ecommerce/Widget/reuse_product_card.dart';

import 'package:ecommerce/model/product.dart';

import 'package:ecommerce/services/api_helper.dart';
import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> products = [];

//   void onProduct() async {
//     final dio = Dio();
//     try {
//       final response = await dio.get("$base_api/products");

//       if (response.statusCode == 200 && response.data is List) {
//         setState(() {
//           products = List<Map<String, dynamic>>.from(response.data);
//         });
//       }

//       log(response.data.toString());
//     } catch (e) {
//       log("Unsuccessful ${e.toString()}");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     onProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Products")),
//       body:
//           products.isEmpty
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return Card(
//                     margin: const EdgeInsets.all(8),
//                     child: ListTile(
//                       leading: Image.network(
//                         product["image"],
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),

//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product["title"],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(product["description"]),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addProduct();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _addProduct() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return AddProducts();
//         },
//       ),
//     );
//   }
// }
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductResModel>> _productFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productFuture = ApiHelper.getProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-commerce"),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder<List<ProductResModel>>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error occured"));
          }
          if (snapshot.data == null && !snapshot.hasData) {
            return Center(child: Text("no data"));
          }
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintText: "Search the products",
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data == null) {
                      return SizedBox();
                    }
                    final product = snapshot.data![index];
                    return ProductCardReusable(product: product);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _productFuture = ApiHelper.getProduct(context);
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
