import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:rvsapp/presentation/themes/text_styles.dart';
import 'package:rvsapp/presentation/widgets/card_category.dart';
import 'package:rvsapp/shared/providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  String userName = "David";

  // Données des annonces (exemple)
  final List<Map<String, dynamic>> _announcements = [
    {
      'title': 'Villa de luxe à Lomé',
      'price': '850,000 FCFA',
      'location': 'Lomé, Togo',
      'image': 'assets/villa.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Appartement moderne',
      'price': '450,000 FCFA',
      'location': 'Kara, Togo',
      'image': 'assets/appart.jpg',
      'isFavorite': true,
    },
    {
      'title': 'Maison familiale',
      'price': '650,000 FCFA',
      'location': 'Sokodé, Togo',
      'image': 'assets/famille.jpg',
      'isFavorite': false,
    },
  ];

  // Données des catégories
  final List<Map<String, dynamic>> _categories = [
    {'icon': HeroIcons.home, 'title': 'Maisons', 'color': Colors.blue},
    {
      'icon': HeroIcons.buildingOffice,
      'title': 'Appartements',
      'color': Colors.orange,
    },
    {
      'icon': HeroIcons.buildingStorefront,
      'title': 'Commerce',
      'color': Colors.green,
    },
    {'icon': HeroIcons.mapPin, 'title': 'Terrains', 'color': Colors.purple},
    {
      'icon': HeroIcons.wrenchScrewdriver,
      'title': 'Rénovation',
      'color': Colors.red,
    },
    {'icon': HeroIcons.star, 'title': 'Premium', 'color': Colors.amber},
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Bonjour";
    } else if (hour < 17) {
      return "Bon après-midi";
    } else {
      return "Bonsoir";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: HeroIcon(
                  HeroIcons.bars3BottomLeft,
                  color: colorScheme.onPrimary,
                  size: 24,
                ),
                onPressed: () {
                  // Action du menu
                },
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    IconButton(
                      icon: HeroIcon(
                        HeroIcons.bell,
                        color: colorScheme.onPrimary,
                        size: 24,
                      ),
                      onPressed: () {
                        // Action des notifications
                      },
                    ),
                    // Badge de notification
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section de bienvenue avec gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getGreeting()}, $userName! 👋',
                          style: TextStyles.headlineMedium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Trouvez la maison de vos rêves',
                          style: TextStyles.bodyLarge.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Barre de recherche
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher une propriété...',
                              hintStyle: TextStyles.bodyMedium.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  icon: HeroIcon(
                                    HeroIcons.adjustmentsHorizontal,
                                    color: colorScheme.onPrimary,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // Action des filtres
                                  },
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: colorScheme.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Section des catégories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Catégories',
                        style: TextStyles.titleLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Voir toutes les catégories
                        },
                        child: Text(
                          'Voir tout',
                          style: TextStyles.labelLarge.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Grille des catégories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return CategoryCard(
                        icon: category['icon'],
                        title: category['title'],
                        iconColor: category['color'],
                        onTap: () {
                          // Navigation vers la catégorie
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Section des annonces récentes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Annonces récentes',
                        style: TextStyles.titleLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Voir toutes les annonces
                        },
                        child: Text(
                          'Voir tout',
                          style: TextStyles.labelLarge.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Carrousel des annonces
                SizedBox(
                  height: 280,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _announcements.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final announcement = _announcements[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: colorScheme.primaryContainer,
                                ),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      announcement['image'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            // Fallback si l'image ne charge pas
                                            return HeroIcon(
                                              HeroIcons.photo,
                                              size: 60,
                                              color: colorScheme
                                                  .onPrimaryContainer
                                                  .withOpacity(0.5),
                                            );
                                          },
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          announcement['isFavorite']
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: announcement['isFavorite']
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Informations
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      announcement['title'],
                                      style: TextStyles.titleMedium.copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: colorScheme.onSurfaceVariant,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            announcement['location'],
                                            style: TextStyles.bodySmall
                                                .copyWith(
                                                  color: colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      announcement['price'],
                                      style: TextStyles.titleMedium.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Indicateurs du carrousel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _announcements.length,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPageIndex == index
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Section des statistiques
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primaryContainer,
                          colorScheme.secondaryContainer,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '2,847',
                                style: TextStyles.headlineMedium.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Propriétés disponibles',
                                style: TextStyles.bodySmall.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: colorScheme.onPrimaryContainer.withOpacity(
                            0.3,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '1,203',
                                style: TextStyles.headlineMedium.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Clients satisfaits',
                                style: TextStyles.bodySmall.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 130),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
