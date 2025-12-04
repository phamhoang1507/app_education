import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            // Mở Drawer hoặc menu
          },
        ),
        actions: [
          // 🔔 Nút thông báo có badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                print('noti');
              },
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -6, end: -4),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFF9547ED), // tím nhạt
                  padding: EdgeInsets.all(5),
                ),
                badgeContent: const Text(
                  '5',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12, left: 4),
            child: GestureDetector(
              onTap: () {
                print('cart');
                context.go('/login');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        border: const OutlineInputBorder(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 1,
                                height: 24,
                                color: Colors.grey,
                                margin: const EdgeInsets.only(right: 8.0),
                              ),
                              SvgPicture.asset(
                                'assets/images/adjustments-horizontal.svg',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}