import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../utils.dart';

class EventTime {
  String title = "";
  String subtitle = "";
  String startDate = "";
  String endDate = "";
  EventTime(this.title, this.subtitle, this.startDate, this.endDate);
}

class Calender extends StatefulWidget {
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with AutomaticKeepAliveClientMixin {
  List<EventTime> eventData = [];
  TextEditingController judulController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController tglMulaiController = TextEditingController();
  TextEditingController tglSelesaiController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the state is kept alive

    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Event"),
              IconButton(
                onPressed: () {
                  judulController.text = '';
                  additionalController.text = '';
                  tglMulaiController.text =
                      DateFormat('dd MMM yyyy').format(DateTime.now());
                  tglSelesaiController.text =
                      DateFormat('dd MMM yyyy').format(DateTime.now());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: AlertDialog(
                        content: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: judulController,
                                  style: TextStyle(
                                     
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Nama Event',
                                    labelStyle: TextStyle(
                                       
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: additionalController,
                                  style: TextStyle(
                                     
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Keterangan tambahan',
                                    labelStyle: TextStyle(
                                       
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: tglMulaiController,
                                  style: TextStyle(
                                     
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal mulai',
                                    labelStyle: TextStyle(
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime selectedDate = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      initialDatePickerMode:
                                          DatePickerMode.day,
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2101),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                            dialogBackgroundColor:
                                                Colors.white,
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                        tglMulaiController.text =
                                            DateFormat('dd MMM yyyy')
                                                .format(selectedDate);
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: tglSelesaiController,
                                  style: TextStyle(
                                     
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal selesai',
                                    labelStyle: TextStyle(
                                       
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                         
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime selectedDate = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      initialDatePickerMode:
                                          DatePickerMode.day,
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2101),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData(
                                            dialogBackgroundColor:
                                                Colors.white,
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                        tglSelesaiController.text =
                                            DateFormat('dd MMM yyyy')
                                                .format(selectedDate);
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "CANCEL",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                eventData.add(EventTime(
                                  judulController.text,
                                  additionalController.text,
                                  tglMulaiController.text,
                                  tglSelesaiController.text,
                                ));
                                judulController.clear();
                                additionalController.clear();
                                tglMulaiController.clear();
                                tglSelesaiController.clear();
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text("SET"),
                          ),
                        ],
                      ));
                    },
                  );
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          if (eventData.length != 0)
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: eventData.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(eventData[index].title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eventData[index].subtitle),
                          Text(
                            eventData[index].startDate ==
                                    eventData[index].endDate
                                ? eventData[index].endDate
                                : "${eventData[index].startDate} - ${eventData[index].endDate}",
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            eventData.remove(eventData[index]);
                          });
                        },
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
