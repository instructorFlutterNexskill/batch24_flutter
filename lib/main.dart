import 'package:abc/service/api_service.dart';
import 'package:abc/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'helpers/database_helper.dart';
import 'models/product_model.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // Load all items from the database
  void _loadItems() async {
    final items = await DBHelper.getItems();
    setState(() {
      _items = items;
    });
  }

  // Insert a new item
  void _insertItem() async {
    if (_nameController.text.isNotEmpty) {
      Map<String, dynamic> newItem = {
        'name': _nameController.text,
      };
      await DBHelper.insertItem(newItem);
      _loadItems(); // Refresh the list
      _nameController.clear();
    }
  }

  // Delete an item
  void _deleteItem(int id) async {
    await DBHelper.deleteItem(id);
    _loadItems(); // Refresh the list
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter Item Name'),
            ),
            ElevatedButton(
              onPressed: _insertItem,
              child: Text('Add Item'),
            ),
            CustomButton(
              text: 'Add Item',
              textColor: Colors.tealAccent,
              onTap: () {
                _insertItem;
              },

            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['name']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(_items[index]['id']);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProductListScreen(),
//     );
//   }
// }
//
// class ProductListScreen extends StatefulWidget {
//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }
//
// class _ProductListScreenState extends State<ProductListScreen> {
//   late Future<List<ProductElement>> futureProducts;
//
//   @override
//   void initState() {
//     super.initState();
//     futureProducts = ApiService().fetchProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: FutureBuilder<List<ProductElement>>(
//         future: futureProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final products = snapshot.data!;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   child: ListTile(
//                     leading: Image.network(product.thumbnail!),
//                     title: Text(product.title!),
//                     subtitle: Text(product.description!),
//                     trailing: Text('\$${product.price}'),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No products found.'));
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:abc/home_screen.dart';
// import 'package:flutter/material.dart';
//
// import 'navigation_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: HomeScreen(),
//       home: MyHomePage(
//         title: 'State Management',
//       ),
//     );
//   }
// }
//
// //
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             DrawerHeader(child: Text("data")),
//             ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text("Cold"),
//               trailing: Icon(Icons.arrow_circle_right_outlined),
//             ),
//             ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text("Cold"),
//               trailing: Icon(Icons.arrow_circle_right_outlined),
//             ),
//             ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text("Cold"),
//               trailing: Icon(Icons.arrow_circle_right_outlined),
//             ),
//             ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text("Cold"),
//               trailing: Icon(Icons.arrow_circle_right_outlined),
//             ),
//             ListTile(
//               leading: Icon(Icons.ac_unit),
//               title: Text("Cold"),
//               trailing: Icon(Icons.arrow_circle_right_outlined),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//
//           items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Colors.black,), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black,), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.notifications_active,color: Colors.black,), label: ""),
//         BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.black,), label: ""),
//       ]),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
