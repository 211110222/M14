import 'package:flutter/material.dart';
import 'todos.dart';
import 'package:provider/provider.dart';
import 'calender.dart';
import 'profile.dart';
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Pertemuan06Provider()),
  ],child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void onSaveTodo(String title, String description, String startDate,
      String endDate, String category, BuildContext context) {
    final homePageState = context.findAncestorStateOfType<_MyHomePageState>();
    homePageState?.addTodo(title, description, startDate, endDate, category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final prov= Provider.of<Pertemuan06Provider>(context);
    
    return MaterialApp(
      title: 'Todos',
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
      home: const MyHomePage(title: 'Todos'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String selected = 'Home';
  int val = 0;
  final List<Todo> _originalTodos = [];
  List<Todo> _filteredTodos = [];
  Color getCategoryColor(String category) {
  switch (category) {
    case 'Work':
      return Colors.blue;
    case 'Routine':
      return Colors.red;
    case 'Others':
      return Colors.green;
    default:
      return Colors.black;
  }
}

  String? _value;
  List<String> stuff = ['Work', 'Routine', 'Others'];

  Map<String, String> categoryMap = {
    'Work': 'Work',
    'Routine': 'Routine',
    'Others': 'Others',
  };

  void addTodo(
    String title,
    String description,
    String startDate,
    String endDate,
    String category,
  ) {
    setState(() {
      _originalTodos.add(
        Todo(
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          category: category,
          isChecked: false,
        ),
      );
      _filteredTodos = _originalTodos;
    });
  }
  void _selectedChip(String? value) {
    List<Todo> filter;
    if (value != null) {
      filter = _originalTodos
          .where((tile) => tile.category == categoryMap[value])
          .toList();
    } else {
      filter = _originalTodos;
    }
    setState(() {
      _filteredTodos = filter;
      _value = value;
    });
  }

  void _checked(bool? value, String category) {
  setState(() {
    int removedIndex = -1; // Variable to track the index of the removed item
    for (var i = 0; i < _originalTodos.length; i++) {
      var todo = _originalTodos[i];
      if (todo.category == category) {
        if (todo.isChecked != value) {
          todo.isChecked = value ?? false;
          if (value == true) {
            todo.count++;
          } else {
            todo.count--;
            if (todo.isChecked == false) {
              removedIndex = i; // Store the index of the removed item
            }
          }
        }
      }
    }

    if (removedIndex != -1) {
      // If an item was removed
      if (removedIndex < _originalTodos.length) {
        // If the removed item was not the last item
        _originalTodos[removedIndex].count = _originalTodos[removedIndex + 1].count;
      } else {
        // If the removed item was the last item
        _originalTodos[removedIndex - 1].count = 0;
      }
    }

    _filteredTodos = _originalTodos.where((todo) => !todo.isChecked).toList();
  });
}

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov= Provider.of<Pertemuan06Provider>(context);
    bool isFabVisible = val != 1;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: val,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Calender' 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            val = index;
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.purple,
         actions: [
          Icon(prov.enableDarkMode == true ? Icons.wb_sunny : Icons.nightlight_round),
            Switch(value: prov.enableDarkMode, onChanged: (value){
              setState(() {
                prov.setBrightness = value;
              });
            }
            )
          ],
      ),
      drawer: Drawer(
      child: ListView(
    padding: const EdgeInsets.all(8.0),
    children: [
      DrawerHeader(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Todo App",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "  By: Stanly Winata",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      ListTile(
        title: const Text(
          'Personal',
        ),
        trailing: Visibility(
          visible: _originalTodos.isNotEmpty,
          child: CircleAvatar(
            child: Text(
              _originalTodos
                  .where((todo) =>
                      todo.category == 'Routine' && !todo.isChecked)
                  .length
                  .toString(),
            ),
          ),
        ),
      ),
      ListTile(
        title: const Text('Work'),
        trailing: Visibility(
          visible: _originalTodos.isNotEmpty,
          child: CircleAvatar(
            child: Text(
              _originalTodos
                  .where((todo) => todo.category == 'Work' && !todo.isChecked)
                  .length
                  .toString(),
            ),
          ),
        ),
      ),
      ListTile(
        title: const Text('Others'),
        trailing: Visibility(
          visible: _originalTodos.isNotEmpty,
          child: CircleAvatar(
            child: Text(
              _originalTodos
                  .where((todo) =>
                      todo.category == 'Others' && !todo.isChecked)
                  .length
                  .toString(),
                  
            ),
          ),
        ),
        
      ),
      const ListTile(
        title: Text(''),
      ),
      SwitchListTile(
        title: const Text("Dark Mode"),
        value: prov.enableDarkMode, 
        onChanged: (value) {
          setState(() {
            prov.setBrightness = value;
          });
        },
      ),
    ],
  ),
),

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            val = index;
          });
        },
        children: 
              [
                Column(
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        spacing: 5.0,
                        children: 
                        List<Widget>.generate(
                          stuff.length,
                          (int index) {
                            return ChoiceChip(
                              label: Text(stuff[index],style: const TextStyle(color: Colors.black)),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: stuff[index]=="Work" ? Colors.blue : stuff[index]=="Routine" ? Colors.red  : stuff[index]=="Others" ? Colors.green : Colors.black),
                              ),
                              selectedColor: stuff[index]=="Work" ? Colors.blue : stuff[index]=="Routine" ? Colors.red  : stuff[index]=="Others" ? Colors.green : null,
                              selected: _value == stuff[index],
                              onSelected: (bool value){
                                setState(() {
                                  _value = value ? stuff[index] : null;
                                });
      
                                if (value) {
                                  _selectedChip(stuff[index]);
                                } else {
                                  _selectedChip(null);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Text("Unfinished",style: TextStyle(),),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _filteredTodos[index];
                      if(todo.isChecked==false){
                      return ExpansionTile(
                        leading: Checkbox(
                          value: todo.isChecked,
                          activeColor: getCategoryColor(todo.category),
                          side:  BorderSide(color: getCategoryColor(todo.category),width: 1),
                          onChanged: (bool? value) {
                            setState(() {
                              todo.isChecked = value ?? false;
                            });
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(
                          '${todo.startDate} s/d ${todo.endDate}',
                        ),
                        trailing: const Icon(Icons.arrow_drop_down),
                        children: <Widget>[
                          ListTile(
                              title: Text(
                            todo.description,
                          )),
                        ],
                      );}
                      else{
                        return const Text("");
                      }
                    },
                  ),
                ),
                const Text("Finished",style: TextStyle(),),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _filteredTodos[index];
                      if(todo.isChecked==true){
                       return ExpansionTile(
                        leading: Checkbox(
                          value: todo.isChecked,
                          activeColor: getCategoryColor(todo.category),
                          side:  BorderSide(color: getCategoryColor(todo.category),width: 5),
                          onChanged: (bool? value) {
                            setState(() {
                              todo.isChecked = value ?? false;
                            });
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(
                          '${todo.startDate} s/d ${todo.endDate}',
                        ),
                        trailing: const Icon(Icons.arrow_drop_down),
                        children: <Widget>[
                          ListTile(
                              title: Text(
                            todo.description,
                          )),
                        ],
                      );}
                      else{
                        return const Text("");
                      }
                    },
                  ),
                ),
              ]),
              Calender(),
              Profile(work: _filteredTodos
                  .where((todo) => todo.category == 'Work' && todo.isChecked)
                  .length
                  .toString(),
                  routine: _filteredTodos
                  .where((todo) =>
                      todo.category == 'Routine' && todo.isChecked)
                  .length
                  .toString(),
                  other: _filteredTodos
                  .where((todo) =>
                      todo.category == 'Others' && todo.isChecked)
                  .length
                  .toString(),
                  )
            ],
      ),
      floatingActionButton: isFabVisible
        ? FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Todos(onSaveTodo: addTodo)),
              );
            },
            child: const Icon(Icons.add),
          )
        : null,
    );
  }
}

class Todo {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String category;
  bool isChecked;
  int count;

  Todo(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.category,
      this.isChecked = false,
      this.count = 0,});

}

class Pertemuan06Provider extends ChangeNotifier{
  var light = ThemeData(
    brightness: Brightness.light,
   primarySwatch: Colors.purple
  );
  var dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
  );
  bool _enableDarkMode = false;
  bool get enableDarkMode => _enableDarkMode;
  set setBrightness(val) {
    _enableDarkMode = val;
    notifyListeners();
  }
}