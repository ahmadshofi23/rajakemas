import 'package:flutter/material.dart';
import 'package:rajakemas/external/DetailProfileArgument.dart';

class DetailProfileScreen extends StatelessWidget {
  final DetailProfileArgument argument;
  const DetailProfileScreen({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 400 ? 3 : 2;

    return Scaffold(
      backgroundColor: Color(0xff2D2D2D),
      appBar: AppBar(
        backgroundColor: Color(0xffE1BB08),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset('assets/ic_arrow_back.png'),
        ),
        title: Text('Profile ${argument.name}',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffE1BB08)
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Image.network(argument.profile, fit: BoxFit.cover,)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Text(argument.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                Text(argument.jasa, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                Text(argument.address, style: const TextStyle(fontSize: 14, color: Colors.white),)
              ],
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8
                ),
                itemCount: argument.image.length,
                itemBuilder: (context, index) {
                  return Container(
                     // Ganti dengan dekorasi atau widget sesuai kebutuhan Anda
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(padding: EdgeInsets.all(8),
                      child: Image.network(argument.image[index]
                      ),
                    )
                  );
                },
              ),
            ),
          ),

        ],
      )
      ,
    );
  }
}
