import 'package:flutter/material.dart';
import 'package:frontend/models/request.dart';
import 'package:frontend/models/response.dart';
import 'package:frontend/widgets/myslider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int area = 500;
  int bedrooms = 2;
  int bathrooms = 2;
  int balcony = 0;
  int parking = 0;
  int lift = 0;
  int newProperty = 1;
  int flat = 1;
  ResponseModel? responseModel;

  Future getPrice(RequestModel requestModel) async {
    http.Response response = await http.post(
        Uri.parse(
          "http://127.0.0.1:8000/api/predict",
        ),
        headers: {"Content-Type": "application/json"},
        body: requestModel.toJson());
    if (response.statusCode == 200) {
      responseModel = ResponseModel.fromJson(response.body);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "House Price Prediction",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Area
            MySlider(
              value: area,
              unit: "sq.ft",
              label: "Area",
              range: const [500, 10000, 95],
              onChanged: (value) {
                setState(() {
                  area = value.toInt();
                });
              },
            ),

            // Bedrooms
            MySlider(
              value: bedrooms,
              label: "Bedrooms",
              range: const [2, 10, 8],
              onChanged: (value) {
                setState(() {
                  bedrooms = value.toInt();
                });
              },
            ),

            // Bathrooms
            MySlider(
              value: bathrooms,
              label: "Bathrooms",
              range: const [2, 10, 8],
              onChanged: (value) {
                setState(() {
                  bathrooms = value.toInt();
                });
              },
            ),

            // Balcony
            MySlider(
              value: balcony,
              label: "Balcony",
              range: const [0, 10, 10],
              onChanged: (value) {
                setState(() {
                  balcony = value.toInt();
                });
              },
            ),

            // Parking
            MySlider(
              value: parking,
              label: "Parking",
              range: const [0, 20, 20],
              onChanged: (value) {
                setState(() {
                  parking = value.toInt();
                });
              },
            ),

            // Lift
            MySlider(
              value: lift,
              label: "Lift",
              range: const [0, 10, 10],
              onChanged: (value) {
                setState(() {
                  lift = value.toInt();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: newProperty,
                          onChanged: (value) {
                            setState(() {
                              newProperty = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "New Property",
                          textScaler: TextScaler.linear(1.25),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: newProperty,
                          onChanged: (value) {
                            setState(() {
                              newProperty = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Old Property",
                          textScaler: TextScaler.linear(1.25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: flat,
                          onChanged: (value) {
                            setState(() {
                              flat = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Flat",
                          textScaler: TextScaler.linear(1.25),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: flat,
                          onChanged: (value) {
                            setState(() {
                              flat = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Individual House",
                          textScaler: TextScaler.linear(1.25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(50),
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                getPrice(
                  RequestModel(
                      area: area,
                      bedrooms: bedrooms,
                      bathrooms: bathrooms,
                      balcony: balcony,
                      parking: parking,
                      lift: lift,
                      newProperty: newProperty,
                      flat: flat),
                ).then((value) => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Result",
                                textScaler: TextScaler.linear(1.75),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Expected Price",
                                    textScaler: TextScaler.linear(1.25),
                                  ),
                                  Text(
                                    "₹${responseModel?.expectedPrice}",
                                    textScaler: const TextScaler.linear(1.25),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Accuracy",
                                    textScaler: TextScaler.linear(1.25),
                                  ),
                                  Text(
                                    "${(responseModel!.accuracy * 100).toStringAsFixed(2)}%",
                                    textScaler: const TextScaler.linear(1.25),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
              child: const Text(
                "Calculate Expected Price",
              ),
            )
          ],
        ),
      ),
    );
  }
}
