import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Counter()),
          ChangeNotifierProvider(create: (context) => Layout()),
        ],
        child: const MyApp()
      )
    );
}
class Counter with ChangeNotifier{
  int value =0;
  void increment(){
    value++;
    notifyListeners();
  }
}
class Layout with ChangeNotifier{
  MainAxisAlignment alignment = MainAxisAlignment.start;
  int index = 0;
  void changeLayout(){
    index++;
    alignment = MainAxisAlignment.values[(index) % MainAxisAlignment.values.length];
    notifyListeners();
  }

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page - José Guidi'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});


  final String title;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(title),
      ),
      body: Center(
       
        child: Column(
         
          mainAxisAlignment: Provider.of<Layout>(context).alignment
            
          ,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context,counter,child)=> Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ), floatingActionButton: SpeedDial(
        icon: Icons.menu,
        backgroundColor: Theme.of(context).colorScheme.primary,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add,color: Colors.white,),
            label: 'Increment',
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onTap: Provider.of<Counter>(context,listen: false).increment,
          ),
          SpeedDialChild(
            child: const Icon(Icons.space_bar,color: Colors.white,),
            label: 'Change layout',
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onTap: Provider.of<Layout>(context,listen: false).changeLayout,
          )
        ]
      )
    );
  
  }
}
/*floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<Counter>(context,listen: false).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
