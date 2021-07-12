import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/utils/colors.dart';

class DescriptionPatient {
  const DescriptionPatient({
    required this.bed,
    required this.name,
    required this.age,
    required this.gender,
    required this.diseases,
  })  : assert(bed != null),
        assert(name != null),
        assert(age != null),
        assert(gender != null),
        assert(diseases != null);

  final int bed;
  final String name;
  final String age;
  final String gender;
  final String diseases;
}

List<DescriptionPatient> destinations(BuildContext context) => [
      DescriptionPatient(
          bed: 02,
          name: "Đoàn Việt Anh",
          age: "35",
          gender: "Nữ",
          diseases: "Đau dạ dày mãn tĩnh"),
      DescriptionPatient(
          bed: 03,
          name: "Đoàn Việt Anh",
          age: "35",
          gender: "Nữ",
          diseases: "Đau dạ dày mãn tĩnh")
    ];

class ListPatientPage extends StatelessWidget {
  static const ROUTE_NAME = 'ListPatientPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bệnh nhân'),
        titleTextStyle: TextStyle(fontSize: 10),
      ),
      body: ListPatientView(),
    );
  }
}

class ListPatientView extends StatefulWidget {
  const ListPatientView({Key? key}) : super(key: key);

  @override
  _ListPatientViewState createState() => _ListPatientViewState();
}

class _ListPatientViewState extends State<ListPatientView>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController? _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String? get restorationId => 'tab_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController?.index = tabIndex.value;
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Tử vong", "Xin về", "Chuyển khoa nội", "Ra viện", "Đã về"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: mainColor,
          labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelColor: textColor,
          labelPadding: EdgeInsets.all(14),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                color: mainColor, width: 2, style: BorderStyle.solid),
          ),
          isScrollable: true,
          tabs: [for (final tab in tabs) Text(tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // DescriptionPatientItem(destination: destinations(context), shape: shape)
          for (final tab in tabs) Text(tab)
        ],
      ),
    );
  }

  Widget? DescriptionPatientItem {

  const height = 300.0;
  final DescriptionPatient destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(),
            SizedBox(
              height: height,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {},
                  splashColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  highlightColor: Colors.transparent,
                  child: DescriptionPatientContent(destination: destination,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
}

// class DescriptionPatientItem extends StatelessWidget {
//   const DescriptionPatientItem(
//       {Key? key, required this.destination, required this.shape})
//       : assert(destination != null),
//         super(key: key);


class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title!),
      ),
    );
  }
}

class DescriptionPatientContent extends StatelessWidget {
  const DescriptionPatientContent({Key? key, required this.destination})
      : assert(destination != null),
        super(key: key);
  
  final DescriptionPatient destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Row(
            children: [
              Text(destination.age.toString()),
              SizedBox(width: 12,),
              Column(
                children: [
                  Text(destination.name),
                  Text("${destination.age} tuổi, ${destination.gender}"),
                  Text(destination.diseases),
                ],
              )
            ],

          )
        )
      ],
    );
  }
}
