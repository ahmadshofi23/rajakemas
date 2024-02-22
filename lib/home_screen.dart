import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rajakemas/detail_jasa_screen.dart';
import 'package:rajakemas/external/JasaEntity.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  var imgList;
  bool _isPlaying = true;

  CarouselSliderController _sliderController = CarouselSliderController();
  @override
  void initState()  {
    // TODO: implement initState
    getImageSlider();
    super.initState();
    _sliderController = CarouselSliderController();

  }

  
  final List<JasaEntity> _listJasa =  [
    JasaEntity(title: 'makanan', subTitle: 'Makanan'),
    JasaEntity(title: 'ojekbentor', subTitle: 'Ojek & Bentor'),
    JasaEntity(title: 'pertukangan', subTitle: 'Pertukangan'),
    JasaEntity(title: 'perikanan', subTitle: 'Perikanan'),
    JasaEntity(title: 'penjahit', subTitle: 'Penjahit'),
    JasaEntity(title: 'peternakan', subTitle: 'Peternakan'),
    JasaEntity(title: 'pelatihtenis', subTitle: 'Pelatih Tenis'),
    JasaEntity(title: 'pelatihrenang', subTitle: 'Pelatih Renang'),
    JasaEntity(title: 'pelatihtinju', subTitle: 'Pelatih Tinju'),

  ];

  Future<List<dynamic>> getImageSlider () async{
    var data = await FirebaseFirestore.instance.collection('banner').doc('CgpxFek9q3hG1H0iyneu').get();
    List<dynamic> images = data.data()?["urlbanner"];
    print('image length ${images.length}');
    imgList = images;
    return images;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:  SystemUiOverlayStyle(
        statusBarColor: Color(0xffA98307),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff2D2D2D)
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/rajakemas.png'),
                          fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * 0.21,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                        child: TypeAheadField<JasaEntity>(
                          controller: _controller,
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                              controller: _controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText: 'Cari Nama Penyedia Jasa disini...',
                                prefixIcon: Icon(Icons.search,color: Color(0xffD6B102),),
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(fontSize: 12, color: Color(0xff6E6E6E)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                fillColor: Color(0xff424242),
                                filled: true,
                            ));
                          },
                          suggestionsCallback: (pattern) async {
                            print('ini isi nya apa? $pattern');
                            return _listJasa.where((title) => title.title.toLowerCase().contains(pattern.toLowerCase())).toList();
                          },
                          itemBuilder: (context, suggestion) {
                            print('suggestion $suggestion');
                            return ListTile(
                              tileColor: Color(0xffD6B102),
                              title: Text(suggestion.subTitle, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),
                            );
                          },
                          onSelected: (suggestion) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                              argumentDocument: suggestion.title,
                            ),));
                            _controller.clear();
                          },
                        ),
                        // TextFormField(
                        //   style: const TextStyle(fontSize: 12,
                        //   decoration: TextDecoration.none,
                        //   color: Color(0xff6E6E6E),
                        //   decorationThickness: 0),
                        //   textAlign: TextAlign.start,
                        //   decoration: InputDecoration(
                        //     hintText: 'Cari Nama Penyedia Jasa disini...',
                        //     contentPadding: EdgeInsets.zero,
                        //
                        //     hintStyle: TextStyle(fontSize: 12, color: Color(0xff6E6E6E)),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(25)
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(25)
                        //     ),
                        //     fillColor: Color(0xff424242),
                        //     filled: true,
                        //     prefixIcon: Icon(Icons.search, color: Color(0xffD6B102),
                        //     )
                        //   ),
                        // )
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * 0.29,
                  child: Column(
                    children: [
                      FutureBuilder(
                      future: getImageSlider(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: CarouselSlider.builder(
                                    unlimitedMode: true,
                                    controller: _sliderController,
                                    slideBuilder: (index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(snapshot.data?[index] ?? '', fit: BoxFit.cover,),
                                      );
                                    },
                                    slideTransform: DefaultTransform(),
                                    slideIndicator: CircularSlideIndicator(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      indicatorBackgroundColor: Colors.white,
                                      currentIndicatorColor: Colors.amber
                                    ),
                                    itemCount: snapshot.data?.length ?? 0,
                                    initialPage: 0,
                                    enableAutoSlider: true,
                                  ),
                                ),
                              ],
                            ),
                            );
                          }
                        return SizedBox();
                      },

                        ),
                        ]
                        )

                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.52,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              children: [
                                //Card One
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'makanan',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logomakanan.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                             Center(child: Text('Makanan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'ojekbentor',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logoojek.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: Text('Ojek & Bentor', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'pertukangan',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopertukangan.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Pertukangan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                //Card Two
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'perikanan',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logoperikanan.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Perikanan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'penjahit',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopenjahit.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                child: Center(child: const Text('Penjahit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'peternakan',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopeternakan.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Peternakan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                //Card 3
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'pelatihtenis',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopelatihantenis.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Pelatih Tennis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'pelatihrenang',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopelatihanrenang.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Pelatih Renang', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))

                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailJasaScreen(
                                          argumentDocument: 'pelatihtinju',
                                        ),));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffEDD358),
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context).size.height * 0.07,
                                              child: Center(child: Image.asset('assets/logopelatihantinju.png', height: MediaQuery.of(context).size.height * 0.05,)),
                                            ),

                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                            Center(child: const Text('Pelatih Tinju', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
        )
      ),
    );

  }


}
