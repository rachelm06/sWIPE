import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

void main() {
  runApp(const Swipe());
}

class Swipe extends StatelessWidget {
  const Swipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sWIPE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          color: Colors.green, // Your AppBar background color
          titleTextStyle: TextStyle(
            color: Colors.white, // Set the AppBar title text color to white
            fontSize: 20, // You can adjust the font size as needed
            fontWeight: FontWeight.bold, // Optional: add font weight if you like
          ),
        ),
        useMaterial3: true,
      ),
      home: const ToiletSwiper(),
    );
  }
}

class ToiletSwiper extends StatefulWidget {
  const ToiletSwiper({super.key});

  @override
  _ToiletSwiperState createState() => _ToiletSwiperState();
}

class _ToiletSwiperState extends State<ToiletSwiper> {
  final List<Toilet> favorites = [];

  void showDetails(Toilet toilet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(toilet.location),
        content: Text(toilet.review),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void addToFavorites(Toilet toilet) {
    if (!favorites.contains(toilet)) {
      setState(() {
        favorites.add(toilet);
      });
    }
  }

  void showRating(Toilet toilet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rating'),
        content: Text('${toilet.rating} ⭐'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritesPage(favorites: favorites)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sWIPE'),
        centerTitle: true,
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          final toilet = Toilet.toilets[index];
          return GestureDetector(
            onTap: () => showDetails(toilet),
            onDoubleTap: () => addToFavorites(toilet),
            onLongPress: () => showRating(toilet),
            child: ToiletCard(toilet: toilet),
          );
        },
        itemCount: Toilet.toilets.length,
        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
        layout: SwiperLayout.STACK,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToFavorites,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}

class ToiletCard extends StatelessWidget {
  final Toilet toilet;

  const ToiletCard({Key? key, required this.toilet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 10, // Adjusted height
            width: MediaQuery.of(context).size.width - 40,// This might need adjustment
            child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(toilet.imageURL)),
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: const Offset(3, 3),
                            )
                        ]),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: const LinearGradient(
                            colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                ),
                Positioned(
                    bottom: 30,
                    left: 30,
                    child: Text(
                        '${toilet.location}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 8.0,
                                    color: Color.fromARGB(125, 0, 0, 255),
                                ),
                            ],
                        ),
                    ),
                )
            ]),
        ),
    );
  }
}


class Toilet {
  final String imageURL;
  final double rating;
  final String location;
  final String review;

  Toilet({
    required this.imageURL,
    required this.rating,
    required this.location,
    required this.review,
  });

  static List<Toilet> toilets = [
    Toilet(
      imageURL: 'https://static01.nyt.com/images/2022/10/24/multimedia/24ny-subway-bathroom-1-08f6/24ny-subway-bathroom-1-08f6-mediumSquareAt3X.jpg',
      rating: 4.2,
      location: 'Downtown Cafe',
      review: 'Clean and well-maintained.',
    ),
    Toilet(
      imageURL: 'https://static01.nyt.com/images/2022/12/28/multimedia/28restaurant-bathrooms2-1-8b25/22restaurant-bathrooms2-1-8b25-superJumbo.jpg?quality=75&auto=webp',
      rating: 3.5,
      location: 'Mall Restroom',
      review: 'Spacious but a bit crowded.',
    ),
    // Add more toilets here
  ];
}

class FavoritesPage extends StatelessWidget {
  final List<Toilet> favorites;

  const FavoritesPage({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final toilet = favorites[index];
          return ListTile(
            title: Text(toilet.location),
            subtitle: Text('Rating: ${toilet.rating} ⭐\n${toilet.review}'),
            onTap: () {
              // Implement tap action if needed
            },
          );
        },
      ),
    );
  }
}
