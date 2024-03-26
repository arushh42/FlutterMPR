import 'package:flutter/material.dart';
import 'admin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronic Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'Customer'; // Default value

  void _login(BuildContext context) {
    // Validate login credentials
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Simulate login logic
      if (_selectedUserType == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomerPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter username and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              items: ['Customer', 'Admin']
                  .map((userType) => DropdownMenuItem(
                        value: userType,
                        child: Text(userType),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUserType = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage()), // Navigate to sign-up page
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedUserType = 'Customer'; // Default value

  void _signUp(BuildContext context) {
    // Validate form fields
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _isValidPassword(_passwordController.text)) {
      // Simulate sign up logic
      if (_selectedUserType == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomerPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid information.'),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    // Basic email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Password validation: at least one number and one special character
    return RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              items: ['Customer', 'Admin']
                  .map((userType) => DropdownMenuItem(
                        value: userType,
                        child: Text(userType),
                      ))
                  .toList(),
              onChanged: (value) {
                _selectedUserType = value!;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (!_isValidEmail(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Product> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    // Initialize selected products with dummy data
    selectedProducts = [
      Product(
        name: 'Headphones',
        price: 23,
        description: 'High-quality headphones for immersive audio experience.',
      ),
      Product(
        name: 'Android Smartphone',
        price: 179,
        description:
            'Powerful smartphone with advanced features and sleek design.',
      ),
      Product(
        name: 'Phone case',
        price: 13,
        description: 'Protective case with stylish design for your smartphone.',
      ),
      Product(
        name: 'Adapter',
        price: 20,
        description: 'Versatile adapter for connecting various devices.',
      ),
      Product(
        name: 'Mouse',
        price: 39,
        description: 'Ergonomic mouse for precise and comfortable navigation.',
      ),
      Product(
        name: 'Gaming keyboard',
        price: 56,
        description: 'Mechanical keyboard with customizable RGB lighting.',
      ),
      Product(
        name: 'Laptop Cover',
        price: 17,
        description: 'Durable cover to keep your laptop safe during transport.',
      ),
      Product(
        name: 'Fitness Band',
        price: 88,
        description:
            'Track your fitness goals with this stylish and reliable fitness band.',
      ),
      Product(
        name: 'Charger',
        price: 29,
        description: 'Fast charger for quickly powering up your devices.',
      ),
      Product(
        name: 'Wireless Earbuds',
        price: 45,
        description:
            'True wireless earbuds with crystal clear sound and comfortable fit.',
      ),
      Product(
        name: 'Smartwatch',
        price: 99,
        description:
            'Stay connected and organized with this feature-rich smartwatch.',
      ),
      Product(
        name: 'Bluetooth Speaker',
        price: 65,
        description: 'Portable speaker for enjoying music anywhere you go.',
      ),
      Product(
        name: 'USB-C Cable',
        price: 10,
        description:
            'High-speed USB-C cable for fast data transfer and charging.',
      ),
      Product(
        name: 'External Hard Drive',
        price: 79,
        description:
            'Expand your storage capacity with this reliable external hard drive.',
      ),
      Product(
        name: 'Wireless Mouse',
        price: 25,
        description: 'Wireless mouse for enhanced productivity and comfort.',
      ),
      Product(
        name: 'Portable Power Bank',
        price: 30,
        description: 'Compact power bank for charging your devices on the go.',
      ),
      Product(
        name: 'Smart Light Bulbs',
        price: 15,
        description:
            'Energy-efficient smart bulbs for customizable lighting control.',
      ),
      Product(
        name: 'Travel Backpack',
        price: 50,
        description:
            'Durable backpack designed for travel and outdoor adventures.',
      ),
      Product(
        name: 'Wireless Charging Pad',
        price: 20,
        description:
            'Convenient wireless charging pad for Qi-compatible devices.',
      ),
    ];
  }

  void addToCart(Product product) {
    setState(() {
      product.isAddedToCart = true;
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      product.isAddedToCart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronics'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the shopping cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    selectedProducts: selectedProducts,
                    onRemove: (product) {
                      removeFromCart(product);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              _getGridCount(context), // Adjust grid count based on screen width
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          return AnimatedProductCard(
            // Add animation to product card
            product: selectedProducts[index],
            onPressed: () {
              addToCart(selectedProducts[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added to cart')),
              );
            },
          );
        },
      ),
    );
  }

  // Determine the number of grid columns based on screen width
  int _getGridCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth ~/ 150; // Adjust the column width based on screen size
  }
}

// Custom animated product card widget
class AnimatedProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onPressed;

  AnimatedProductCard({
    required this.product,
    required this.onPressed,
  });

  @override
  _AnimatedProductCardState createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Price: \$${widget.product.price}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  ' ${widget.product.description}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Product {
  final String name;
  final double price;
  final String description;
  bool isAddedToCart;

  Product({
    required this.name,
    required this.price,
    required this.description,
    this.isAddedToCart = false,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ProductCard({
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                // Placeholder image
                color: Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4.0),
                      Text('Description: ${product.description}'),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8.0)),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> selectedProducts;
  final Function(Product) onRemove;

  CartPage({required this.selectedProducts, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    // Filter out products that have not been added to the cart
    List<Product> cartProducts =
        selectedProducts.where((product) => product.isAddedToCart).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartProducts[index].name),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () => onRemove(cartProducts[index]),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Order Summary page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderSummaryPage(selectedProducts: cartProducts),
                ),
              );
            },
            child: Text('Buy Now'),
          ),
        ),
      ),
    );
  }
}

class OrderSummaryPage extends StatelessWidget {
  final List<Product> selectedProducts;

  OrderSummaryPage({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        selectedProducts.fold(0, (prev, product) => prev + product.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Place order logic
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
