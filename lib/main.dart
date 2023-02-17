import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/data/repository/products_repository.dart';
import 'package:shopping_cart/presentation/products/products_screen.dart';

import 'data/repository/cart_repository.dart';
import 'presentation/routes.dart';
import 'utils/statics.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();
  box = await Hive.openBox('shopping-cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsRepository()),
        ChangeNotifierProvider(create: (_) => CartRepository()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
        ),
        routes: Routes.routes,
      ),
    );
  }
}
