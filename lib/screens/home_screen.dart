import 'package:flutter/material.dart';
import 'package:weather_app/services/api_helper.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/screens/help_screen.dart';
import 'package:weather_app/services/share_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController clocation = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSaved = false;
  String location = '';

  @override
  Widget build(BuildContext context) {
    var future = ApiHelper().getData(location);
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        leadingWidth: 150,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SplashScreen()));
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: const Text(
              'Splash Screen',
              style: TextStyle(color: Colors.white),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: clocation,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.location_on_sharp),
                        ),
                        prefixIconConstraints: const BoxConstraints(),
                        labelText: 'Yout City',
                        contentPadding: const EdgeInsets.only(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " Field is empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        location = clocation.text;
                        ApiHelper().getData(location);
                        LocalDatabase().saveData(location);
                        setState(() {
                          isSaved = true;
                        });
                      }
                    },
                    child: Text(isSaved ? 'Update' : 'Save'),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
            FutureBuilder<Weather>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Text(
                              data!.name,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.tempC.toString(),
                              style: const TextStyle(fontSize: 70),
                            ),
                            const Text('o'),
                            const Text(
                              'C',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Image.network(
                          'https:${data.icon}',
                          scale: 0.8,
                        ),
                        Text(data.conditon)
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            const Spacer(
              flex: 4,
            )
          ],
        ),
      ),
    );
  }
}
