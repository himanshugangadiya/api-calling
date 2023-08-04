import 'package:api_calling/model/get_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GetModel> list = [];
  bool isLoading = false;

  /// Fetch Data
  handleGet() async {
    setState(() {
      isLoading = true;
    });

    await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
        .then((res) {
      print("GET status code ============> ${res.statusCode}");

      if (res.statusCode == 200) {
        final resData = getModelFromJson(res.body);

        setState(() {
          list = resData;
          isLoading = false;
        });
        print(list.toString());
      } else if (res.statusCode != 200) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  /// Post Data
  handlePost() async {
    await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      body: {},
    ).then((response) {
      print("POST status code ============> ${response.statusCode}");
      if (response.statusCode == 200) {
      } else if (response.statusCode != 200) {}
    });
  }

  /// Update Data
  handleUpdate() async {
    await http
        .put(Uri.parse("https://jsonplaceholder.typicode.com/posts/2"))
        .then((response) {
      print("UPDATE status code ============> ${response.statusCode}");

      if (response.statusCode == 200) {
      } else if (response.statusCode != 200) {}
    });
  }

  /// Delete Data
  handleDelete() async {
    await http
        .delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"))
        .then((value) {
      print("DELETE status code ===================> ${value.statusCode}");
      if (value.statusCode == 200) {
      } else if (value.statusCode != 200) {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleGet();
    handlePost();
    handleUpdate();
    handleDelete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Api Testing",
              style: Theme.of(context).textTheme.bodyMedium),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : list.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await handleGet();
                    },
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index].title),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text("No Data Found"),
                  ),
      ),
    );
  }
}
