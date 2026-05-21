import 'package:agrimind/features/home/presentation/widgets/ai_health.dart';
import 'package:flutter/material.dart';
import 'package:agrimind/features/home/presentation/widgets/live_board.dart';
import 'package:agrimind/features/home/presentation/widgets/parameters_plant.dart';
import 'package:agrimind/features/home/presentation/widgets/temperture_sensor.dart';
import 'package:agrimind/core/widgets/app_image.dart';

/// ───────── Model ─────────
class Order {
  final String name;
  final double amount;

  const Order({
    required this.name,
    required this.amount,
  });
}

/// ───────── Plant Screen ─────────
class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final List<Order> _allOrders = const [
    Order(name: 'tomato', amount: 120),
    Order(name: 'potato', amount: 80),
    Order(name: 'cucumber', amount: 200),
    Order(name: 'pepper', amount: 150),
    Order(name: 'carrot', amount: 90),
  ];

  final List<String> _sortOptions = const [
    'Default',
    'Amount ↑',
    'Amount ↓',
    'Name A-Z',
    'Name Z-A',
  ];

  late List<Order> _filteredOrders;
  String _searchQuery = '';
  String _sortOption = 'Default';

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(_allOrders);
  }

  void _applyFilters() {
    List<Order> result = _allOrders
        .where((o) =>
        o.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    switch (_sortOption) {
      case 'Amount ↑':
        result.sort((a, b) => a.amount.compareTo(b.amount));
        break;
      case 'Amount ↓':
        result.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case 'Name A-Z':
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name Z-A':
        result.sort((a, b) => b.name.compareTo(a.name));
        break;
    }

    setState(() {
      _filteredOrders = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 15),

            const LiveBoard(
              image: AppImages.onboarding3,
            ),

            const SizedBox(height: 15),

            /// 🌱 Plant Data
            Row(
              children: const [
                ParametersPlant(
                  description: 'too cold',
                  name: 'Plant temp',
                  num: 15,
                ),
                SizedBox(width: 10),
                ParametersPlant(
                  description: 'too dry',
                  name: 'Humidity',
                  num: 30,
                ),
              ],
            ),

            const SizedBox(height: 10),

            const TemperatureBarWidget(
              name: 'Plant Temperature',
              value: 18,
              min: 0,
              max: 40,
            ),

            const SizedBox(height: 20),

            const _WalletCard(),
            const AIHealthAnalytics(image:AppImages.planthealth ,),

            const SizedBox(height: 24),

            const Text(
              'Plant Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            _SearchBar(
              onChanged: (val) {
                _searchQuery = val;
                _applyFilters();
              },
            ),

            const SizedBox(height: 10),

            _SortChips(
              options: _sortOptions,
              selected: _sortOption,
              onSelected: (val) {
                _sortOption = val;
                _applyFilters();
              },
            ),

            const SizedBox(height: 12),

            const _OrderListHeader(),

            if (_filteredOrders.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No plants found',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ..._filteredOrders.map((o) => _OrderRow(order: o)),
          ],
        ),
      ),
    );
  }
}

/// ───────── Wallet ─────────
class _WalletCard extends StatelessWidget {
  const _WalletCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF86EFAC), width: 1.5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wallet balance',
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
              SizedBox(height: 4),
              Text('\$12,500',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            children: [
              Text('See transaction',
                  style: TextStyle(fontSize: 13, color: Colors.green)),
              Icon(Icons.chevron_right, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

/// ───────── Search ─────────
class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search plant...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

/// ───────── Sort Chips ─────────
class _SortChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const _SortChips({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((opt) {
          final isSelected = opt == selected;

          return GestureDetector(
            onTap: () => onSelected(opt),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                opt,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// ───────── Header ─────────
class _OrderListHeader extends StatelessWidget {
  const _OrderListHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Text("Name")),
        Text("Amount"),
      ],
    );
  }
}

/// ───────── Row ─────────
class _OrderRow extends StatelessWidget {
  final Order order;

  const _OrderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.name),
      trailing: Text("\$${order.amount}"),
    );
  }
}