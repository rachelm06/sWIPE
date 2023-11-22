import 'package:flutter/material.dart';

void main() {
  runApp(const Swipe());
}

class Swipe extends StatelessWidget {
  const Swipe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CustomAppBar(),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'sWipe',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          )),
      body: ToiletCard(toilet: Toilet.toilets[0]),
    );
  }
}

class ToiletCard extends StatelessWidget {
  final Toilet toilet;
  const ToiletCard({
    Key? key,
    required this.toilet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.height,
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
                ])),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter))),
            Positioned(
              bottom: 30,
              left: 30,
              child: Column(children: [
                Text('${toilet.location}, ${toilet.rating} ⭐',
                    style: const TextStyle(color: Colors.white, fontSize: 25))
              ]),
            )
          ])),
    );
  }
}

class Toilet {
  String imageURL;
  double rating;
  String location;
  Toilet(
      {required this.imageURL, required this.rating, required this.location});
  static List<Toilet> toilets = [
    Toilet(
        imageURL:
            'https://static01.nyt.com/images/2022/10/24/multimedia/24ny-subway-bathroom-1-08f6/24ny-subway-bathroom-1-08f6-mediumSquareAt3X.jpg',
        rating: 3.7,
        location: 'Subway')
  ];
}
