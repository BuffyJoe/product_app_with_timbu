import 'package:flutter/material.dart';
import 'product_model.dart';
import 'http_request.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white, 
          shadowColor: Colors.white, 
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
          )
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<ProductResponse> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('PUP STOP', 
                  style: TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 23
                    ),
                  ),
                centerTitle: true,
                leading: Icon(Icons.home),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder<ProductResponse>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                    height :400, 
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Please wait while the products are loading....',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('An Error occured, please try again later...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),));
            } else if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
              return Center(child: Text('No products found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.items.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data!.items[index];
                  var imageUrl = product.photos.isNotEmpty ? 'https://api.timbu.cloud/images/${product.photos[0].url}' : null;
      
                 var currentPrice = '';
      if (product.currentPrice != null && product.currentPrice!.isNotEmpty) {
        String priceString = product.currentPrice![0].toString();
        int commaIndex = priceString.indexOf(',');
        if (commaIndex != -1) {
          currentPrice = priceString.substring(1, commaIndex);
        } else {
          currentPrice = priceString.substring(1); // Handle case where no comma is found
        }
      }
      
      
                  return Card(
                    elevation: 8,
                    child: Container(
                      width: width * .87,
                      height: height * .25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          imageUrl != null
                              ? Container(
                                  width: width * .5,
                                  height: height * .25,
                                  child: Image.network(imageUrl, fit: BoxFit.fill,))
                              : Container(
                                  width: width * .5,
                                  height: height * .25,
                                  color: Colors.grey,
                                  child: Icon(Icons.image_not_supported),
                                ),
                          Container(
                            height: height * .25,
                            width: width * .45,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.description ?? '',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '$currentPrice]',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
