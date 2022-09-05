import 'package:flutter/material.dart';
import 'package:flutter_profile/services/api/get_profile_data.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Response>? getDataApi;

  @override
  void initState() {
    getDataApi = getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getDataApi,
          builder: (context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.hasData) {
              Result result = snapshot.data!.results.first;
              Location location = result.location;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(result.picture.thumbnail),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${result.name.title} ${result.name.first} ${result.name.last}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("${result.gender}, ${result.dob.age} year old"),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.cyan, shape: BoxShape.circle),
                          child: const Icon(Icons.chat)),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.cyan, shape: BoxShape.circle),
                          child: const Icon(Icons.phone)),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.cyan, shape: BoxShape.circle),
                          child: const Icon(Icons.share)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.business,
                      color: Colors.cyan,
                    ),
                    title: Text(result.cell),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      color: Colors.cyan,
                    ),
                    title: Text(result.phone),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.cyan,
                    ),
                    title: Text(result.email),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.cyan,
                    ),
                    title: Text(
                        "${location.street.number} ${location.street.name} ${location.city} ${location.state} ${location.country} ${location.postcode}"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getDataApi = getProfileData();
                        setState(() {});
                      },
                      child: const Text("Referesh"))
                ],
              );
            }
            print(snapshot.error);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
