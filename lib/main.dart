import 'package:app_theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeLight,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _Chip {
  final String name;
  final bool isSelect;

  const _Chip(this.name, {this.isSelect = false});

  _Chip select() {
    return _Chip(name, isSelect: true);
  }

  _Chip unselect() {
    return _Chip(name);
  }
}

final List<_Chip> _chips = [
  const _Chip('News'),
  const _Chip('Book', isSelect: true),
  const _Chip('Games', isSelect: true),
  const _Chip('Messages'),
  const _Chip('People'),
];

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme app'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          _tabController.index = currentIndex;
          setState(() {
            _currentTabIndex = currentIndex;
            _tabController.animateTo(_currentTabIndex);
          });
        },
        currentIndex: _currentTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Список товаров',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Поиск товаров',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Заказать товар'),
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await Future<void>.delayed(const Duration(seconds: 1));
                        setState(() => _isLoading = false);
                      },
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(
                    8,
                    (index) => Card(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/img_${index + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Краткое описание карточки'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
          const _Chips(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                              child: const Text('Да'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Нет'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: const Text('Сменить аватар'),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    child: Text('AB'),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chips extends StatefulWidget {
  const _Chips({Key? key}) : super(key: key);

  @override
  State<_Chips> createState() => _ChipsState();
}

class _ChipsState extends State<_Chips> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 12,
        children: [
          ..._chips
              .map(
                (item) => FilterChip(
                  onSelected: (v) {
                    final index = _chips.indexOf(item);
                    final replacementItem = v ? item.select() : item.unselect();
                    _chips.replaceRange(index, index + 1, [replacementItem]);

                    setState(() {});
                  },
                  selected: item.isSelect,
                  label: Text(item.name),
                ),
              )
              .toList(),
          const FilterChip(
            onSelected: null,
            label: Text('City'),
          ),
        ],
      ),
    );
  }
}
