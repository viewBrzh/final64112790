import 'package:Final6411790/screen/bookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Final6411790/apiEndpoint/apiUrl.dart';
import 'package:Final6411790/assets/allClass.dart';
import 'package:Final6411790/assets/dataKeeper.dart';

class ListCar extends StatefulWidget {
  const ListCar({super.key});

  @override
  State<ListCar> createState() => _ListCarState();
}

class _ListCarState extends State<ListCar> {
  TypeFilter? typeFilter;
  String? selectedBrand;
  double minPrice = 0.0;
  double maxPrice = double.infinity;
  List<Car> carList = [];

  @override
  void initState() {
    super.initState();
    fetchCar();
  }

  Future<void> fetchCar() async {
    final response = await http.post(Uri.parse('${apiUrl}getCar.php'));
    if (response.statusCode == 200) {
      final List<dynamic> carData = json.decode(response.body);
      List<Car> cars = carData.map((item) => Car.fromJson(item)).toList();
      setState(() {
        carList = cars;
      });
    } else {
      throw Exception('Failed to fetch cars');
    }
  }

  List<Car> getFilteredCars() {
    List<Car> filteredCars = carList;

    // Filter by type
    if (typeFilter != null && typeFilter != TypeFilter.All) {
      filteredCars = filteredCars
          .where((car) => car.cType == getCategoryString(typeFilter))
          .toList();
    }

    // Filter by brand
    if (selectedBrand != null && selectedBrand != 'All') {
      filteredCars = filteredCars
          .where((car) => car.cBrand == selectedBrand)
          .toList();
    }

    // Filter by price range
    filteredCars = filteredCars
        .where((car) {
          double carPrice = double.tryParse(car.cPrice.toString()) ?? 0.0;
          return carPrice >= minPrice && carPrice <= maxPrice;
        })
        .toList();

    return filteredCars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Row(
              children: [
                Text("Car Catalogs"),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<TypeFilter>(
                  value: typeFilter,
                  onChanged: (value) {
                    setState(() {
                      typeFilter = value;
                    });
                  },
                  items: TypeFilter.values
                      .map<DropdownMenuItem<TypeFilter>>(
                        (type) => DropdownMenuItem<TypeFilter>(
                          value: type,
                          child: Text(getCategoryString(type)),
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Type',
                  ),
                ),
              ),

              // Dropdown for selecting car brand
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedBrand,
                  onChanged: (value) {
                    setState(() {
                      selectedBrand = value;
                    });
                  },
                  items: getBrandList(),
                  decoration: InputDecoration(
                    labelText: 'Select Brand',
                  ),
                ),
              ),
            ],
          ),

          TextFormField(
            decoration: InputDecoration(labelText: 'Min Price (THB)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                minPrice = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Max Price (THB)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                maxPrice = double.tryParse(value) ?? double.infinity;
              });
            },
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getFilteredCars().length,
            itemBuilder: (BuildContext context, int index) {
              Car car = getFilteredCars()[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey[200],
                elevation: 0.0,
                child: GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Image.network(
                      car.cImage ?? '',
                      width: 100,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                    
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${car.cName}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 4, 4),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${car.cPrice} THB',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 250, 163, 1)),
                            ),
                            SizedBox(width: 12,),
                            IconButton(
                              onPressed: () {
                                currentCar = car.cID;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingScreen()));
                              }, 
                              icon: Icon(Icons.calendar_today_outlined)
                              )
                          ],
                        ),
                        
                      ],
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${car.cBrand}'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(' ${car.cType}'),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${car.cPassengers} passengers'),
                          SizedBox(
                            width: 5,
                          ),
                        ]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String getCategoryString(TypeFilter? filter) {
    switch (filter) {
      case TypeFilter.Small:
        return 'Small';
      case TypeFilter.Medium:
        return 'Medium';
      case TypeFilter.Large:
        return 'Large';
      case TypeFilter.SUV:
        return 'SUV';
      default:
        return 'All';
    }
  }

  List<DropdownMenuItem<String>> getBrandList() {
    List<String> brands = ['All'];
    for (var car in carList) {
      if (!brands.contains(car.cBrand)) {
        brands.add(car.cBrand);
      }
    }

    List<DropdownMenuItem<String>> brandList = [];
    for (var brand in brands) {
      brandList.add(DropdownMenuItem(
        value: brand,
        child: Text(brand),
      ));
    }

    return brandList;
  }
}

enum TypeFilter {
  All,
  Small,
  Medium,
  Large,
  SUV,
}