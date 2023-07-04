import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key, required this.onSaveTodo}) : super(key: key);

  final Function onSaveTodo;

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final _date = DateTime.now();
  String dropdownvalue = 'Routine';
  final List<String> items = ['Routine', 'Work', 'Others'];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(5.0)),
              const Icon(Icons.list_alt_outlined),
              const Text('Kegiatan'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Judul Kegiatan',
                    )
                  ),
                ),
              )
            ],
          ),
          Row(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              Icon(Icons.notes),
              Text('Keterangan'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tambah Keterangan'
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: const <Widget>[
                  Icon(Icons.date_range),
                  Text('Tanggal Mulai'),
                ],
              ),
              Row(
                children: const <Widget>[
                  Icon(Icons.date_range_outlined),
                  Text('Tanggal Selesai'),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(20.0)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:TextField(
                controller: _startDateController, 
                decoration: const InputDecoration( 
                   icon: Icon(Icons.calendar_today), 
                   labelText: "Enter Date" 
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2101),
                  );
                  if(pickedDate != null ){ 
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); 
                      _startDateController.text = formattedDate; 
                  }
                },
             )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:TextField(
                controller: _endDateController, 
                decoration: const InputDecoration( 
                   icon: Icon(Icons.calendar_today), 
                   labelText: "Enter Date" 
                ),
                onTap: () async {
                  DateTime? pickedDate2 = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2101),
                  );
                  if(pickedDate2 != null ){ 
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate2); 
                      _endDateController.text = formattedDate; 
                  }
                },
             )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const <Widget>[
                  Icon(Icons.category),
                  Text('Kategori'),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    }
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  )
                )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      widget.onSaveTodo(
                        _titleController.text,
                        _descriptionController.text,
                        _startDateController.text,
                        _endDateController.text,
                        dropdownvalue
                      );
                      Navigator.pop(context, 'Data saved successfully.');
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topCenter,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 180,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 50, 5, 5),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Berhasil", 
                                                style: TextStyle(
                                                  fontSize: 20, 
                                                  fontWeight: FontWeight.bold
                                                ), 
                                                textAlign: TextAlign.center
                                              ),
                                              SizedBox(height: 10),
                                              const Text(
                                                "Kegiatan berhasil ditambahkan", 
                                                style: TextStyle(fontSize: 15), 
                                                textAlign: TextAlign.center
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text("OK"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 35)
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        top: -55,
                                        child: CircleAvatar(
                                          radius: 45,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 40,
                                            child: Icon(Icons.check, size: 40, color: Colors.white),
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                );
                              }
                            );
                    },
                    child: const Text('Simpan'),
                  )
                ),
              )
            ],
          )
        ],
      )
    );
  }
}