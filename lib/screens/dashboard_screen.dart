import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(31, 229, 255, 1),
              Color.fromARGB(255, 29, 57, 235)
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 5 / 5,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [
                  AssetImage(
                      'assets/bus3.png'), // Menggunakan AssetImage untuk gambar dari asset lokal
                ].map((asset) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image(
                            image: asset,
                            fit: BoxFit
                                .cover), // Menggunakan Image dengan AssetImage
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/booking');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Perubahan warna pada tombol
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Pesan Tiket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tiket'),
      ),
      body: Center(
        child: Text('Ini adalah halaman selanjutnya'),
      ),
    );
  }
}

class CarouselSlider extends StatelessWidget {
  final CarouselOptions options;
  final List<Widget> items;

  CarouselSlider({required this.options, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: options.height,
      child: PageView.builder(
        itemCount: items.length,
        controller: PageController(viewportFraction: options.viewportFraction),
        itemBuilder: (BuildContext context, int itemIndex) {
          return items[itemIndex];
        },
      ),
    );
  }
}

class CarouselOptions {
  final double height;
  final bool enlargeCenterPage;
  final bool autoPlay;
  final double aspectRatio;
  final Curve autoPlayCurve;
  final bool enableInfiniteScroll;
  final Duration autoPlayAnimationDuration;
  final double viewportFraction;

  CarouselOptions({
    required this.height,
    required this.enlargeCenterPage,
    required this.autoPlay,
    required this.aspectRatio,
    required this.autoPlayCurve,
    required this.enableInfiniteScroll,
    required this.autoPlayAnimationDuration,
    required this.viewportFraction,
  });
}
