import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:fe/core/theme/app_palette.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedRange = "Tháng này";

  final List<String> _ranges = [
    "Tuần này",
    "Tháng này",
    "Năm nay",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: GFDrawer(
        color: AppPalette.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("An Chim To"),
              accountEmail: Text("an@example.com"),
              currentAccountPicture: GFAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Thông tin cá nhân"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Cài đặt"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Đăng xuất"),
              onTap: () {},
            ),
          ],
        ),
      ),

      backgroundColor: AppPalette.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Hàng avatar + search bar ---
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const GFAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      size: GFSize.LARGE,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GFSearchBar(
                      searchList: const ["Thịt bò", "Cà rốt", "Cá hồi", "Trứng"],
                      searchQueryBuilder: (query, list) => list
                          .where((item) =>
                              item.toLowerCase().contains(query.toLowerCase()))
                          .toList(),
                      overlaySearchListItemBuilder: (item) => Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(item),
                      ),
                      searchBoxInputDecoration: InputDecoration(
                        hintText: "Tìm kiếm món ăn hoặc nguyên liệu...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Dropdown chọn khoảng thời gian
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Khoảng thời gian:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  DropdownButton<String>(
                    value: _selectedRange,
                    items: _ranges
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedRange = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- Biểu đồ tròn ---
              const Text(
                "Tỉ lệ thực phẩm còn lại / đã tiêu thụ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.green,
                        value: 70,
                        title: 'Còn 70%',
                        radius: 60,
                        titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: Colors.redAccent,
                        value: 30,
                        title: 'Đã dùng 30%',
                        radius: 60,
                        titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Biểu đồ cột ---
              const Text(
                "Lượng thực phẩm mua & tiêu thụ theo ngày",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                            if (value.toInt() < days.length) {
                              return Text(days[value.toInt()]);
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      for (int i = 0; i < 7; i++)
                        BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                                toY: (4 + i).toDouble(),
                                color: Colors.greenAccent,
                                width: 10),
                            BarChartRodData(
                                toY: (2 + i / 2).toDouble(),
                                color: Colors.redAccent,
                                width: 10),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
