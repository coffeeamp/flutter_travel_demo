import 'package:flutter/material.dart';
import 'package:flutter_travel_demo/student.dart';

class ApiScreen extends StatelessWidget {
  ApiScreen({super.key});
  Student studentService = Student();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Connect'),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: studentService.getAllStudent(),
          builder: (context, snapshot){
            print(snapshot.data);
            if(snapshot.hasData){
              return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i){
                      return Card(
                        child: ListTile(
                          title:Text(
                            snapshot.data?[i]['student_name'],
                            style: TextStyle(fontSize: 30.0),
                          ),
                          subtitle: Text(
                            snapshot.data?[i]['email'],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      );
                    });
            } else{
              return const Center(
                child: Text('No data')
              );
            }
          },
        ),
      ) 
      
    );
  }
}