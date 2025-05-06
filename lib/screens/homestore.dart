import 'package:flutter/material.dart';

class ShoeStore extends StatefulWidget {
  const ShoeStore({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoeStoreState createState() => _ShoeStoreState();
}

class _ShoeStoreState extends State<ShoeStore> {
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> shoes = [
    {"name": "Nike Air Max", "price": 120.0, "image": "assets/imgs/giay.png"},
    {"name": "Nike Air Max2", "price": 120.0, "image": "assets/imgs/giay.png"},
    {"name": "Nike Air Max3", "price": 120.0, "image": "assets/imgs/giay.png"},
    {"name": "Nike Air Max4", "price": 120.0, "image": "assets/imgs/giay.png"},
    {"name": "Nike Air Max5", "price": 120.0, "image": "assets/imgs/giay.png"},
    {
      "name": "Adidas Ultraboost",
      "price": 150.0,
      "image": "assets/imgs/giay.png",
    },
    {"name": "Puma RS-X", "price": 100.0, "image": "assets/imgs/giay.png"},
  ];

  void addToCart(Map<String, dynamic> shoe) {
    setState(() {
      int index = cartItems.indexWhere((item) => item["name"] == shoe["name"]);
      if (index >= 0) {
        cartItems[index]["quantity"]++;
      } else {
        cartItems.add({
          "name": shoe["name"],
          "price": shoe["price"],
          "image": shoe["image"],
          "quantity": 1,
        });
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  double getTotal() {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item["price"] * item["quantity"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoe Store", style: TextStyle(fontSize: 32)),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      cartItems[index]["image"],
                      width: 50,
                      height: 50,
                    ),
                    title: Text(cartItems[index]["name"]),
                    subtitle: Text("Giá: \$${cartItems[index]["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Số lượng: ${cartItems[index]["quantity"]}"),
                        IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () => removeFromCart(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng tiền: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 4, 4, 4),
                  ),
                ),
                Text(
                  "\$${getTotal().toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 194, 2, 2),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Danh sách giày",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shoes.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 210,
                  child: Card(
                    shadowColor: Colors.blue,
                    elevation: 10,
                    color: Colors.blueGrey,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          shoes[index]["image"],
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        Text(shoes[index]["name"]),
                        Text("Giá: \$${shoes[index]["price"]}"),
                        ElevatedButton(
                          child: Text("Thêm vào giỏ"),
                          onPressed: () => addToCart(shoes[index]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
