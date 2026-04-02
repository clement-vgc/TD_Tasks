import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/mytheme.dart';
import 'UI/ecran1.dart';
import 'UI/ecran2.dart';
import 'UI/ecran3.dart';
import 'UI/ecran_settings.dart';
import 'viewmodels/setting_view_model.dart';
import 'viewmodels/task_view_model.dart';
import 'UI/add_task.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import 'repositories/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  final db = await openDatabase(
    join(await getDatabasesPath(), 'task_db.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, nbhours INTEGER, difficuty INTEGER)',
      );
    },
    version: 1,
  );

  runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp(this.database, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingViewModel()),
        ChangeNotifierProvider(create: (_) {
          final repository = TaskRepository(database);
          TaskViewModel taskViewModel = TaskViewModel(repository);
          taskViewModel.loadTasks();
          return taskViewModel;
        }),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, notifier, child) {
          return MaterialApp(
            title: 'TD Tasks',
            debugShowCheckedModeBanner: false,
            theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    Ecran1(),
    Ecran2(),
    Ecran3(),
    EcranSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTask()),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Static'),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: 'API'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Réglages'),
        ],
      ),
    );
  }
}