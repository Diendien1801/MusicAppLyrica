import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingArtistScreen extends StatelessWidget {
  const FollowingArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 200,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0, left: 30),
                width: 170,
                child: Text(
                  'FOLLOWING ARTISTS',
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        letterSpacingDelta: 2,
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 120),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(
                    color: Color.fromRGBO(207, 134, 237, 1),
                    width: 3,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/person.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(66, 204, 71, 193),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            height: 716,
            child: GridView.builder(
              itemCount: 18,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 14, right: 14),
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/artists/art1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Artist Name
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 0),
                    child: Text(
                      'Artist Name',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
