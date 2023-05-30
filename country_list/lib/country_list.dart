import 'package:country_list/country_details.dart';
import 'package:country_list/rest_api.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key, required this.countryList}) : super(key: key);

  final List<Country> countryList;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: countryList.length,
        itemBuilder: (context, index) {
          return singleCountryCard(
              country: countryList[index],
              deviceWidth: width,
              index: index,
              context: context);
        });
  }
}

Widget singleCountryCard(
    {required double deviceWidth,
    required Country country,
    required int index,
    required BuildContext context}) {
  return InkWell(
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => CountryDetails(country: country))),
    child: Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 0.01),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('${index + 1}. '),
            Container(
              //color: Colors.red,
              width: deviceWidth * 0.6,
              child: Text('${country.name?.official}'),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              //color: Colors.yellow,
              width: deviceWidth * 0.22,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage.assetNetwork(
                    height: 60,
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/no-flag.png",
                    image: '${country.flag?.png}'),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
