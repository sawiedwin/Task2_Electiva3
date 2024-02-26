import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Recipe {
  final String title;
  final String imageUrl;
  final String description;

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.description,
  });
}

class MyApp extends StatelessWidget {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Tarta de Manzana',
      imageUrl: 'https://www.eltiempo.com/files/article_main_1200/uploads/2023/03/09/640a0d80008f8.jpeg',
      description: 'Una deliciosa tarta de manzana casera.',
    ),
    Recipe(
      title: 'Espaguetis Carbonara',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzZ1Xgsk26OkhebdhWlxRh8UKsr6k2nUQKm8TtdQyIxA&s',
      description: 'Espaguetis con una cremosa salsa carbonara.',
    ),
    Recipe(
      title: 'Ensalada César',
      imageUrl: 'https://www.gourmet.cl/wp-content/uploads/2016/09/Ensalada_C%C3%A9sar-web-553x458.jpg',
      description: 'Una fresca ensalada César con pollo a la parrilla.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(recipes: recipes),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Recipe> recipes;

  MyHomePage({required this.recipes});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? Text('Mis Recetas', textAlign: TextAlign.center)
            : _selectedIndex == 2
                ? Text('Configuraciones', textAlign: TextAlign.center)
                : Text('Recetas App'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menú'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Recetas'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.pop(context); // Cerrar el Drawer
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? Center(
              child: Text('Mis Recetas', style: TextStyle(fontSize: 24)),
            )
          : _selectedIndex == 1
              ? ListView.builder(
                  itemCount: widget.recipes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.recipes[index].imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(widget.recipes[index].title),
                      subtitle: Text(widget.recipes[index].description),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailsPage(recipe: widget.recipes[index]),
                          ),
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: Text('Configuraciones', style: TextStyle(fontSize: 24)),
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            recipe.imageUrl,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            recipe.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              recipe.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
