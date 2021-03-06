import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/create_trip_data.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlan createState() => _CreatePlan();
}

class _CreatePlan extends State {
  String tripConcept = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    '๐ๆใฎใณใณใปใใใๆฑบใใใ๐',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      height: SizeConfig.blockSizeVertical * 8,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            tripConcept = value;
                          });
                        },
                      )),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Center(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    height: SizeConfig.blockSizeVertical * 7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateData(tripConcept)),
                        );
                      },
                      child: Text('ๆฑบๅฎ',
                          style: TextStyle(
                            color: primaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}


        // Positioned(
        //   right: SizeConfig.blockSizeHorizontal * 50,
        //   top: SizeConfig.blockSizeVertical * 20,
        //   child: Opacity(
        //     opacity: 0.7,
        //     child: Container(
        //       width: SizeConfig.blockSizeHorizontal * 100,
        //       height: 400,
        //       decoration: BoxDecoration(
        //         //ใขใผใใซ่ชไฝใฎ่ฒ
        //         color: primaryColor,
        //         //่งไธธใซใใ
        //         shape: BoxShape.circle,
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.black12,
        //               blurRadius: 10.0,
        //               spreadRadius: 10.0,
        //               offset: Offset(5, 5))
        //         ],
        //       ),
        //     ),
        //   ),
        // ),



          // // ignore: await_only_futures
                    // final User user = await FirebaseAuth.instance.currentUser!;
                    // // ignore: unused_local_variable
                    // final String uid = user.uid.toString();

                    // // ใตใใณใฌใฏใทใงใณๅใซใใญใฅใกใณใไฝๆ
                    // await FirebaseFirestore.instance
                    //     .collection('users') // ใณใฌใฏใทใงใณID
                    //     .doc(uid) // ใใญใฅใกใณใID << usersใณใฌใฏใทใงใณๅใฎใใญใฅใกใณใ
                    //     .collection('plan') // ใตใใณใฌใฏใทใงใณID
                    //     .add({
                    //   'concept': tripConcept,
                    // }); // ใใผใฟ