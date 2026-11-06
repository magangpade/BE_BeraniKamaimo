import 'event_detail_data.dart';

/// Salinan teks Inggris untuk konten detail Event; data tanggal, foto, dan peta tetap sama.
class EventEnglishDetail {
  EventEnglishDetail._();

  static EventDetail of(String eventName, EventDetail original) {
    final copy = _copies[eventName] ?? _fallback;
    final rows = copy.rundown
        .trim()
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();
    final count = original.rundown.fold<int>(
      0,
      (total, day) => total + (day['items'] as List).length,
    );
    if (rows.length != count) {
      throw StateError('English rundown count differs for $eventName');
    }
    var cursor = 0;
    final rundown = <Map<String, dynamic>>[
      for (final day in original.rundown)
        {
          ...day,
          'hari': _dayLabel(day['hari'] as String),
          'items': <Map<String, dynamic>>[
            for (final raw in day['items'] as List)
              _englishSlot(
                Map<String, dynamic>.from(raw as Map),
                rows[cursor++],
              ),
          ],
        },
    ];
    return EventDetail(
      badge: original.badge == 'Event Sulawesi Tengah'
          ? 'Central Sulawesi Event'
          : original.badge,
      rating: original.rating,
      ratingCount: original.ratingCount,
      lokasi: copy.location,
      tentang: copy.about,
      program: copy.programs,
      programImages: original.programImages,
      rundown: rundown,
      zonaWita: 'WITA (UTC+8) Time Zone',
      mapsUrl: original.mapsUrl,
      mapLabel: _mapLabels[original.mapLabel] ?? original.mapLabel,
      mapAsset: original.mapAsset,
      region: original.region,
      mapLatitude: original.mapLatitude,
      mapLongitude: original.mapLongitude,
      akses: [
        for (final (title, detail) in copy.access)
          {'title': title, 'detail': detail},
      ],
      organizer: copy.organizer,
    );
  }

  static Map<String, dynamic> _englishSlot(
    Map<String, dynamic> original,
    String row,
  ) {
    final separator = row.indexOf('|');
    if (separator < 1)
      throw FormatException('English rundown row is invalid: $row');
    return {
      ...original,
      'chip': _venues[original['chip']] ?? original['chip'],
      'judul': row.substring(0, separator),
      'deskripsi': row.substring(separator + 1),
    };
  }

  static String _dayLabel(String value) => value
      .replaceFirst('Hari ', 'Day ')
      .replaceAll('Jadwal', 'Schedule')
      .replaceAll('Okt', 'Oct')
      .replaceAll('Des', 'Dec')
      .replaceAll('Agu', 'Aug');

  static const _venues = <String, String>{
    'Area Pasar Kreatif': 'Creative Market Area',
    'Area Workshop': 'Workshop Area',
    'Panggung Utama': 'Main Stage',
    'Area Kuliner': 'Food Area',
    'Gerbang Festival': 'Festival Gate',
    'Panggung Pesisir': 'Coastal Stage',
    'Area Pantai': 'Beach Area',
    'Titik Kumpul Pantai': 'Beach Meeting Point',
    'Area Komunitas': 'Community Area',
    'Titik Kumpul': 'Meeting Point',
    'Kawasan Megalitikum': 'Megalithic Site',
    'Jalur Lanskap': 'Valley Trail',
    'Area Demo': 'Demonstration Area',
    'Panggung Kuliner': 'Food Stage',
    'Tepi Pantai': 'Beachfront',
    'Area Bahari': 'Marine Area',
    'Panggung Pantai': 'Beach Stage',
    'Area Bazar': 'Bazaar Area',
    'Area Showcase': 'Showcase Area',
    'Panggung Komunitas': 'Community Stage',
    'Jalur Laut': 'Sea Route',
    'Area Penginapan': 'Accommodation Area',
    'Perairan Togean': 'Togean Waters',
    'Pantai': 'Beach',
    'Jalur Pulau': 'Island Trail',
    'Area Pameran': 'Exhibition Area',
    'Panggung Kriya': 'Craft Stage',
    'Anjungan Danau': 'Lake Pavilion',
    'Plaza Kuliner': 'Food Plaza',
    'Tepi Danau': 'Lakeside',
    'Area Kriya': 'Craft Area',
    'Area Acara': 'Event Area',
  };

  static const _mapLabels = <String, String>{
    'Taman GOR, Kota Palu': 'Taman GOR, Palu City',
    'Anjungan Danau Poso, Tentena': 'Lake Poso Pavilion, Tentena',
    'Teluk Tomini, Parigi Moutong': 'Tomini Bay, Parigi Moutong',
    'Lembah Bada, Poso': 'Bada Valley, Poso',
    'Kota Palu, Sulawesi Tengah': 'Palu City, Central Sulawesi',
    'Pantai Pasir Panjang, Poso': 'Pasir Panjang Beach, Poso',
    'Kepulauan Togean, Tojo Una-Una': 'Togean Islands, Tojo Una-Una',
    'Banawa, Donggala': 'Banawa, Donggala',
  };

  static const _fallback = _EnglishCopy(
    location: 'Central Sulawesi',
    about: 'The organizer is preparing the details for this event. Check the Event page again for updates to the program, schedule, and venue.',
    programs: [
      'Event program|The organizer will announce the activities soon.',
    ],
    rundown:
        'Schedule to be announced|Check back for updates from the organizer.',
    access: [
      (
        'Travel information',
        'The organizer will announce the venue and travel directions.',
      ),
    ],
    organizer: ['Event Organizer', 'Official information coming soon'],
  );

  static final _copies = <String, _EnglishCopy>{
    'Pasar Kreatif Sulteng': const _EnglishCopy(
      location: 'Taman GOR, Besusu Tengah, Palu City',
      about: 'The Central Sulawesi Creative Market brings local crafts and regional flavors together in the open air at Taman GOR, Palu. Visitors can explore creations by local makers, try traditional food, and enjoy evening music with family and friends.',
      programs: [
        'Explore Local Crafts|Discover handmade products and creative work by local makers. Browse the selections...',
        'Taste Regional Food|Explore regional dishes and local treats across the event area. Find your favorites...',
        'Evening Music|Enjoy the late afternoon at Taman GOR with live music and good company...',
      ],
      rundown: '''
Opening & Market Stroll|Visitors explore local crafts, fashion, and food stalls.
Local Craft Demonstration|Makers show how their products are made and share the stories behind them.
Evening Music|Local musicians close the first day of activities.
Flavors of Central Sulawesi|Explore regional dishes and meet the people behind the food stalls.
Creative Product Showcase|Local businesses present selected products and the ideas behind them.
MSME Appreciation & Closing|A recap, recognition for participants, and a closing performance.
''',
      access: [
        (
          'From Tipo Terminal',
          'About 25 minutes by Trans Palu Bus Corridor 4B through the city (7.4 km).',
        ),
        (
          'From SIS Al-Jufri Airport',
          'About 14–25 minutes via Abdul Rahman Saleh Street and Moh Hatta Street (5.7 km).',
        ),
      ],
      organizer: [
        'Central Sulawesi Tourism Office & Palu City Government',
        'Official Central Sulawesi Tourism Calendar',
      ],
    ),
    'Festival Danau Poso ke-24': const _EnglishCopy(
      location: 'Lake Poso Waterfront, Tentena Pavilion, Poso Regency',
      about: 'One of Central Sulawesi’s longest-running cultural celebrations returns to the shores of Lake Poso. Watch a large Pamona dance performance, a decorated boat parade, craft displays, and lakeside cuisine. The festival brings residents and visitors together to enjoy Tentena’s traditions in the open air.',
      programs: [
        'Mass Motaro Dance|A welcoming Pamona dance fills the festival’s main stage.',
        'Pamona Decorated Boat Parade|Wooden boats in festive decorations sail past the lakeside crowd.',
        'Grilled Sogili Fish Festival|Discover local fish dishes and other Poso specialties at the food area.',
        'Weaving Crafts & Ethnic Music|Explore local crafts and enjoy an evening music performance.',
      ],
      rundown: '''
Cultural Carnival & District Parade|Pamona traditional dress parades with bamboo flutes and drums.
Opening & Mass Motaro Dance|The official opening is followed by a large dance at the lakeside.
Lake Harmony Night & Ethnic Acoustics|Enjoy live music and Poso specialties by the lake.
Pamona Decorated Boat Parade|Participating boats pass the crowd along the Tentena shore.
Craft & Weaving Exhibition|Local makers introduce Central Sulawesi textiles and handicrafts.
Ethnic Music Performance|Local musicians perform works inspired by Pamona culture.
Lake Cuisine Tour|Taste Poso specialties from local food vendors.
Pamona Cultural Performance|Traditional dance and music close the festival.
''',
      access: [
        (
          'From Kasiguncu Poso Airport',
          'Continue by road to Tentena and the lakeside pavilion.',
        ),
        (
          'From Palu City',
          'Travel by road toward Poso and Tentena; check route conditions before leaving.',
        ),
      ],
      organizer: [
        'Central Sulawesi Tourism Office & Poso Regency Government',
        'Central Sulawesi cultural calendar',
      ],
    ),
    'Festival Teluk Tomini (FTT)': const _EnglishCopy(
      location: 'Tomini Bay Coast, Parigi Moutong Regency',
      about: 'The Tomini Bay Festival brings the beauty of the coast together with creative work from Parigi Moutong. Visitors can watch a cultural carnival, discover local business products, and enjoy seafood. The activities create a welcoming place to gather by the bay.',
      programs: [
        'Tomini Coastal Carnival|A parade of costumes and performances by coastal communities.',
        'Local MSME Expo|Discover crafts and selected products from local businesses.',
        'Seafood & Music|Enjoy coastal dishes alongside local live music.',
      ],
      rundown: '''
Registration & Welcome|Visitors receive venue information and the festival program.
Festival Opening|Opening remarks and performances from coastal communities.
Marine Parade|Ocean-themed displays and community activities by the beach.
Explore the Coast|A guided activity introduces the environment and coastal life.
Stories of Tomini Bay|A conversation about maritime traditions and ocean conservation.
Coastal Arts & Music|Performances inspired by coastal culture.
Coastal Cleanup|Visitors and communities help clean the event area.
Taste the Coast|Enjoy local dishes and meet the food vendors.
Appreciation Night & Closing|Final performances bring the festival to a close.
''',
      access: [
        (
          'From Palu City',
          'Travel by road to Parigi Moutong and the Tomini Bay coast.',
        ),
        (
          'From central Parigi',
          'Continue to the festival venue announced by the organizer.',
        ),
      ],
      organizer: [
        'Parigi Moutong Local Government',
        'Central Sulawesi Event Calendar',
      ],
    ),
    'Jelajah Megalitikum Lore': const _EnglishCopy(
      location: 'Bada Valley, Poso Regency',
      about: 'The Lore Megalithic Journey invites visitors to explore ancient stone remains in Bada Valley. Local guides share stories about the landscape, community life, and efforts to protect the sites. Small groups help keep the visit comfortable and respectful of the area.',
      programs: [
        'Megalithic Site Walk|Explore ancient stone sites with a local guide.',
        'Stories of Bada Valley|Hear about the landscape and the community’s cultural heritage.',
        'Village Crafts & Food|Discover work and dishes made by nearby residents.',
      ],
      rundown: '''
Registration & Route Briefing|Learn the route, visiting rules, and trip preparations.
Explore the Sites|Visit megalithic remains with a local guide.
Stories of Lore History|Hear about local heritage and community life.
Morning Walk in Bada Valley|Enjoy the valley landscape while learning about the area.
Continue the Site Walk|Visit more sites with time for questions and photographs.
Reflection & Closing|Participants share their experiences before the journey ends.
''',
      access: [
        (
          'From Poso City',
          'Continue by road toward the Lore area and Bada Valley.',
        ),
        (
          'To the meeting point',
          'Confirm the meeting location and road conditions with the organizer before leaving.',
        ),
      ],
      organizer: [
        'Bada Valley Tourism Community',
        'Central Sulawesi Event Calendar',
      ],
    ),
    'Pekan Kuliner Kaili': const _EnglishCopy(
      location: 'Palu City, Central Sulawesi',
      about: 'Kaili Culinary Week presents the flavors of Palu in an open-air market. Visitors can taste selected dishes, talk with food vendors, and watch cooking demonstrations. The event gives local businesses a place to introduce their recipes and the stories behind them.',
      programs: [
        'Discover Kaili Flavors|Taste regional dishes from local food stalls.',
        'Regional Cooking Demonstration|See how selected ingredients and spices are prepared.',
        'Meet the Food Makers|Hear stories of local businesses and food traditions.',
      ],
      rundown: '''
Food Market Opening|Food stalls begin serving visitors.
Kaili Kitchen|Local makers demonstrate how traditional dishes are prepared.
Kaili Flavor Night|Explore food with light live music in the background.
Regional Breakfast|Try breakfast choices and hear the stories behind them.
Family Recipe Stories|Discuss recipes, ingredients, and Kaili food traditions.
Vendor Appreciation & Closing|Meet the food vendors and close the culinary week.
''',
      access: [
        (
          'From SIS Al-Jufri Airport',
          'Travel to central Palu using local transport.',
        ),
        (
          'From the city center',
          'Use the latest venue point shared by the organizer for final directions.',
        ),
      ],
      organizer: [
        'Palu City Food Businesses',
        'Central Sulawesi Event Calendar',
      ],
    ),
    'Festival Pantai Pasir Panjang': const _EnglishCopy(
      location: 'Pasir Panjang Beach, Poso Regency',
      about: 'The Pasir Panjang Beach Festival invites visitors to enjoy culture and coastal food by the sea in Poso. Boat races are a highlight, alongside performances and a seaside food market. The relaxed setting lets families enjoy the beach throughout the day.',
      programs: [
        'Coastal Boat Race|Watch participants race in the waters near the beach.',
        'Beach Food Market|Find seafood dishes and snacks from local vendors.',
        'Sunset Arts|Enjoy music and dance by the beach in the late afternoon.',
      ],
      rundown: '''
Visitor Welcome|Register and get to know the event area.
Coastal Games|Light recreational activities for visitors.
Sunset Performance|Local arts take the stage in the afternoon.
Beach Cleanup|Join an activity to keep the beach clean.
Creative Beach Contest|Group games and challenges with a coastal theme.
Food by the Sea|Explore local dishes while enjoying the beach.
Coastal Nature Walk|Learn about the beach environment with a guide.
Community Showcase|Local arts and community groups perform.
Appreciation & Closing|Announcements, thanks, and the festival closing.
''',
      access: [
        (
          'From Poso City',
          'Follow the road to the beach using the venue point shared by the organizer.',
        ),
        (
          'From outside Poso',
          'Plan your arrival in Poso City before continuing to the beach.',
        ),
      ],
      organizer: ['Poso Coastal Community', 'Central Sulawesi Event Calendar'],
    ),
    'Gelar UMKM Kota Palu': const _EnglishCopy(
      location: 'Taman GOR, Palu City',
      about: 'The Palu City MSME Fair brings local business products together in one easy-to-explore venue. Visitors can find crafts, souvenirs, and Kaili food while meeting their makers. The stage also hosts product demonstrations and light entertainment.',
      programs: [
        'Local Product Bazaar|Shop for crafts, fashion, and souvenirs made by Palu businesses.',
        'Taste of Kaili|Try traditional food from local stalls.',
        'Creative Product Demos|Watch makers demonstrate their work and process.',
      ],
      rundown: '''
MSME Fair Opening|Craft, product, and food stalls open to visitors.
Meet Local Products|Business owners introduce their featured products.
Afternoon Entertainment|Creative communities perform while visitors shop.
Packaging That Tells a Story|Explore ideas for packaging and product presentation.
Taste Local Products|Discover food and drinks from participating vendors.
Meet the Business Owners|A relaxed conversation about building a local business.
Shop Featured Products|A final chance to browse and buy from vendors.
Inspiring Business Stories|Local businesses share their experiences and plans.
Vendor Appreciation & Closing|A recap and closing of the MSME fair.
''',
      access: [
        ('From Tipo Terminal', 'Continue toward Taman GOR in central Palu.'),
        (
          'From SIS Al-Jufri Airport',
          'Take road transport to Taman GOR, Palu City.',
        ),
      ],
      organizer: [
        'Local Businesses & Palu City Government',
        'Central Sulawesi Event Calendar',
      ],
    ),
    'Wisata Pulau Togean': const _EnglishCopy(
      location: 'Togean Islands, Tojo Una-Una Regency',
      about: 'The Togean Island Tour offers a multi-day journey through the sea and island life. Activities include a boat crossing, island exploration, and snorkeling when conditions allow. Free time gives visitors a chance to meet local residents and enjoy the beach.',
      programs: [
        'Island Hopping|Stop at several islands and enjoy the seascape.',
        'Snorkeling|Discover marine life while following your guide’s instructions.',
        'A Night by the Beach|Rest and enjoy the island atmosphere after the journey.',
      ],
      rundown: '''
Registration & Gear Check|Check equipment and receive a safety briefing.
Travel to the Island|Cross by boat to the activity location.
Island Orientation|Learn about facilities, visiting rules, and the next day’s plan.
Snorkeling Preparation|Get a safety briefing and join your group.
Explore the Underwater World|Snorkel with a guide at the selected site.
Enjoy the Sunset|Relax and take photographs by the beach.
Island Nature Walk|Explore the landscape with a local guide.
Island Life Stories|Learn about everyday life and local culture.
Evening Together|Share a meal and stories from the journey.
Last Morning in Togean|Enjoy free time on the island.
Prepare to Return|Check belongings and review the return trip.
Return Journey|Depart by boat for the final destination.
''',
      access: [
        (
          'From Ampana',
          'Take a boat to the island according to the sailing schedule.',
        ),
        (
          'From outside Tojo Una-Una',
          'Plan to arrive in Ampana before your boat departure.',
        ),
      ],
      organizer: [
        'Togean Islands Local Guides',
        'Central Sulawesi Event Calendar',
      ],
    ),
    'Bazar Tenun Donggala': const _EnglishCopy(
      location: 'Banawa, Donggala Regency',
      about: 'The Donggala Weaving Bazaar connects visitors with weavers and the region’s distinctive textiles. Visitors can browse fabrics, watch weaving demonstrations, and hear the stories behind the patterns. Craft stalls and local dishes complete the friendly market atmosphere.',
      programs: [
        'Donggala Weaving Gallery|Browse patterns and fabrics made by local weavers.',
        'Weaving Demonstration|See the stages of fabric making directly from the makers.',
        'Craft & Food Market|Discover creative products and Donggala dishes.',
      ],
      rundown: '''
Weaving Bazaar Opening|Visitors begin exploring products from local weavers.
Meet the Tools & Threads|Weavers introduce materials and the first steps of making cloth.
Stories of Donggala Patterns|Learn about the designs and meanings behind the exhibited work.
Weave with the Makers|Watch weaving techniques and ask questions.
Explore Featured Crafts|Browse fabrics and meet their makers.
Weaver Appreciation & Closing|Weavers share their stories before the day closes.
Explore Donggala Patterns|View selected designs and hear the stories behind them.
Colors and Threads|Makers show the materials and processes that shape the textiles.
Meet the Weavers|Talk with fabric makers about their work and experiences.
Try Weaving|Learn basic weaving movements with a maker’s guidance.
Explore Local Products|Browse regional fabrics and crafts on display.
Craft Business Stories|Hear how makers bring their woven work to buyers.
Final Day Exhibition|A last chance to see and choose the weavers’ work.
Stories of Featured Patterns|Makers explain selected motifs and how they are made.
Weaver Appreciation & Closing|A recap, recognition of the work, and the bazaar closing.
''',
      access: [
        ('From Palu City', 'Travel by road to Banawa in Donggala Regency.'),
        (
          'From central Donggala',
          'Continue to the bazaar location shared by the organizer.',
        ),
      ],
      organizer: ['Donggala Weavers', 'Central Sulawesi Event Calendar'],
    ),
  };
}

class _EnglishCopy {
  final String location;
  final String about;
  final List<String> programs;
  final String rundown;
  final List<(String, String)> access;
  final List<String> organizer;

  const _EnglishCopy({
    required this.location,
    required this.about,
    required this.programs,
    required this.rundown,
    required this.access,
    required this.organizer,
  });
}
