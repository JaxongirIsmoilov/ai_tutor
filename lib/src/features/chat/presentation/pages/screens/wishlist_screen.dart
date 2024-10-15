import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Wishlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text("On Progress", style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30
        ),),
      ),
    );
  }
}
