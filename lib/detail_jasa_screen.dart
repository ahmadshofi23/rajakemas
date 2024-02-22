import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rajakemas/detail_profile_screen.dart';
import 'package:rajakemas/external/DetailProfileArgument.dart';

class DetailJasaScreen extends StatefulWidget {
  final String argumentDocument;
  const DetailJasaScreen({Key? key, required this.argumentDocument}) : super(key: key);

  @override
  State<DetailJasaScreen> createState() => _DetailJasaScreenState();

}



class _DetailJasaScreenState extends State<DetailJasaScreen> {

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Future<List<dynamic>> getData() async{
    var data = await FirebaseFirestore.instance.collection('jasa').doc(widget.argumentDocument).get();
    await Future.delayed(Duration(seconds: 5));
    print('isi data apa cs ${data.data()!["name"]}');
    print('isi data apa cs ${data.data()!["services"]}');
    print('isi data apa cs ${data.data()!["services"][0]['name']}');
    print('isi data apa cs ${data.data()!["services"]}');
    List<dynamic> services = data.data()?["services"] ?? [];
    print('length services ${services.length}');
    for(var i in services){
      print('ini data nama ${i['name']}');
      print('ini data nama ${i['achievements']}');
    }

// name    for (var i in data.data()["services"])
    return services;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2D2D),
      appBar: AppBar(
        backgroundColor: Color(0xffE1BB08),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset('assets/ic_arrow_back.png',),
        ),
        title: Text('Layanan Jasa',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Lottie.asset('assets/loading.json'),
              );
            }
            if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProfileScreen(
                            argument: DetailProfileArgument(
                              address: snapshot.data?[index]["address"],
                              name: snapshot.data?[index]["name"],
                              jasa: snapshot.data?[index]["jasa"],
                              image: snapshot.data?[index]["achievements"],
                              profile: snapshot.data?[index]["profile"]
                            ),
                          ),));
                        },
                        child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: MediaQuery.of(context).size.height * 0.13,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xffEBC617),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        height: MediaQuery.of(context).size.height * 0.13,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,

                                        ),
                                        child: Image.network('${snapshot.data?[index]["achievements"][0]}'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${snapshot.data?[index]["name"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                                            Text('${snapshot.data?[index]["jasa"]}',style: TextStyle(fontSize: 16, color: Colors.white),),
                                            Text('${snapshot.data?[index]["address"]}',style: TextStyle(fontSize: 14,color: Colors.white),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                      );
                    },
                ),
              );
            }
            return Text('no Data');
          },

      )

      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: ListView(
      //     children: List.generate(10, (index) => Container(
      //       margin: EdgeInsets.only(bottom: 10),
      //       height: MediaQuery.of(context).size.height * 0.13,
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //         color: Color(0xffEBC617),
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Container(
      //             width: MediaQuery.of(context).size.width * 0.3,
      //             height: MediaQuery.of(context).size.height * 0.13,
      //             decoration: BoxDecoration(
      //                 color: Colors.white
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text('Budiman Pertama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
      //                 Text('Makanan',style: TextStyle(fontSize: 16, color: Colors.white),),
      //                 Text('Alamat: Jl. Olahraga No.1 Polewali',style: TextStyle(fontSize: 14,color: Colors.white),)
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),),
      //   ),
      // ),
    );
  }
}
