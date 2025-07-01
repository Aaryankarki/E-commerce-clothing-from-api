import 'package:ecommerce/Widget/reuse_product_card.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/services/api_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductResModel>> _productFuture;
  late Future<List<String>> _categoryFuture;
  List<ProductResModel> lstProduct = [];
  List<ProductResModel> _lstSearchProduct = [];
  bool _isSearch = false;
  String _searchKeyword = "";

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    _productFuture = ApiHelper.getProduct(context);
    _categoryFuture = ApiHelper.getAllCategories(context);
  }

  void _loadByCategory(String category) {
    setState(() {
      _isSearch = false;
      _searchKeyword = "";
      searchController.clear();
      _productFuture = ApiHelper.getProductsByCategory(context, category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-commerce"),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: _isSearch ? _lstSearchWidget() : _productListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isSearch = false;
            _searchKeyword = "";
            searchController.clear();
            _loadInitialData();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _lstSearchWidget() {
    searchController.text = _searchKeyword;

    return Column(
      children: [
        _buildSearchBar(showFilterButton: false),
        SizedBox(height: 20),
        Expanded(
          child:
              _lstSearchProduct.isEmpty
                  ? Center(child: Text("No products found"))
                  : GridView.builder(
                    itemCount: _lstSearchProduct.length,
                    itemBuilder: (context, index) {
                      final product = _lstSearchProduct[index];
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
  }

  Widget _productListWidget() {
    return FutureBuilder<List>(
      future: Future.wait([_productFuture, _categoryFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error occurred"));
        }
        if (snapshot.data == null || !snapshot.hasData) {
          return Center(child: Text("No data"));
        }

        lstProduct = snapshot.data![0];
        List<String> categories = snapshot.data![1];

        return Column(
          children: [
            _buildSearchBar(showFilterButton: true, categories: categories),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: lstProduct.length,
                itemBuilder: (context, index) {
                  final product = lstProduct[index];
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
    );
  }

  Widget _buildSearchBar({
    required bool showFilterButton,
    List<String>? categories,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (keyword) {
                setState(() {
                  _searchKeyword = keyword;
                  if (keyword.isEmpty) {
                    _isSearch = false;
                    _lstSearchProduct = [];
                  } else {
                    _isSearch = true;
                    _lstSearchProduct =
                        lstProduct
                            .where(
                              (product) => product.title.toLowerCase().contains(
                                keyword.toLowerCase(),
                              ),
                            )
                            .toList();
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                hintText: "Search the products",
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          if (showFilterButton) ...[
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                if (categories != null) {
                  _showCategoryFilter(context, categories);
                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Icon(Icons.filter_list, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showCategoryFilter(BuildContext ctx, List<String> lstCategories) {
    showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.amber,
      context: ctx,
      builder:
          (ctx) => Container(
            height: 250,
            color: Colors.white54,
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: lstCategories.length,
              itemBuilder: (context, index) {
                String category = lstCategories[index];
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _loadByCategory(category);
                  },
                  title: Text(category),
                  leading: Icon(Icons.shopping_bag_outlined),
                );
              },
            ),
          ),
    );
  }
}
