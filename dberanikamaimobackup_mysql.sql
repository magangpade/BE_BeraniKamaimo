-- MySQL conversion of PostgreSQL dump; generated automatically
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `Event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nameEvent` LONGTEXT NOT NULL,
  `description_id` LONGTEXT NOT NULL,
  `description_en` LONGTEXT NOT NULL,
  `location_id` LONGTEXT NOT NULL,
  `location_en` LONGTEXT NOT NULL,
  `foto` LONGTEXT NOT NULL,
  `startdate` DATETIME(3) NOT NULL,
  `enddate` DATETIME(3) NOT NULL,
  `link_video` LONGTEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Hotel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama_hotel` LONGTEXT NOT NULL,
  `foto` LONGTEXT NOT NULL,
  `telepon` LONGTEXT NOT NULL,
  `jumlah_kamar` LONGTEXT NOT NULL,
  `jumlah_tempatTidur` LONGTEXT NOT NULL,
  `website` LONGTEXT,
  `link_gmaps` LONGTEXT NOT NULL,
  `lokasi` LONGTEXT NOT NULL,
  `link_video` LONGTEXT,
  `harga_maximum` LONGTEXT,
  `harga_minimum` LONGTEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Kuliner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama_makanan` LONGTEXT NOT NULL,
  `foto` LONGTEXT NOT NULL,
  `deskripsi_id` LONGTEXT NOT NULL,
  `deskripsi_en` LONGTEXT NOT NULL,
  `lokasi` LONGTEXT NOT NULL,
  `link_video` LONGTEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RumahMakan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `resto` LONGTEXT NOT NULL,
  `kulinerId` INT NOT NULL,
  `link_gmaps` LONGTEXT NOT NULL,
  `link_video` LONGTEXT,
  PRIMARY KEY (`id`),
  KEY `RumahMakan_kulinerId_idx` (`kulinerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TourPackage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama_wisata_id` LONGTEXT NOT NULL,
  `nama_wisata_en` LONGTEXT NOT NULL,
  `harga` LONGTEXT NOT NULL,
  `deskripsi_id` LONGTEXT NOT NULL,
  `deskripsi_en` LONGTEXT NOT NULL,
  `kontak` LONGTEXT NOT NULL,
  `media` LONGTEXT,
  `lokasi_id` LONGTEXT NOT NULL,
  `lokasi_en` LONGTEXT NOT NULL,
  `link_video` LONGTEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Ulasan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama` LONGTEXT NOT NULL,
  `rating` INT NOT NULL,
  `komentar` LONGTEXT NOT NULL,
  `createdAt` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama_Lengkap` LONGTEXT NOT NULL,
  `jenis_kelamin` LONGTEXT NOT NULL,
  `username` VARCHAR(191) NOT NULL,
  `password` LONGTEXT NOT NULL,
  `role` ENUM('Admin','user','superAdmin') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_username_key` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Visitor` (
  `id` VARCHAR(191) NOT NULL,
  `uid` VARCHAR(191) NOT NULL,
  `userAgent` LONGTEXT NOT NULL,
  `createdAt` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Visitor_uid_key` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `_prisma_migrations` (
  `id` VARCHAR(36) NOT NULL,
  `checksum` VARCHAR(64) NOT NULL,
  `finished_at` DATETIME(3),
  `migration_name` VARCHAR(255) NOT NULL,
  `logs` LONGTEXT,
  `rolled_back_at` DATETIME(3),
  `started_at` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
  `applied_steps_count` INT DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `desaWisata` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `namaDesa_id` LONGTEXT NOT NULL,
  `namaDesa_en` LONGTEXT NOT NULL,
  `deskripsi_id` LONGTEXT NOT NULL,
  `deskripsi_en` LONGTEXT NOT NULL,
  `lokasi_id` LONGTEXT NOT NULL,
  `lokasi_en` LONGTEXT NOT NULL,
  `foto` LONGTEXT NOT NULL,
  `longitude` LONGTEXT NOT NULL,
  `latitude` LONGTEXT NOT NULL,
  `jenisDesa` ENUM('DESA_UNGGULAN','DESA_WISATA') NOT NULL,
  `link_video` LONGTEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jarakDesa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `desaId` INT NOT NULL,
  `titikKota` ENUM('PALU','LUWUK') NOT NULL,
  `jalur_laut` LONGTEXT NOT NULL,
  `jalur_darat` LONGTEXT NOT NULL,
  `jalur_udara` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jarakDesa_desaId_idx` (`desaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pageView` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `page` LONGTEXT NOT NULL,
  `visitorId` VARCHAR(191) NOT NULL,
  `createdAt` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pageView_visitorId_idx` (`visitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `Event` (`id`, `nameEvent`, `description_id`, `description_en`, `location_id`, `location_en`, `foto`, `startdate`, `enddate`, `link_video`) VALUES
('19', 'Festival Ayam Bambu ', 'Festival Ayam Bambu adalah acara kuliner dan budaya yang diadakan di Kecamatan Kulawi, Kabupaten Sigi, untuk memperkenalkan dan melestarikan kuliner khas daerah tersebut, yaitu ayam bambu (ayam dimasak dalam bambu). Festival ini juga bertujuan untuk mendorong pariwisata lokal dan ekonomi kreatif di wilayah Kulawi Raya.', 'The Bamboo Chicken Festival is a culinary and cultural event held in Kulawi District, Sigi Regency, to introduce and preserve the regional culinary speciality, namely bamboo chicken (chicken cooked in bamboo). This festival also aims to encourage local tourism and the creative economy in the Greater Kulawi area.', 'Kecamatan Marawola, Kab. Sigi', 'Marawola District, Kab. Sigi', '/uploads/1775147070568.jpeg', '2026-09-01 00:00:00', '2026-09-01 00:00:00', ''),
('5', 'Festival Tumbe', 'Festival Tumbe merupakan salah satu event yang secara resmi menduduki kursi Kharisma Event Nusantara (KEN), sekaligus memperkuat posisinya sebaga representasi unik dari pariwisata berbasis budaya dan konservasi. Festival ini diselenggarakan di wilayah Banggai Kepulauan, yang dikenal dengan julukan “negeri pesona bahari dan tradisi”. Akses menuju kawasan ini dari Kota Palu memerlukan waktu sekitar 10–12 jam perjalanan, melalui kombinasi jalur darat dan laut yang sekaligus menjadi bagian dari pengalaman perjalanan.

Festival Tumbe adalah event yang mengemas tradisi Ritual Adat "Malabot Tumbe" atau pengantaran telur burung malelo yang pertama dari keluarga masyarakat adat Batui Kab. Banggai kepada Keluarga Batumondoan Banggai di Kab. Banggai Laut. Dalam pelaksanaannya, Malabot Tumbe melibatkan tiga Kabupaten yaitu Kabupaten Banggai, Kabupaten Banggai Kepulauan dan Kabupaten Banggai Laut yang bertujuan untuk mempererat rasa persaudaraan serta memegang teguh perintah leluhur untuk terus melestarikan ritual ini . Ritual Adat Pengantaran telur burung maleo yang pertama (Malabot Tumbe) ini telah dilaksanakan oleh masyarakat Banggai sejak tahun 1500-an dan masih berlangsung hingga kini.

Sebuah fenomena alam yang memiliki nilai ekologis tinggi dan telah menjadi bagian dari siklus kehidupan masyarakat setempat. Berbagai prosesi adat, pertunjukan seni, serta kegiatan berbasis komunitas diselenggarakan secara terstruktur, menunjukkan keterlibatan aktif masyarakat dalam menjaga keseimbangan antara tradisi dan lingkungan.

Dari sisi pengalaman, Festival Tumbe menghadirkan kesan yang kuat melalui keterhubungan yang nyata antara manusia dan alam. Aktivitas yang berlangsung secara alami, memberikan ruang bagi pengunjung untuk memahami makna di balik setiap tradisi yang ditampilkan. Ini adalah bentuk pariwisata yang berakar pada keaslian.

Sebagai bagian dari jaringan event nasional, Festival Tumbe menawarkan pengalaman yang tidak hanya berbeda, tetapi juga relevan dalam konteks pariwisata berkelanjutan. Jadwalkan perjalanan Anda ke Banggai Kepulauan, dan rasakan langsung bagaimana tradisi, alam, dan masyarakat bersatu dalam satu momentum istimewa di panggung KEN 2026.', 'The Tumbe Festival is one of the events that officially occupies the seat of Kharisma Event Nusantara (KEN), while strengthening its position as a unique representation of culture and conservation-based tourism. This festival is held in the Banggai Islands region, which is known as "the land of maritime charm and tradition". Access to this area from Palu City takes around 10-12 hours to travel, via a combination of land and sea routes which are also part of the travel experience.

The Tumbe Festival is an event that encapsulates the traditional ritual tradition of "Malabot Tumbe" or the first delivery of malelo bird eggs from the families of the indigenous people of Batui District. Proud to the Batumondoan Banggai Family in Kab. Banggai Laut. In its implementation, Malabot Tumbe involves three regencies, namely Banggai Regency, Banggai Islands Regency and Banggai Laut Regency, which aims to strengthen feelings of brotherhood and uphold ancestral orders to continue to preserve this ritual. The traditional ritual of delivering the first maleo bird egg (Malabot Tumbe) has been carried out by the Banggai people since the 1500s and is still ongoing today.

A natural phenomenon that has high ecological value and has become part of the life cycle of local communities. Various traditional processions, art performances and community-based activities are held in a structured manner, showing the active involvement of the community in maintaining a balance between tradition and the environment.

From an experience perspective, the Tumbe Festival makes a strong impression through the real connection between humans and nature. Activities that occur naturally provide space for visitors to understand the meaning behind each tradition displayed. It is a form of tourism rooted in authenticity.

As part of a national event network, the Tumbe Festival offers an experience that is not only different, but also relevant in the context of sustainable tourism. Schedule your trip to the Banggai Islands, and experience firsthand how tradition, nature and society come together in one special moment on the KEN 2026 stage.', 'Kabupaten Banggai Laut, Alun-alun Taman Kota Banggai dan Keraton Batumundoan Sulawesi Tengah', 'Banggai Laut Regency, Banggai City Park Square and Batumundoan Palace, Central Sulawesi', '', '2026-12-01 00:00:00', '2026-12-04 00:00:00', 'https://youtu.be/RLK9JlEaN_k?si=4XYUEdkl9CeMgNo7'),
('22', 'Festival Kaledo', 'Festival Kaledo adalah festival tahunan yang diadakan oleh Pemerintah kabupaten Donggala. Festival ini bertujuan untuk melestarikan dan mengenalkan masyarakat luas tentang salah satu kuliner khas di kabupten donggala yaitu KALEDO. Adapun rangkaian acara dalam fetival ini yakni, Bazar UMKM, ride palu to Donggala, Musik senja oleh Artis Ibukota, Seminar Gastronomi tentang Kaledo, dan Makan kaledo gratis untuk masyarakat', 'Kaledo Festival is an annual festival held by the Donggala district government. This festival aims to preserve and introduce the wider community to one of the typical culinary delights in Donggala Regency, namely KALEDO. The series of events in this festival are, MSME Bazaar, Hammer Ride to Donggala, Twilight Music by Capital Artists, Gastronomic Seminar on Kaledo, and Free Kaledo Eating for the community', 'Kota Donggala, Kabupaten Donggala', 'Donggala City, Donggala Regency', '/uploads/1775148129354.jpeg', '2026-10-16 00:00:00', '2026-10-18 00:00:00', ''),
('20', 'Festival Uta Dada', 'Festival Uta Dada adalah acara tahunan yang diselenggarakan oleh Dinas Pariwisata Kabupaten Sigi di Kecamatan Marawola, untuk melestarikan dan mempromosikan kuliner khas Suku Kaili, yaitu "Uta Dada". Festival ini bertujuan untuk memperkuat sektor pariwisata dan pertanian lokal serta mendorong pengembangan UMKM di Sigi.', 'The Uta Dada Festival is an annual event organized by the Sigi Regency Tourism Office in Marawola District, to preserve and promote the typical culinary specialty of the Kaili Tribe, namely "Uta Dada". This festival aims to strengthen the local tourism and agricultural sectors and encourage the development of MSMEs in Sigi.', 'Kecamatan Marawola, Kab. Sigi', 'Marawola District, Kab. Sigi', '/uploads/1789617259343.jpeg', '2026-09-02 00:00:00', '2026-09-02 00:00:00', ''),
('9', 'Festival Lupi', 'Festival Lupi merupakan festival pelestarian budaya Masyarakat di   kabupaten Tojo Una-Una khususnya di Kecamatan Ampana Kota. 
Festival Lupi Ampana yang sering di rujuk dalam konteks "Posintuvu Raya Lupi" atau Pesta Rakyat Malam Lupi, adalah sebuah perayaan budaya lokal yang bertujuan melestarikan warisan budaya 
masyakarat di kecamatan Ampana Kota, Kabupaten Tojo Una-Una, 
Sulawesi Tengah.
Poin penting mengenai Festival/Perayaan Lupi di Ampana :
- Sebagai Pusat Pelestarian Budaya, Menjadi ajang untuk 
menghidupkan kembali kearifan lokal dan budaya lokal agar tidak 
dilupakan oleh generasi muda.
- Wujud Gotong Royong (Posintuvu), Mencerminkan semangat 
kaloborasi, kreativitas, dan gotong royong masyarakat Tojo Una Una dalam membangun daerah.
- Kekayaan Budaya Dan Kuliner, Menampilkan perpaduan kreativitas budaya lokal dan sering kali melibatkan tenda kuliner tradisional, 
menjadi momen hiburan yang sering di serbu warga lokal.
- Identitas Lokal, Lupi sering di kaitkan dengan tradisi masyarakat 
setempat yang menyatu dalam harmoni perayaan, sering di hadiri 
oleh pejabat daerah seperti Wabup Tojo Una-Una.', 'The Lupi Festival is a community cultural preservation festival in Tojo Una-Una district, especially in Ampana Kota District. 
The Lupi Ampana Festival, which is often referred to in the context of "Posintuvu Raya Lupi" or Lupi Night Folk Festival, is a local cultural celebration that aims to preserve cultural heritage. 
community in Ampana Kota subdistrict, Tojo Una-Una Regency, 
Central Sulawesi.
Important points regarding the Lupi Festival/Celebration in Ampana:
- As a Cultural Preservation Center, Becoming an arena for 
revive local wisdom and local culture so that it doesn\'t 
forgotten by the younger generation.
- A form of mutual cooperation (Posintuvu), reflects the spirit 
collaboration, creativity and mutual cooperation of the Tojo Una Una community in developing the region.
- Cultural and Culinary Riches, Showing a mix of local cultural creativity and often involving traditional culinary tents, 
becomes a moment of entertainment that is often visited by local residents.
- Local Identity, Lupi is often associated with community traditions 
local communities united in harmony in celebration, often attended 
by regional officials such as Deputy Regent Tojo Una-Una.', 'Kecamatan Ampana Kota, Kab. Tojo Una Una', 'Ampana City District, Kab. Tojo Una Una', '/uploads/1789617373313.jpeg', '2026-03-12 00:00:00', '2026-03-15 00:00:00', ''),
('17', 'Festival Tanjung Lawaka', 'Festival Tanjung lawaka meruapakan festival rakyat yang di laksanakan oleh Kelompok Sadar Wisata (Pokdarwis) Desa labuan dengan menggelar lomba dan pertunjukan seni budaya dan pameran kuliner khas warga desa labuan.', 'The Tanjung Lawaka Festival is a folk festival held by the Labuan Village Tourism Awareness Group (Pokdarwis) by holding competitions and cultural arts performances and culinary exhibitions typical of Labuan village residents.', 'Desa Labuan, Kecamatan Ratolindo, Kab. Tojo Una Una', 'Labuan Village, Ratolindo District, Kab. Tojo Una Una', '/uploads/1775146346694.jpeg', '2026-08-12 00:00:00', '2026-08-12 00:00:00', ''),
('21', 'Tour De Bike Jelajah Togean', 'Kegiatan menjelajahi keindahan kepulauan togean sambil berolahraga seperti bersepada atau berlari melewati destinasi wisata yang ada dikepulauan togean, peserta juga dapat mengikuti lomba foto dan video.', 'Activities to explore the beauty of the Togean Islands while exercising such as cycling or running through tourist destinations in the Togean Islands. Participants can also take part in photo and video competitions.', 'Desa Lebiti Kecamatan Togean, Kab. Tojo Una Una', 'Lebiti Village, Togean District, Kab. Tojo Una Una', '/uploads/1775147893708.jpeg', '2026-10-01 00:00:00', '2026-10-01 00:00:00', ''),
('11', 'Festival Tampo Lore', 'Festival Tampo Lore merupakan event budaya berbasis kearifan         lokal yang diselenggarakan di Kec. Lore Tengah, Kabupaten Poso.    Festival ini menampilkan kekayaan tradisi, seni pertunjukan,  ritual       adat, kuliner khas, serta aktivitas masyarakat setempat yang           merefleksikan nilai-nilai budaya dan sejarah kawasan Lore. Event ini bertujuan melestarikan budaya lokal, memperkuat identitas            masyarakat adat,  serta mendorong pengembangan pariwisata berbasis komunitas (community based tourism) sebagai bagian dari promosi destinasi budaya Kabupaten Poso.
', 'The Tampo Lore Festival is a cultural event based on local wisdom which is held in the district. Central Lore, Poso Regency.    This festival displays a wealth of traditions, performing arts, traditional rituals, typical culinary delights, as well as local community activities that reflect the cultural and historical values ​​of the Lore region. This event aims to preserve local culture, strengthen the identity of traditional communities, and encourage the development of community-based tourism as part of the promotion of cultural destinations in Poso Regency.', 'Kec. Lore Tengah Kab. Poso', 'District Central Lore District. Poso', '/uploads/1788913934437.jpeg', '2026-06-28 00:00:00', '2026-06-30 00:00:00', ''),
('14', 'Buya Subi Festival', 'Event ini merupakan event untuk mempromosikan kain tenun Sulawesi Tengah dengan melibatkan 200 penenun. Acara ini juga merupakan kerja sama Dinas Pariwisata Provinsi Sulawesi Tengah dengan Eco Fashion Week Australia (EFWA)', 'This event is an event to promote Central Sulawesi woven fabrics involving 200 weavers. This event is also a collaboration between the Central Sulawesi Provincial Tourism Office and Eco Fashion Week Australia (EFWA)', 'Desa Towale, Kabupaten Donggala', 'Towale Village, Donggala Regency', '/uploads/1788913234301.jpg', '2026-07-07 00:00:00', '2026-07-07 00:00:00', ''),
('13', 'Festival Tampo Bada', 'Festival Tampo Bada merupakan event budaya yang diselenggarakan di kawasan Bada, Kabupaten Poso, sebagai upaya pelestarian adat istiadat dan warisan budaya megalitik setempat. Festival ini menampilkan seni pertunjukan tradisional, ritual adat, kuliner khas, serta pengenalan situs-situs budaya dan sejarah Lembah Bada. Kegiatan ini bertujuan memperkuat identitas budaya masyarakat lokal, meningkatkan partisipasi masyarakat, serta mendorong pengembangan pariwisata budaya berbasis kearifan lokal di Kabupaten Poso.
', 'The Tampo Bada Festival is a cultural event held in the Bada area, Poso Regency, as an effort to preserve local megalithic customs and cultural heritage. This festival displays traditional performing arts, traditional rituals, typical culinary delights, as well as an introduction to the cultural and historical sites of the Bada Valley. This activity aims to strengthen the cultural identity of local communities, increase community participation, and encourage the development of cultural tourism based on local wisdom in Poso Regency.', 'Kec. Lore Barat Kab. Poso', 'District West Lore District. Poso', '/uploads/1789616542697.JPG', '2026-09-07 00:00:00', '2026-07-09 00:00:00', ''),
('25', 'Togean Half Marathon', 'Togean Half Marathon adalah ajang lari wisata (Sport Tourism)         kegiatan ini di selenggarakan sebagai upaya memadukan olahraga 
dengan pariwisata. Event lari sekaligus mempromosikan destinasi 
Kepulauan Togean dan 
sekitarnya untuk mendongkrak kunjungan ke kawasan Taman         Nasional Kepulauan Togean, menarik pelari dari berbagai daerah di 
Indonesia. Yang telah di laksanakan ke 2 kalinya dengan kategori 
5K, 10K, dan 21K  dengan target peserta 3000 orang yang berasal   dari seluruh Indonesia.
', 'The Togean Half Marathon is a tourist running event (Sport Tourism). This activity is held as an effort to combine sports 
with tourism. Running event while promoting the destination 
Togean Islands and 
surrounding areas to increase visits to the Togean Islands National Park area, attracting runners from various regions in 
Indonesia. Which has been carried out for the 2nd time with categories 
5K, 10K and 21K with a target of 3000 participants from all over Indonesia.', 'Ampana Kab.Tojo Una-Una', 'Ampana, Tojo Una-Una Regency', '/uploads/1775460312158.png', '2026-01-12 00:00:00', '2026-01-12 00:00:00', ''),
('27', 'Festival Raudhah ', '“Festival Raodah Kota Palu: Harmoni Tradisi Islami Yang Menginspirasi” Temukan kedamaian dan keindahan dalam festival raodah, perayaan unik yang memadukan kekayaan tradisi islami dengan nuansa budaya lokal. Dengan mengingat jasa guru tua sambil menikmati lantunan dzikir rodah yang memukau, dan jelajahi bazar UMKM yang menawarkan produk khas kota palu. Festival ini adalah wujud harmoni religi dan budaya, mengajak anda untuk merasakan makna kebersamaan dan spiritualitas dalam setiap momen.
', '“Palu City Raodah Festival: Inspiring Harmony of Islamic Traditions” Find peace and beauty in the raodah festival, a unique celebration that combines the richness of Islamic traditions with local cultural nuances. Remember the services of the old teachers while enjoying the mesmerizing chanting of the dhikr wheel, and explore the MSME bazaar which offers typical products from the city of Palu. This festival is a form of religious and cultural harmony, inviting you to feel the meaning of togetherness and spirituality in every moment.', 'Jalan Sis-Aljufri, Kota Palu.', 'Sis-Aljufri Street, Palu City.', '/uploads/1775634959904.jpeg', '2026-03-06 00:00:00', '2026-03-07 00:00:00', ''),
('23', 'Festival Teluk Tomini', 'Festival Teluk Tomini digelar dengan ide dan gagasan yang menggiring opini masyarakat untuk lebih menghargai keberadaan laut dengan segala potensi dan sumber daya alam sebagai sumber kehidupan khususnya bagi masyarakat pesisir. Seiring dengan hal tersebut Festival Teluk Tomini mengemban misi mendorong dan melibatkan masyarakat untuk berpartisipasi menjaga dan memelihara ekosistem laut melalui berbagai macam aktivitas lingkungan yang diselenggarakan selama kegiatan.', 'The Tomini Bay Festival was held with ideas and concepts that lead public opinion to better appreciate the existence of the sea with all its potential and natural resources as a source of life, especially for coastal communities. In line with this, the Tomini Bay Festival carries out the mission of encouraging and involving the community to participate in protecting and preserving the marine ecosystem through various environmental activities held during the event.', 'Kabupaten Parigi', 'Paris Regency', '/uploads/1788913328684.jpeg', '2026-04-24 00:00:00', '2026-04-25 00:00:00', ''),
('12', 'Temu Lempeng', 'Temu lempeng adalah kegiatan yang diselenggarakan di titik 0        khatulistiwa yang melewati Kabupaten Donggala, tepatnya di desa  Siweli Kecamatan Balaesang. Kegiatan event yang diselenggaarakan berupa kegiatan pagelaran seni se kecamatan Balaesang,                 penampilan musik dari beberapa Artis serta bazar makanan UMKM. Kegiatan ini bertujuan untuk memperkenalkan masyarakat luas terhadap titik 0 Khatulistiwa yang berada di kabupaten Donggala bukan hanya ada di Pontianak tapi juga ada di Donggala.
', 'The plate meeting is an activity held at point 0 of the equator which passes through Donggala Regency, precisely in Siweli village, Balaesang District. Event activities held included art performances throughout the Balaesang sub-district, musical performances from several artists and a MSME food bazaar. This activity aims to introduce the wider community to point 0 of the Equator in Donggala district, not only in Pontianak but also in Donggala.', 'Desa Siweli, Kec. Balaesang Kab. Donggala', 'Siweli Village, District. Balaesang District. Donggala', '/uploads/1788912132037.jpg', '2026-07-03 00:00:00', '2026-07-04 00:00:00', ''),
('3', 'Festival Danau Lindu', 'Festival Danau Lindu merupakan bagian dari event terkurasi yang berhasil menempati kursi Kharisma Event Nusantara (KEN), mencerminkan kekuatan autentisitas budaya dan integritas lanskap yang dimilikinya. Festival Danau Lindu dilaksanakan di Danau Lindu, Desa Tomado Kecamatan Lindu Kabupaten Sigi berjarak sekitar 80 km dari Kota Palu Ibukota Sulawesi Tengah. luasnya 3.488 ha, terbentuk sekitar 3000 tahun yang lalu dan berada di tengah-tengah Zona Taman Nasional Lore Lindu dengan ketinggian 1.000 mdpl dikelilingi pegunungan hutan tropis yang lebat dengan keanekaragaman flora dan fauna endemik serta adat istiadat dan budaya masyarakatnya yang lestari.

Event ini dilaksanakan dalam rangka mendukung Program pengembangan Pariwisata Berkelanjutan dan inklusif oleh Bupati dan Wakil Bupati Sigi periode 2025-2030 menjadikan Lindu sebagai Destinasi Unggulan dan target destinasi prioritas bagi wisatawan baik lokal, nusantara maupun mancanegara untuk meningkatkan Pendapatan Daerah dan mewujudkan kesejahteraan masyarakat terutama masyarakat Lindu melalui sektor Pariwisata berbasis kolaborasi Pariwisata, Budaya dan Pertanian melalui program pengembangan wisata Alam (Ekowisata), Wisata Budaya dan Agrowisata.

Festival ini mengedepankan kekayaan budaya masyarakat adat Lindu yang diwujudkan melalui berbagai ritual tradisional, pertunjukan seni, serta aktivitas budaya yg sarat nilai filosofis. Setiap rangkaian kegiatan disusun secara kontekstual, memperlihatkan hubungan yang erat antara masyarakat dengan lingkungannya sekaligus menjadi media pelestarian tradisi yang berkelanjutan.

Dalam pengalaman yg ditawarkan, Festival Danau Lindu menghadirkan suasana yang lebih tenang dan reflektif. Lanskap danau yang hening, keberadaan kabut tipis pada waktu tertentu, serta minimnya intervensi modern menciptakan karakter destinasi yang eksklusif namun tetap bersahaja. Pengunjung tidak hanya menyaksikan, tetapi juga merasakan kedalaman nilai yang dihadirkan.

Festival ini menjadi pilihan tepat bagi pencari pengalaman wisata yang lebih bermakna dan berorientasi pada kualitas. Kunjungi Danau Lindu dan temukan sisi lain pariwisata Sulawesi Tengah, di mana kesederhanaan, budaya, dan alam berpadu dalam satu kesatuan yang utuh dalam panggung KEN.', 'The Lake Lindu Festival is part of a curated event that succeeded in occupying the Kharisma Event Nusantara (KEN) seat, reflecting the strength of its cultural authenticity and landscape integrity. The Lake Lindu Festival is held at Lake Lindu, Tomado Village, Lindu District, Sigi Regency, which is about 80 km from Palu City, the capital of Central Sulawesi. It covers an area of ​​3,488 ha, was formed around 3000 years ago and is in the middle of the Lore Lindu National Park Zone at an altitude of 1,000 meters above sea level, surrounded by dense tropical forest mountains with a diversity of endemic flora and fauna as well as the sustainable customs and culture of its people.

This event was held in order to support the Sustainable and inclusive Tourism development program by the Regent and Deputy Regent of Sigi for the 2025-2030 period to make Lindu a Leading Destination and a priority target destination for tourists both local, domestic and foreign to increase Regional Income and realize community welfare, especially the Lindu community, through the Tourism sector based on the collaboration of Tourism, Culture and Agriculture through the Natural Tourism (Ecotourism), Cultural Tourism and Agrotourism development programs.

This festival emphasizes the cultural richness of the Lindu traditional community which is manifested through various traditional rituals, artistic performances and cultural activities that are full of philosophical values. Each series of activities is structured contextually, showing the close relationship between society and its environment while also becoming a medium for sustainable tradition preservation.

In the experience offered, the Lake Lindu Festival presents a calmer and more reflective atmosphere. The serene lake landscape, the presence of light mist at certain times, and the lack of modern intervention create an exclusive but understated destination character. Visitors not only witness, but also feel the depth of the value presented.

This festival is the right choice for those seeking a more meaningful and quality-oriented tourism experience. Visit Lake Lindu and discover the other side of Central Sulawesi tourism, where simplicity, culture and nature combine in one unified whole on the KEN stage.', 'Tomado, Kecamatan Lindu, Kabupaten Sigi, Sulawesi Tengah', 'Tomado, Lindu District, Sigi Regency, Central Sulawesi', '', '2026-07-23 00:00:00', '2026-07-25 00:00:00', 'https://www.youtube.com/watch?v=lzGLjmFBGX0'),
('24', 'Festival Teluk Lalong', 'Festival Teluk Lalong tahun 2026 tetap mungusung konsep 
penguatan budaya lokal kabupaten Banggai dengan keanekaragaman adat istiadat dan budaya, tradisi,seni, kuliner dan kearifan lokal   daerah. Dengan Event ini akan memperkuat rasa bangga daerah     dan partisipasi masyarakat serta menjadikan budaya lokal sebagai  daya tarik utama pariwisata berkelanjutan.
', 'The 2026 Lalong Bay Festival will still have a concept 
strengthening the local culture of Banggai district with a diversity of customs and culture, traditions, arts, culinary delights and local regional wisdom. This event will strengthen the sense of regional pride and community participation and make local culture the main attraction of sustainable tourism.', 'Di Teluk Lalong, Kabupaten Banggai', 'In Lalong Bay, Banggai Regency', '/uploads/1789617125781.jpeg', '2025-11-03 00:00:00', '2025-11-06 00:00:00', ''),
('15', 'Bonesompe Fair', 'Bonesompe Fair Kabupaten Poso merupakan event pameran ekonomi kreatif dan UMKM yang bertujuan mendorong pengembangan produk lokal serta memperkuat perputaran ekonomi masyarakat. Kegiatan ini menampilkan berbagai produk unggulan daerah, seperti kuliner khas, kriya, fesyen, dan hasil inovasi pelaku ekonomi kreatif. Bonesompe Fair menjadi wadah promosi, jejaring usaha, dan peningkatan daya saing UMKM, sekaligus mendukung penguatan sektor pariwisata dan ekonomi kreatif sebagai penggerak pertumbuhan ekonomi Kabupaten Poso.', 'Bonesompe Fair Poso Regency is a creative economy and MSME exhibition event which aims to encourage the development of local products and strengthen the community\'s economic cycle. This activity displays various superior regional products, such as typical culinary delights, crafts, fashion and innovations from creative economy actors. Bonesompe Fair is a forum for promotion, business networking and increasing the competitiveness of MSMEs, as well as supporting the strengthening of the tourism sector and the creative economy as drivers of economic growth in Poso Regency.', 'Poso Kota, Kab. Poso', 'Poso City, District. Poso', '/uploads/1788911773764.jpeg', '2026-09-03 00:00:00', '2026-09-06 00:00:00', ''),
('4', 'Festival Danau Poso', 'Festival Danau Poso merupakan event unggulan Kabupaten Poso yang menjadi salah satu event strategis dan secara resmi menduduki kursi Kharisma Event Nusantara (KEN), menegaskan perannya sebagai ikon pariwisata unggulan di tingkat nasional. Diselenggarakan di kawasan Danau Poso, destinasi ini dikenal luas dengan julukan “permata biru khatulistiwa”. Berlokasi di Kabupaten Poso, kawasan ini dapat diakses dalam waktu sekitar 6–7 jam perjalanan darat dari Kota Palu, menghadirkan bentang danau tektonik yang luas dengan karakter air yang jernih dan lanskap yang relatif terjagah. diselenggarakan setiap tahun sebagai sarana promosi pariwisata, budaya, dan ekonomi kreatif daerah. 

Festival menampilkan beragam atraksi, seperti pertunjukan seni dan budaya lokal, lomba perahu tradisional, pameran UMKM dan ekonomi kreatif, serta kegiatan wisata alam. Festival Danau Poso berperan strategis dalam meningkatkan kunjungan wisatawan, menggerakkan perekonomian masyarakat, serta memperkuat citra Kabupaten Poso sebagai Daerah Tujuan Wisata Utama di Sulawesi.

Setiap aktivitas bukan sekadar atraksi, melainkan bagian dari narasi hidup yang merepresentasikan sejarah, nilai sosial, dan kearifan lokal yang tumbuh di sekitar danau.
Dari perspektif pengalaman, Festival Danau Poso menawarkan kualitas yang menyeluruh. Permukaan air yang tenang, garis horizon yang terbuka, serta ritme aktivitas yang berlangsung secara alami menghadirkan suasana yang berimbang. Lanskap dan budaya berjalan berdampingan, menciptakan kesan yang kuat sekaligus berkelas.

Sebagai destinasi yang terus berkembang dalam peta pariwisata nasional, Festival Danau Poso membuka ruang bagi siapa saja yang ingin merasakan harmoni antara alam dan budaya dalam satu perjalanan. Kini saatnya menjadikan Danau Poso sebagai tujuan berikutnya, dan merasakan langsung kualitas pengalaman yang ditawarkan dalam salah satu panggung terbaik KEN.

', 'The Poso Lake Festival is the flagship event of Poso Regency which is one of the strategic events and officially occupies the seat of the Kharisma Event Nusantara (KEN), confirming its role as a leading tourism icon at the national level. Held in the Lake Poso area, this destination is widely known as the "blue jewel of the equator". Located in Poso Regency, this area can be accessed in around 6-7 hours by road from Palu City, presenting a wide tectonic lake landscape with clear water and a relatively pristine landscape. held every year as a means of promoting regional tourism, culture and creative economy. 

The festival features various attractions, such as local arts and cultural performances, traditional boat races, MSME and creative economy exhibitions, as well as natural tourism activities. The Poso Lake Festival plays a strategic role in increasing tourist visits, driving the community\'s economy, and strengthening the image of Poso Regency as a major tourist destination in Sulawesi.

Each activity is not just an attraction, but rather part of a living narrative that represents the history, social values ​​and local wisdom that grow around the lake.
From an experience perspective, the Poso Lake Festival offers comprehensive quality. The calm water surface, open horizon line, and the rhythm of activities that occur naturally create a balanced atmosphere. Landscape and culture go hand in hand, creating a strong yet classy impression.

As a destination that continues to grow on the national tourism map, the Poso Lake Festival opens up space for anyone who wants to experience the harmony between nature and culture in one trip. Now is the time to make Lake Poso your next destination, and experience firsthand the quality of experience offered on one of KEN\'s best stages.', 'Anjungan FDP, Kota Wisata Tentena, Kec. Pamona Puselemba Sulawesi Tengah', 'FDP Pavilion, Tentena Tourist City, District. Pamona Puselemba Central Sulawesi', '/uploads/1788915271548.JPG', '2026-10-15 00:00:00', '2026-10-17 00:00:00', '');

INSERT INTO `Hotel` (`id`, `nama_hotel`, `foto`, `telepon`, `jumlah_kamar`, `jumlah_tempatTidur`, `website`, `link_gmaps`, `lokasi`, `link_video`, `harga_maximum`, `harga_minimum`) VALUES
('22', 'Hotel Santika palu ', '/uploads/1774568877468.jpg', '+62 451 424888', '144', '226', 'mysantika.com/indonesia/palu/hotel-santika-palu', ': -0.8968027.- 119.8728966', 'Jl. Moh. Hatta No.18, Lolu Utara, Kec. Palu Tim., Kota Palu, Sulawesi Tengah 94114.', '', '761671', '571463'),
('26', 'Rama Garden hotel ', '/uploads/1774570141538.jpg', '081145602200', '95', '131', 'Traveloka ', ' -0.902996, 119.882944.', 'Jl. Tj. Santigi No.26, Lolu Sel., Kec. Palu Sel., Kota Palu, Sulawesi Tengah 94111. Terdapat juga akses lobi melalui Jl. Wolter Monginsidi No.81.', '', '600000', '350000'),
('34', 'Aston Palu Hotel & Conference Center', '/uploads/1774574714116.jpg', '+62 811 4255 0027', '139', '159', 'Aston Hotels International - Aston Palu ', '-0.9022 + 119.8787', 'Jl. Wolter Monginsidi No.60, Lolu Sel., Kec. Palu Sel., Kota Palu, Sulawesi Tengah 94111.', '', '2000000', '727721'),
('46', 'Sutan Raja Hotel Palu', '/uploads/1774596473766.jpg', '+62 811-412-136', '121', '156', 'Situs Resmi: Saparaja Hotels - Sutan Raja Palu. ', '0.9168403 - 119.8973711', 'Jl. DR. Abdurrahman Saleh No.45, Birobuli Utara, Kec. Palu Sel., Kota Palu, Sulawesi Tengah 94111', '', '2000000', '606420'),
('47', 'Best Western Plus Coco Hotel', '/uploads/1774603126444.jpg', '+62 451 481500. ', '138', '221', 'Best Western Indonesia ', '-0.912648 - 119.889397', 'Jl. Basuki Rahmat No. 127, Birobuli Utara, Kec. Palu Selatan, Kota Palu. ', '', '846000', '756575'),
('49', 'Hotel Raja Akas', '/uploads/1774664175569.jpg', '0853-3333-3388', '5', '10', 'Traveloka ', '-0.916900, 119.885600', 'Jl. Towua No.15, Tatura Selatan, Palu Selatan, Kota Palu. ', '', '400000', '300000'),
('50', 'Cameloan Hotel', '/uploads/1774664421102.jpg', '+62 813-2227-795.', '20', '22', 'https://linktr.ee/hotelcameloan?utm_source=ig&utm_medium=social&utm_content=link_in_bio&fbclid=PAb21jcAQ0GiJleHRuA2FlbQIxMQBzcnRjBmFwcF9pZA81NjcwNjczNDMzNTI0MjcAAacvMe0yVKB0JLly50Le70JbFy8qK9Xv-Odi2gjVz0-EWxZVlEVFgoI-Iz_M4A_aem_ezXEeFR3T_rYervA4igMmg', '-0.906733, 119.882103', 'Jalan Tanjung Tururuka No. 43, Lolu Selatan, Palu Selatan, Kota Palu', '', '400000', '200000'),
('51', 'Hotel Medio Inn Palu', '/uploads/1774664849709.jpg', '+62 813-9939-9963', '15', '15', 'https://share.google/AB2OE50v4PL3yPgG5', '-0.914272, 119.889345', 'Jalan Tanjung Harapan, No.2, Tatura Utara, Kecamatan Palu Selatan, Palu Selatan, Palu, Sulawesi Tengah, Indonesia, 94111', '', '400000', '200000'),
('52', 'Hotel Kembang Joyo', '/uploads/1774665353693.jpg', '+62 811-4404-455. ', '29', '29', 'https://www.instagram.com/hotelkembangjoyo?igsh=MWJvbWxuMmFrZmY2Yg==', '-0.91356, 119.87604', 'Jl. Emmy Saelan No.118, Tatura Selatan, Kec. Palu Selatan, Kota Palu', '', '400000', '200000'),
('54', 'Brizky Hotel', '/uploads/1774666777431.jpg', '+62 851 5640 9048', '27', '37', 'https://share.google/3vzqjRQSPI5pd99kT', 'https://maps.app.goo.gl/gCoX1sWMA1u4Gagi9?g_st=ac', 'Jl. RE Martadinata No.03, Tondo, Kec. Mantikulore, Kota Palu, Sulawesi Tengah 94111', '', '400000', '280000'),
('55', 'Hotel kampung nelayan ', '/uploads/1774667275460.jpg', '+62 811-451-155', '16', '16', 'Kampoeng Nelayan Hotel, Palu - Diskon s.d 50% + Gratis Pembatalan https://share.google/km9v807srZuaJoCEe', 'https://maps.app.goo.gl/oujaCcnxiMkXtarC7', 'Jl. Kp. Nelayan No.99, Talise, Kota Palu.', '', '750000', '450000'),
('56', 'Front One Hotel', '/uploads/1774667757422.jpg', ' +62 853-3355-5128', '66', '103', 'Cek Front One Parama Su Hotel Palu di Booking.com! https://www.booking.com/Share-AamNb9', 'https://maps.app.goo.gl/CiMbrjHULSN6s7A58', 'Jl. Domba No. 28, Talise, Kec. Palu Tim., Kota Palu, Sulawesi Tengah 94118.', '', '550000', '250000'),
('57', 'Hotel Wina Beach', '/uploads/1774669669518.jpg', '+62 21 29707601', '10', '10', 'Oyo', 'https://maps.app.goo.gl/EvVGhQCQSR1dNCnF9', 'Jl. Kaombona / Jl. Teluk Raya No. 09, Talise, Kec. Mantikulore, Kota Palu, Sulawesi Tengah 94118. ', '', '350000', '200000'),
('62', 'Swiss Bell Hotel/Vila', '/uploads/1774680586354.jpg', '+62 451 461 888.', '115', '130', 'Cari dan Book hotel dan penginapan murah dan mudah dengan Traveloka https://share.google/TB7W7Cbij0xLCRplw', 'https://maps.app.goo.gl/SqnxsVFQuZZnvnQbA?g_st=ac', 'Jl. Malonda No.12, Silae, Kec. Ulujadi, Kota Palu, Sulawesi Tengah 94227.', '', '851761', '573301'),
('63', 'Hotel Jazz Anna', '/uploads/1774680843905.jpg', '+62 853-9500-9758.', '18', '40', 'OYO 1263 Jazz Anna Hotel, Palu - Diskon s.d 50% + Gratis Pembatalan https://share.google/1OxVQPgu5TOD7bWDZ', 'https://maps.app.goo.gl/BJmwjsFABxzi4NA47?g_st=ac', 'Teluk Bakau, Jl. Giliraja No.9, Labuan Bajo, Kec. Banawa, Kabupaten Donggala, 94351', '', '350000', '280000'),
('45', 'Jazz Hotel', '/uploads/1774596057314.jpg', '+62 821-8865-0387', '59', '93', 'Media Sosial: @jazz.hotelpalu di Instagram.', '-0.916120 - 119.901580', 'Jl. Zebra II No.11, Birobuli Utara, Kec. Palu Sel., Kota Palu, Sulawesi Tengah 94231. ', '', '483498', '350000'),
('48', 'Amazing Beach Resort ', '/uploads/1779510474262.jpg', '(0451) 465222', '38', '62', 'Traveloka ', 'https://maps.app.goo.gl/p2UCRFmJVkrnGgts6?g_st=ac', 'Jl. Malonda No. 76, Kel. Tipo Kecamatan Ulujadi, Palu Barat, Buluri, Kec. Ulujadi, Kota Palu, Sulawesi Tengah 94228', '', '1000000', '450000'),
('53', 'Grand Duta Hotel', '/uploads/1779514085575.jpg', '0821-8970-5578', '45', '74', 'https://share.google/VxVJnyRUIubE11sd7', 'https://maps.app.goo.gl/bRFQ9MEJ1tPS8tNg8?g_st=ac', 'Jl. Cumi-cumi, Lere, Kec. Palu Bar., Kota Palu, Sulawesi Tengah 94221', '', '680000', '350000'),
('65', 'Prince John Dive Resort', '/uploads/1774681630898.jpg', '+62 813-2173-8388', '15', '20', 'Prince John Dive Resort https://share.google/sQ7TuTt2FPOaqQA7f', 'https://maps.app.goo.gl/KyQEJeWX9BvU3cMz7?g_st=ac', 'Jl. Beringin, Kelurahan Tanjung Karang, Kecamatan Banawa, Kabupaten Donggala, Sulawesi Tengah 94351.', '', '2000000', '800000'),
('66', 'Boneoge Cliff House', '/uploads/1774681834123.jpg', '+62 823-9668-2019.', '8', '8', '@boneogecliffhouse', 'https://maps.app.goo.gl/ZhYhQ1xpCr6T9yAe8?g_st=ac', 'Boneoge, Kec. Banawa, Kabupaten Donggala, Sulawesi Tengah 94351', '', '800000', '800000'),
('68', 'Sangganipa Resort', '/uploads/1774682426111.jpg', '082156222530', '18', '27', 'https://www.instagram.com/sangganiparesort?igsh=MTYyc2kxdG4zeXl3MQ==', 'https://maps.app.goo.gl/16TQmZGjqgTAcvLT8?g_st=ac', 'Desa Towale', '', '200000', '100000'),
('69', 'Harmoni cottage', '/uploads/1774682669797.jpg', '0821-3270-8810.', '20', '20', 'https://share.google/8RYmsM0voGwnMWgqI', 'https://maps.app.goo.gl/Y95mWuQUz5y1d8Zd9?g_st=ac', 'Tanjung Karang, Kel. Labuan Bajo', '', '800000', '800000'),
('70', 'Tiga Makna Cottage', '/uploads/1774682826019.jpg', '0813-9884-0859', '12', '12', 'https://www.instagram.com/tigamakna_tanjungkarang?igsh=MXVjY3Zsenowb3dzcg==', 'https://maps.app.goo.gl/sVcwm7Fws3LJqMLq7?g_st=ac', 'Tanjung Karang, Kel. Labuan Bajo', '', '750000', '750000'),
('71', 'Natural Cottage', '/uploads/1774698173987.jpg', '0813-4147-1769', '8', '8', 'NATURAL COTTAGE (Donggala, Indonesia) - Ulasan Penginapan - Tripadvisor https://share.google/2OkMQxVJyJmEEj7FM', 'https://maps.app.goo.gl/S7PjMeQJZ9ETHe7F6', 'Tanjung Karang, Kel. Labuan Bajo', '', '600000', '600000'),
('72', 'Penginapan Dua Putra', '/uploads/1774698557571.jpg', '0812-2680-3469', '10', '18', 'Penginapan dan hotel murah di Kabupaten Donggala mulai dari Rp 68,740 | penginapan.co.id https://share.google/Qt9rGo7PbbALQgdyO', 'https://maps.app.goo.gl/KTvjA46pNnWZisNs7?g_st=ac', 'Banawa Selatan, Desa Watatu', '', '350000', '350000'),
('73', 'Bukit Indah Doda Hotel & Resorts', '/uploads/1774761317141.jpg', '0822-7118-6234.', '29', '29', 'Hotel Booking at Traveloka - Trusted Online Accommodation Booking Service https://share.google/n9jKrEye4m2IJBxBJ', 'https://maps.app.goo.gl/XhPrQZsewmGvuZZq8?g_st=ac', 'Jl. Totosi, Desa Doda, Kecamatan Kinovaro, Kabupaten Sigi', '', '2000000', '490000'),
('74', 'D\'Kalora Hotel & Convention', '/uploads/1774761472712.jpg', '0811-4560-4526', '43', '43', 'https://www.traveloka.com/id-id/hotel/detail?spec=29-03-2026.30-03-2026.1.1.HOTEL.9000000749673.d%27Kalora%20Hotel%20%26%20Resto.2&prevSearchId=1860972224438095440&mToken=pe5jE7QyqZtYzhaeE490sf4Njofh27H3s%2BOwTGNWcgO5AuYEpSR7uQD3sp1nAm%2FYaI0fVGdiYPdbrqXOFNIoEQ%3D%3D&metasearchRateId=desktop&priceDisplay=NIGHT&srss=1&contexts=%7B%22accessCode%22%3A%2293024GHAM2590mobile%22%2C%22metasearchRequestId%22%3A%22d8d38f62-f02f-4ddb-a6c6-ae9ae7aafb3d%22%2C%22plc%22%3A%22Q6jSPRVBiCx1TYPaBkuTHQDEzIVYTBfRzyspLYRnHTSrtMw88Tl47OSAK%2FmAISOOICIsZSHdWaQBqCnTIEaVgQ%3D%3D%22%2C%22inventoryRateKey%22%3A%22povEwB3ZzsU2C6pd%2B6MdU13LUNuufACdbU0usK5vg0eH8bAWKfhXnfjsxAV65wV0fwxXnYiRzoxM4HX9sDmt9%2FAm1AYn3MeGz8Xcpq5hCtjyBrZrfsWDdBZEEcgTHZAXfrNjTtcMNdBrV2J0lrzpxhoX6%2BYCgWSlJ8E2wBqOCWF8otv8bSqKOXvOEjXY5CMqgtOECjq9dxsNuV8klfxhLpqOGzdvHEKS1cFBUAPAMXDHdaVVQCcLc9EIhVgCq5vxrIYOBW%2BZoA8YYWcuVJrLbbF7IMZralp4Qoi414wN%2BoRtCokAr05jlRdEBNDC0WWzxcAOzXE5l6%2BwZAsTHk1C3Giq09pTC1Pq%2FGCcCQtfTuSCFWW%2F7TsSeYucY%2FLz3M%2BZNOJfLGRczWt5mSIbOsw69GlbvJZArdMwK%2BGzkTeA64EpQcnindWv1Y071wOXHefzhiBWHz0y%2F4E2rnjDpR%2BYAWWyoEJq6oPJO66jaJD%2Bm5%2FWqPYxQhAqYXrDxPqDyU7BdeO0nXTJ3aZm05Zx67KIybxUsUrw%2FN4IzVncBpVWD5JU8LO6FqVuGeopk3655osfROZR%2BwpJobilGVFQDTXoadomDoUuMEjk0Bs8ifzfPptBpm91DpTdLg%2B%2FzK6QY%2FIKeE2aFcP4gmkzhgfeLEmOBXoknlp08cs4YStdTvXPPEotusnvDk6Y5Uh8lutlEVW47bsILnjCYfWQQHWVMheW287JnywioxWNAhqvFD3QVJDCvypZUW409pDG%2B%2FRnjIZud%2BZr9FrhyJcCCaAkYrjTEHzSpIUrAjzVsYIyRcWotPcTq%2BynELKUrzF%2BczKMeBIu9IfCtZLIdw%2FiWfgp7sw0I9V3QWMM4jgdCn%2FHgDSR7eroc0CddqIDUIUNCgNNOW174hi0ZjDA8e9%2BvSrk8lr6KvT%2FXJgfJZyTw%2Bey%2Fh2Nkzk9bCUo9OOX38idTbaubeJ9ANA8Of0deUBva68mxPSrR9S4BGiV9PbgLrFgZEh7TxdWtHBNJquRDkUXerVNMlv%2B26WSEcur5yjoyLiA1SH2omymvXYEA%2BVYlSuKH1Ajbzc98chbexnVPqqn4Ccb18HYdVculjTX41NgY1x7oDBRp13nV%2F%2BK3aQJ4DVqJy5DSYJCXGfOiEomJcl%2FmUfUgCOxXjtDYxvwe%2B0JRxlmw%2BWO4lgfey5zCf%2BkzxMy4YgAaLaL9UnKBLJwvKa8dUakdZ353cqwDF4BBOEApJGSHAhDd%2F9GikvmNj65%2FhwIG%2BgL9jbQzrDqeHUz1VXrpfo05jg%2Ff7HYN%2BaYKyM%2Fy7%2Fgk4ULzoKkCsPj2M%2F5sJF5xGiFEznFCiqdMkaGOCnFdaEhSMpEQXMnD7TM4H%2B%2BfaLIS3u2uhAZPTAbBGvyCEUYoeO8R3odJcRYN3eKyNOCLCXIxPe6sacA2NC0Cuuw1ael0%2FKi2xNw7q9w%2FSeUzaPrbEm2Enl3dqQDWPxeKYGgJ7psz9aeGfNL%2FIBsURvWerX8ZJkmJN71UCbMchC%2B3eLeuwCDetn70%2Fp3iYPPtx7FOQ6fJHJkYBpo8r66MzSod5OGlz6Vv05PO7Y6iyivu9e6IfyvE86rwa6SmVjwRwhMxJDfq1MQro1mTooOPvrHCqvDbV08DQdBb0PD%2BPYxMBj5PC5qjJ3sjSFPgnZfcI7IK0tjw1xaHePESowMX9zjODxcaBjc1hKeHQMdNYawJmuvVsuFmMnD%2BWw5sQpCAUwzDqHmYvDg%2FtKW4G2VDv5qZfZtU9SSIny3%2B80N6RVheU2sEK4%2FsatCQtn%2BOOgetMQQmgNGgP7TsvLBvuLMxq3pMi4WIJWTw%2Betd6bbaufjjqZcEcNVyKAXuAXmTfBxtlhwI%2FjwFJ0BSnRCEDalws0XDyvuEj8b%2ByzrIPrVTMIHSwUMAhaFDQhxO8TYew5BUeUJQXszvCO9UUYbOD4BSWeUBzm0H2wewg%2F1AC01C2PWsZaKriZePPVlc9K6bxL%2BhFr5JGeK1112REyhflrZE6u1j9sbe3VS15I2BXuxPR7Hd7jCsM0pFJdU0D8uy9CHEDv41zNvLWwXNifsrlInrRbkJh9PzWYCxASYs%2F5CyyA2NlMhzBIl0CYathGSB9B4zcVodK00kxy95Efh1zAyzp%2FV4BmbZPP%2BRAhwYpFMkeufBDK433Cz2Jho2xIkFDI2qdffV%2FQ8KdtM%2FX6LVIeGRFreJ2SvMgI2PtofSIsgX3eox4lZsBvNqGPFxASvMJM8vr9jCGAeXuqirEnhDMZU1KbvumEGTI1vZw%3D%3D%22%7D&loginPromo=1', 'https://maps.app.goo.gl/kdUw8rAhgSDbtDX16?g_st=ac', 'Desa Kalora, Kecamatan Kinovaro, Kabupaten Sigi', '', '750000', '306000'),
('75', 'Penginapan Cemara ', '/uploads/1774761655543.jpg', '0811-4395-335.', '8', '8', 'Sisparnas ', 'https://maps.app.goo.gl/6NZGujB4wvPFeNdq8', 'Jl. Trans Sulawesi No.desa, Sausu Taliabo, Kec. Sausu, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '200000', '200000'),
('76', 'Penginapan Central Utama', '/uploads/1774761824554.jpg', '0853-4129-1879', '6', '6', 'Sisparnas ', 'https://maps.app.goo.gl/ref53yKT9dW3ue7U6', 'Jl. Trans Sulawesi No.242, Sausu Trans, Kec. Sausu, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '200000', '200000'),
('77', 'Penginapan Shafira', '/uploads/1774761981593.jpg', '0853-7775-3050', '10', '10', 'Sisparnas ', 'https://maps.app.goo.gl/XQACf89WqfbMkz469', 'Jembatan, Jl. Trans Sulawesi No.16, Sausu Taliabo, Kec. Sausu, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '250000', '150000'),
('78', 'Penginapan Jawa Timur', '/uploads/1774762196584.jpg', '0813-4135-3812', '10', '10', '-', 'https://maps.app.goo.gl/cPGJMgLKcRywmLof8?g_st=ac', 'Tolai, Kec. Torue, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '200000', '200000'),
('80', 'Guest House Puri Christy', '/uploads/1774762652955.jpg', '0813-3870-5888', '9', '9', 'https://www.instagram.com/hotel_puri_christy?igsh=MTZpdzgxZGtocTY0ZQ==', 'https://maps.app.goo.gl/tqrtM3PDHU55gkC66', 'Jl. Trans Sulawesi, Tolai, Kec. Torue, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '750000', '400000'),
('81', 'Hotel Zaitun ', '/uploads/1774763027711.jpg', '0822-1429-8553', '15', '15', 'https://www.instagram.com/zaitun.hotel?igsh=MXZwZmp4bjk1MXIxaQ==', 'https://maps.app.goo.gl/1HmA51c3K5EtDRZYA?g_st=ac', 'Jl. Trans Sulawesi, Tolai, Kec. Torue, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '350000', '90000'),
('84', 'Hotel New Oktaria', '/uploads/1774763860621.jpg', '0812-4240-0115', '13', '13', 'New Oktaria Homestay & Swimming Pool - Hotel Murah https://share.google/gE6pnzjCXlQDif8b2', 'https://maps.app.goo.gl/5iCZAsLVouejXVro9?g_st=ac', 'Belakang Kantor DPRD/ Dikbud, Jalan Uwemaisi (Belakang Dikbud, Masigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94417', '', '675000', '675000'),
('85', 'Hotel Oktaria', '/uploads/1774764190312.jpg', '0812-4240-0115', '20', '20', 'https://share.google/1G7oz4bqxpgGJfDWt', 'https://maps.app.goo.gl/tiFyY3JSbHUFUepA7?g_st=ac', 'JL. Jalur Dua Masigi', '', '350000', '250000'),
('88', 'Penginapan Prima', '/uploads/1774764946305.jpg', '0812-4405-5561', '17', '17', 'Sumber: Traveloka https://share.google/Fe6SNxe49aZPFsfsI', 'https://maps.app.goo.gl/JhXndJ32VVJCzGNd8', 'Depan SDN 2, Jl. Toraranga No.9, Maesa, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '400000', '250000'),
('117', 'Penginapan Gorontalo', '/uploads/1774875231229.jpg', '822-9333-3172', '6', '6', 'Sisparnas ', '0.852312, 120.191438', 'JL.Trans Sulawesi Desa Ampibabo', '', '200000', '100000'),
('67', 'Bone Bula Beach Front', '/uploads/1774682055717.jpg', '+62 821-1045-4451', '23', '23', '@bonebula_beachfront', 'https://maps.app.goo.gl/Tiz6vQb5qmhvKuEj8?g_st=ac', 'Towale, Kec. Banawa Tengah, Kabupaten Donggala, Sulawesi Tengah 94351', '', '800000', '500000'),
('86', 'Penginapan Margalau', '/uploads/1774764447540.jpg', '0813-4125-7697', '15', '15', 'Penginapan Margalau - Beranda | Facebook https://share.google/XffOQ5YkKA71mx0Vw', 'https://maps.app.goo.gl/arjqJNwM2Dpi9wrA9', 'Jl. Trans Sulawesi, Loji, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '150000'),
('83', 'Hotel Anutapura', '/uploads/1774763505639.jpg', '0821-9026-3775', '24', '24', 'Amenitas Pariwisata di Kabupaten Parigi Moutong https://share.google/O9sGdaezIrCyEoQzA', 'https://maps.app.goo.gl/VhuLK6gYX6NTssia8?g_st=ac', 'Jl. Kampali, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '450000', '450000'),
('79', 'Hotel Mitra Buana', '/uploads/1774762436508.jpg', '085341204251', '20', '20', 'Sisparnas ', 'https://maps.app.goo.gl/EiUds5p4a32Wt2vT6', 'Jl. Trans Sulawesi, Tolai, Kec. Torue, Kabupaten Parigi Moutong, Sulawesi Tengah 94473', '', '200000', '180000'),
('87', 'Losmen Kartika Abadi', '/uploads/1774764720582.jpg', '0812-4141-2486', '9', '9', 'Amenitas Pariwisata di Kabupaten Parigi Moutong https://share.google/z2dNJQxpDjolpHYKC', 'https://maps.app.goo.gl/7WkFaGk4iWGpUW6K9?g_st=ac', 'Jl. Sultan Hasanuddin, Loji, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '200000', '100000'),
('89', 'Homestay Mastro Nagaya', '/uploads/1774765233283.jpg', '0852-4101-6688', '13', '13', 'Sumber: Agoda.com https://share.google/DYo4KgPbCbm35PXLW', 'https://maps.app.goo.gl/ASpnvatJYhWRvKt37?g_st=ac', 'Maesa, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '350000', '250000'),
('91', 'Penginapan Fatimah I', '/uploads/1774765685362.jpg', '0813-1765-7666', '6', '6', 'Sumber: Facebook https://share.google/RWHFmc28nNZqeBNNJ', 'https://maps.app.goo.gl/22XVMY9ZRTngX8GV8', 'Jl. Pramuka, Bantaya, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '100000', '70000'),
('92', 'Penginapan Mujur', '/uploads/1774794297505.jpg', '0813-4384-7212', '7', '7', 'Sumber: Sisparnas https://share.google/VLVpf6GyLYubtwZyI', 'https://maps.app.goo.gl/BBoK5U5oRzqbTZwKA', 'Jl. Pramuka No.11, Bantaya, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94111', '', '150000', '100000'),
('93', 'Asni Hotel', '/uploads/1774794530178.jpg', '0853-4262-4430', '27', '27', 'Sumber: Sisparnas https://share.google/8CFmGm9loXUIaaoEx', 'https://maps.app.goo.gl/qX4L9QTwMgtXeVyQ6?g_st=ac', 'Penginapan Asni, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '275000', '275000'),
('99', 'Hotel Ludya', '/uploads/1774843297188.jpg', '0822-9604-2288', '13', '13', 'Sumber: Sisparnas https://share.google/pabM2ugN6SsFJyzLn', 'https://maps.app.goo.gl/VMxNfzAhqE9v49dv9', 'Jl. Trans Sulawesi, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '250000'),
('100', 'Penginapan Sartina I', '/uploads/1774843485163.jpg', '(0450) 21107', '7', '7', 'Jl. Trans Sulawesi No.62, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', 'https://maps.app.goo.gl/vZ4sK5MQG4ZPhxoDA?g_st=ac', 'Jl. Trans Sulawesi No.62, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '150000'),
('101', 'Penginapan Sartina Ii', '/uploads/1774843702718.jpg', '0852-4112-2555', '11', '11', 'Sumber: www.facebook.com https://share.google/X2DNshUn6WuuNIBFb', 'https://maps.app.goo.gl/dPVkgwUTxBah4ke9A?g_st=ac', 'Jl.Trans Sulawesi Desa Lebo', '', '250000', '150000'),
('103', 'Hotel Harison', '/uploads/1774844139795.jpg', '0821-8761-4444', '8', '8', 'Sumber: Instagram https://share.google/ksr8EjKiT3BOJB1W2', 'https://maps.app.goo.gl/vHv8F77FQpd74Use7?g_st=ac', 'Masigi, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '350000', '250000'),
('104', 'Grand Mitra ', '/uploads/1774844341786.jpg', '0821-9741-1785', '11', '11', 'Sumber: Facebook https://share.google/3qmClN8HOgD7xXyjS', 'https://maps.app.goo.gl/nxxhqC2Kg7wtwh7X6?g_st=ac', 'Jl. Finono No.Desa, Masigi, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '350000', '250000'),
('105', 'Hotel Ekonomi', '/uploads/1774844504721.jpg', '0822-7118-6234.', '12', '12', 'Sumber: Sisparnas https://share.google/nfChFf0gO89SQpcMj', 'https://maps.app.goo.gl/bHzFcnTF7TGjw36V9', 'Jl. Trans Sulawesi, Bambalemo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94371', '', '250000', '250000'),
('107', 'Zahra Guesthouse', '/uploads/1774873154816.jpg', '0853-4384-4444', '8', '8', 'Sumber: Sisparnas https://share.google/o2tCLmFG3NoNjLiQP', 'https://maps.app.goo.gl/JEK5yZpC4uuWW8yQ9?g_st=ac', 'Jalur dua, Bambalemo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '300000', '200000'),
('108', 'Penginapan Awinda', '/uploads/1774873449001.jpg', '0822-5950-8002', '5', '5', 'Sumber: Sisparnas https://share.google/kjOEyBaC2eqsP0R2P', 'https://maps.app.goo.gl/9QSrPXvcgsFaxJTz5?g_st=ac', 'Jl. Ue Maisi, Kel. Masigi', '', '250000', '150000'),
('112', 'Penginapan Cahaya Baru', '/uploads/1774874351469.jpg', '0852-4112-2555', '3', '3', 'Sisparnas ', '0.81232, 120.17942', 'JL.Trans Sulawesi Desa Avulua', '', '250000', '150000'),
('113', 'Penginapan Aisyah', '/uploads/1774874547835.jpg', '0822-5950-8002', '6', '6', 'Sisparnas ', '0.81232, 120.17942', 'JL.Trans Sulawesi Desa Toboli', '', '250000', '150000'),
('114', 'Penginapan Oshin', '/uploads/1774874656496.jpg', '0822-5950-8002', '3', '3', 'Sisparnas ', '0.81232, 120.17942', 'JL.Trans Sulawesi Desa Toboli', '', '250000', '150000'),
('95', 'Penginapan Rainbow', '/uploads/1774795032816.jpg', '0822-9699-5335', '11', '11', 'Sumber: Instagram https://share.google/dByDxoRWRT9dWlhwN', 'https://maps.app.goo.gl/z9qcFTdBK9wTZggp7?g_st=ac', 'Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '200000', '200000'),
('97', 'Grand Mitra Beach Lebo', '/uploads/1774842811124.jpg', '0821-8848-1114', '15', '15', 'https://share.google/hP7sSFyZMnxieN8zL', 'https://maps.app.goo.gl/aHs1QsfczHnXHeBv7?g_st=ac', 'Jl. Trans Sulawesi, Pantai, Lebo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '350000', '250000'),
('96', 'Penginapan Bambalemo Beach', '/uploads/1774842630796.jpg', '-', '17', '17', 'Sumber: Instagram https://share.google/3959HRP9I3arFBMic', 'https://maps.app.goo.gl/neU8w7g5ajAW9wwg8?g_st=ac', 'Bambalemo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '350000', '250000'),
('98', 'Penginapan Lebo Beach', '/uploads/1774843057079.jpg', '0852-4140-8668', '8', '8', 'Sumber: Sisparnas https://share.google/aLygk0LetugIplyme', 'https://maps.app.goo.gl/Bxr9uqDQXQw5R5Tx5', 'Jl. Trans Sulawesi, Lebo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '350000', '300000'),
('102', 'Penginapan Rima ', '/uploads/1774843990607.jpg', '0822-7117-7422', '6', '6', 'Sumber: Sisparnas https://share.google/kjTm2O9OfQbuOaU1P', 'https://maps.app.goo.gl/LrUZmyRqyQ3sbjSy5?g_st=ac', 'Jl. Pramuka, Bantaya, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '150000'),
('106', 'Hotel Tunas Harapan ', '/uploads/1774872998917.jpg', '0813-4100-3444', '13', '13', 'Sumber: Instagram https://share.google/E6kq6BhISdHYmlmVI', 'https://maps.app.goo.gl/ms1ADe7NfQD4Z6S67?g_st=ac', 'Jl. Trans Sulawesi, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '300000', '200000'),
('110', 'Pelawa Hotel', '/uploads/1774873886011.jpg', '0813-4100-2444', '9', '9', 'Sumber: Sisparnas https://share.google/uMOYGnLYLqCcX73FP', 'https://maps.app.goo.gl/quwfGxHQHP4P538v5?g_st=ac', 'Jl. Trans Sulawesi No.215, Pelawa, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '150000'),
('94', 'Penginapan Citra Berlian', '/uploads/1774794787243.jpg', '0811-457-163', '13', '13', 'Sumber: Instagram https://share.google/Arv8PQ2MdvmL1JLp2', 'https://maps.app.goo.gl/Pzy2KwsqEh7AEEea6?g_st=ac', 'Jl. Cinta, Kampal, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '220000', '165000'),
('109', 'Hasanah', '/uploads/1774873596612.jpg', '0812-4482-9115', '7', '7', 'Sumber: Sisparnas https://share.google/zuPOAWruyTnOuw2RI', 'https://maps.app.goo.gl/R57BSUPc7CjjG6xd6?g_st=ac', 'Jl. Trans Sulawesi, Bambalemo, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '150000'),
('111', 'Penginapan nur Arafah ', '/uploads/1774874177725.jpg', '0822-5950-8002', '5', '5', 'Sumber: Sisparnas https://share.google/RKv0h7eyoURZvvvdj', 'https://maps.app.goo.gl/4tMbYNR8cVrWsPSb8?g_st=ac', 'Jl. Trans Sulawesi, pertigaan, Toboli, Kec. Parigi Utara, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '250000', '150000'),
('115', 'Equator Dive Resort ', '/uploads/1774874796751.jpg', '0823-3677-0988', '11', '11', 'Sumber: Instagram https://share.google/K2w7OehsT2p3UDnnR', 'https://maps.app.goo.gl/c5XwGfgLd3tdrSZB7', 'Tandaigi, Kec. Siniu, Kabupaten Parigi Moutong, Sulawesi Tengah 94474', '', '800000', '500000'),
('116', 'D\' Marantale', '/uploads/1774875047660.jpg', '0812-4518-4040', '13', '13', 'Sumber: Instagram https://share.google/WnnvthMlT2xp0GpEo', 'https://maps.app.goo.gl/pjho9LRxQ1PrbiUL8?g_st=ac', 'Marantale, Kec. Siniu, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '450000', '250000'),
('120', 'Penginapan Syukur', '/uploads/1774948365957.jpg', '822-9388-8255', '4', '4', 'Sisparnas ', '0.812125, 120.198313.', 'JL.Trans Sulawesi Desa Toribulu', '', '250000', '150000'),
('121', 'Penginapan Chairul Salman', '/uploads/1774948493236.jpg', '822-9213-9833', '6', '6', 'Sumber: Sisparnas https://share.google/qY2tX5VrXmirjL3ge', 'https://maps.app.goo.gl/1rwFTjHF29QuY7BU6?g_st=ac', 'Dusun 2, Toribulu, Kec. Toribulu, Kabupaten Parigi Moutong, Sulawesi Tengah 94461', '', '250000', '150000'),
('122', 'Graha Pesona Beach', '/uploads/1774948645296.jpg', '0822-5238-2660', '10', '10', 'https://www.instagram.com/graha.posona.beach?igsh=MW54NGd4NnV2Zzl3cw==', 'https://maps.app.goo.gl/9sj6gFH4BT5gnHyXA?g_st=ac', 'Posona, Kec. Kasimbar, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '600000', '350000'),
('123', 'Penginapan Nirmala', '/uploads/1774948775650.jpg', '822-9213-9833', '7', '7', 'Sisparnas ', 'Penginapan Nirmala Tolitoli, Sulawesi Tengah, Indonesia 94511', 'JL.Trans Sulawesi Desa Kasimbar', '', '250000', '150000'),
('124', 'Penginapan Nusa Indah', '/uploads/1774948924408.jpg', '822-9222-2615', '7', '7', '-', 'Sumber: contact.page https://share.google/pDjYfJgikEFrzZOe1', 'JL.Trans Sulawesi Desa Kasimbar', '', '200000', '120000'),
('125', 'Penginapan Cendana', '/uploads/1774949152249.jpg', '852-4101-6688', '1', '1', 'agoda.com/id-id/cendana-homestay/hotel/palu-id.html?cid=1844104 https://www.agoda.com/id-id/cendana-homestay/hotel/palu-id.html?cid=1844104', 'https://maps.app.goo.gl/cmcLzwDAPzvuKpUF9?g_st=ac', 'Kasimbar Sel., Kec. Kasimbar, Kabupaten Parigi Moutong, Sulawesi Tengah 94474', '', '250000', '150000'),
('126', 'Penginapan Siaga Beach', '/uploads/1774949291739.jpg', '0853-9893-9545', '6', '6', 'Sumber: Sisparnas https://share.google/FxUWzPhrK81bAi8PE', 'https://maps.app.goo.gl/HYHivPbmrwYKu5dp8', 'Siaga, Kec. Tinombo Sel., Kabupaten Parigi Moutong, Sulawesi Tengah 94475', '', '250000', '150000'),
('127', 'Penginapan Rafa/ Khatulistiwa', '/uploads/1774949478789.jpg', '822-9213-9833', '3', '3', '-', '0.812850, 120.198425.', 'JL.Trans Sulawesi Desa Khatulistiwa', '', '250000', '150000'),
('132', 'Penginapan Annisa', '/uploads/1774950141215.jpg', '', '6', '6', '', '', 'Jl. Trans Sulawesi Ds. Tinombo', '', '250000', '150000'),
('135', 'Penginapan 888', '/uploads/1774950590199.jpg', '0852-5508-0277', '6', '6', '', 'https://maps.app.goo.gl/QyqoDbsfPAqvr4Xf8?g_st=ac', 'Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94475', '', '250000', '150000'),
('137', 'Penginapan Sabar', '/uploads/1774951124409.jpg', '822-9213-9833', '6', '6', '', '0.814850, 120.199625.', 'Jl. Trans Sulawesi Ds. Tinombo', '', '250000', '150000'),
('139', 'Penginapan Sederhana', '/uploads/1774951336182.jpg', '', '4', '4', '', '', 'jl.Tombolotutu', '', '180000', '180000'),
('140', 'Penginapan Ridho', '/uploads/1774951444915.jpg', '', '8', '8', '', 'https://maps.app.goo.gl/Ucydpk2sm3QSWkN26?g_st=ac', 'Jl. Trans Sulawesi No.12, Dusunan, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('141', 'Lolaro Resort 1', '/uploads/1774951609828.jpg', '0823-4710-1851', '8', '8', 'Sumber: Instagram https://share.google/9WRDBoERbchb8skJx', 'https://maps.app.goo.gl/z82TrXDMfzJ7Xc2v9', 'Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94475', '', '750000', '750000'),
('142', 'Penginapan Seavu', '/uploads/1775017844464.jpg', '0813-5425-5511', '5', '5', '', '.0.4136, 120.4435.', 'Jl. Mesjid, Ds. Tinombo', '', '250000', '150000'),
('143', 'Penginapan berkah ', '/uploads/1775018071134.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/DDMyh1cAN7FdbBQo7', 'Jl. Subangsi, Ds. Siapu', '', '250000', '150000'),
('144', 'Penginapan Kasih Ibu', '/uploads/1775106569600.jpg', '0821-9094-8995', '7', '7', 'Sumber: Sisparnas https://share.google/nLm6GfJ44q0aZAhWZ', 'https://maps.app.goo.gl/rUJAufBrPex2DJR27', 'Jalan Mawar Selatan, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('145', 'Penginapan Puri Asih', '/uploads/1775110510793.jpg', '', '7', '7', 'Sumber: Instagram https://share.google/R5UyzNMceLYA0m1sN', 'https://share.google/WG0itMksXhZtG78c9', 'Jl. Tadulako No.33, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('146', 'Penginapan Cemara I', '/uploads/1775110766096.jpg', '852-4113-1111', '13', '13', 'Sumber: Instagram https://share.google/hc8hRzzfCmmtXIaHW', 'https://share.google/zW3uwhOwSy9AYBBNS', ' Jl. Tadulako No.8, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('147', 'Penginapan Cemara ', '/uploads/1775111025148.jpg', '0822-9072-7398', '9', '9', '', 'https://maps.app.goo.gl/BRKMGSAyXh7pDhJB6?g_st=ac', 'Jl. Trans Sulawesi No.desa, Sausu Taliabo, Kec. Sausu, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '250000', '150000'),
('148', 'Penginapan Va-Fa', '/uploads/1775111571789.jpg', '0852-5618-7550', '25', '25', '', 'https://maps.app.goo.gl/9n5JfKj6ro3Fwey27?g_st=ac', 'Jl. Ki. Hajar Dewantara Ds.Kota Raya', '', '550000', '350000'),
('118', 'Penginapan Gading Gajah ', '/uploads/1774948034869.jpg', '822-9213-9833', '8', '8', 'Sumber: Sisparnas https://share.google/F1utgNLZFNx2LgsAF', 'https://maps.app.goo.gl/oPWAee6QgkSssi9w7?g_st=ac', 'Jl. Trans Sulawesi, Ampibabo, Kec. Ampibabo, Kabupaten Parigi Moutong, Sulawesi Tengah 94474', '', '250000', '150000'),
('128', 'Penginapan Danaya', '/uploads/1774949587175.jpg', '0823-9459-0666', '19', '19', '', 'https://maps.app.goo.gl/5VAjbSwUCtRgtNxXA?g_st=ac', 'Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('130', 'Penginapan Basmalah', '/uploads/1774949878206.jpg', '822-9213-9833', '4', '4', 'Sumber: BAPENDA PARIGI MOUTONG https://share.google/eEt9wV9cwaa6YK9Av', 'https://maps.app.goo.gl/c7vCFPihArnVLHC37?g_st=ac', 'Jl. Trans Sulawesi, Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('131', 'Penginapan Raflesia', '/uploads/1774950063206.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/KGoxBbG5in4qehPe9?g_st=ac', 'Jl. Trans Sulawesi, Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('133', 'Penginapan Angin Mamiri 1', '/uploads/1774950290026.jpg', '0812-4518-7226', '10', '10', 'Sumber: Yandex https://share.google/37lrR6oeDDrppUnyk', 'https://maps.app.goo.gl/cwSS36LZfDmTPLH26?g_st=ac', 'Jl. Pramuka, Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('134', 'Penginapan Angin Mamiri 2', '/uploads/1774950466923.jpg', '0812-4518-7226', '13', '13', 'Sumber: BAPENDA PARIGI MOUTONG https://share.google/oPf3iZdUYadnIHDxl', 'https://maps.app.goo.gl/S2KYSzKkTsqXbQoV6?g_st=ac', 'Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('136', 'Penginapan Tanjung', '/uploads/1774950773698.jpg', '0822-9116-6386', '10', '10', '', 'https://maps.app.goo.gl/aQnQE5FddDRpKjpV6?g_st=ac', 'Jl. Trans Sulawesi, Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94475', '', '250000', '150000'),
('138', 'Penginapan Ainun', '/uploads/1774951253249.jpg', '0857-9623-4873', '9', '9', '', 'https://maps.app.goo.gl/Q8Nc3qgygPGCNLwc7?g_st=ac', 'Jl. H.K. Tombolotutu, Tinombo, Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah 94476', '', '250000', '150000'),
('149', 'Penginapan Mutiara', '/uploads/1775111726430.jpg', '0852-5653-9706', '9', '9', '', '', 'Jl. Tadulako No.8, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '350000', '150000'),
('150', 'Penginapan Gryo 3 D', '/uploads/1775111990478.jpg', '0822-9271-0980', '10', '10', '', 'https://maps.app.goo.gl/fWnVCdW1mULGNCL96?g_st=ac', 'Unnamed Road, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '300000', '200000'),
('154', 'Penginapan Bumi Asri', '/uploads/1775112552096.jpg', '', '13', '13', '', 'https://maps.app.goo.gl/By6etqAPTEBdhi968?g_st=ac', 'Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('157', 'Penginapan Singgani', '/uploads/1775113036904.jpg', '', '5', '5', '', '', 'JL. Trans Sulawesi Desa Lambunu', '', '250000', '150000'),
('158', 'Hotel Kaltim', '/uploads/1775113137512.jpg', '', '10', '10', '', '0.4125, 120.4445', 'Kotanagaya Cabang 3', '', '250000', '150000'),
('161', 'Penginapan Dan Kafe Multazam', '/uploads/1775113547265.jpg', '', '22', '22', '', '0.4131, 120.4436', 'Jl Trans Sulawesi Desa Labuan', '', '250000', '150000'),
('163', 'Home Stay Jess', '/uploads/1775113807073.jpg', '0812-5552-2625', '10', '10', '', 'https://maps.app.goo.gl/QoNNxEgMCF47on9o9', 'Jl. Trans Sulawesi, Moutong Tengah, Kec. Moutong, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('164', 'Hotel Theresia', '/uploads/1775113947746.jpg', '+62821-9249-0952', '10', '10', 'Hotel Theresia | Moutong https://share.google/ONkOWx0PvpgzD2LFN', 'https://maps.app.goo.gl/cYN68uc3zbVPgumK6?g_st=ac', 'Moutong Tengah, Kec. Moutong, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('165', 'Hotel Pelangi ', '/uploads/1775114125046.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/YsXo2eeUNkuC5F7C9?g_st=ac', 'Moutong Tengah, Kec. Moutong, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '250000', '150000'),
('166', 'Hotel Intan', '/uploads/1775114260612.jpg', '0821-9205-2614', '14', '14', 'Sumber: Facebook https://share.google/7YuiejrrkB9uPtAvV', 'https://maps.app.goo.gl/BgYhzp21Wk5kpN2RA', 'Jl. Borman No.22, Moutong Tengah, Kec. Moutong, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '250000', '150000'),
('167', 'Hotel Asmora', '/uploads/1775114382874.jpg', '', '10', '10', 'Sumber: Instagram https://share.google/efV8tTGc3Ae8Oa3Vk', 'https://maps.app.goo.gl/JT4sdevEGqoX6phU7?g_st=ac', 'JL. Borman Moutong Tengah', '', '350000', '200000'),
('168', 'Hotel Mitra Utama', '/uploads/1775198243330.jpg', '0813-4030-9511', '20', '20', 'https://share.google/LfK9On1zI6VftBJ7O', 'https://maps.app.goo.gl/avMjZTbm6BqFM3Q7A?g_st=ac', 'Jl. Malatuang, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '350000', '188000'),
('169', 'Hotel Bumi Harapan', '/uploads/1775198391860.jpg', '0851-4503-2870', '26', '26', 'Sumber: Instagram https://share.google/RGIOfCGpKt4RhNCi6', 'https://maps.app.goo.gl/pSkR34m5vzjC5yBj6?g_st=ac', 'Jl. Sultan Hasanuddin No.54, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '350000', '200000'),
('170', 'Hotel Suryadi', '/uploads/1775198692453.jpg', '0823-4939-6919', '9', '9', 'Sumber: Facebook https://share.google/XsYY7qKtVErNB8qqU', 'https://maps.app.goo.gl/QvfgGfFTYcBUnaGH6', 'Jl. Magamu No.95, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '400000', '188000'),
('171', 'Hotel Kota Cengkeh', '/uploads/1775198955313.jpg', '0852-4144-6666', '12', '12', 'Sumber: Instagram https://share.google/UuN7Izy8haWLCVFKE', 'https://maps.app.goo.gl/dRu32Qnm9sFq7WEw9', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '350000', '200000'),
('172', 'Hotel Harmoni KC', '/uploads/1775199135258.jpg', '0852-4144-6666', '11', '11', 'Sumber: Instagram https://share.google/wckvJGLlFU3OVIm7W', 'https://maps.app.goo.gl/QyX7dYCoQWiz7qn59?g_st=ac', 'Jl. Veteran II Gg.Sidodadi, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '150000', '110000'),
('173', 'Penginapan Bersehati ', '/uploads/1775199293284.jpg', '0877-8500-1778', '15', '15', 'Sumber: Instagram https://share.google/xkG6HvYuSyuey2MF4', 'https://maps.app.goo.gl/u2taqiR55hh6RQjdA?g_st=ac', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('176', 'Hotel Griya Baru', '/uploads/1775289486986.jpg', '0853-9724-7841', '13', '13', 'Sumber: Facebook https://share.google/RFKmdXcNxugXvUjCJ', 'https://maps.app.goo.gl/Vpq4XA6iJ6WUwK396?g_st=ac', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('178', 'Penginapan bersehati Jaya', '/uploads/1775290310180.jpg', '0852-4133-8339', '8', '8', 'Amenitas Pariwisata di Kabupaten Toli-toli https://share.google/gZf2hTmwQyEx1PBB5', 'https://maps.app.goo.gl/mKaWWnTWjvnGt4Qc6', 'Jl. Ladapi No.22, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('155', 'Penginapan Puri Asih I ', '/uploads/1775112758137.jpg', '', '8', '8', '', 'https://maps.app.goo.gl/ft5F25MZKue58vTu8', 'Jl. Sumber Agung, Sumber Agung, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('152', 'Penginapan Cemara II', '/uploads/1775112267915.jpg', '811-439-5335', '6', '6', '', 'https://maps.app.goo.gl/y1FXBEcj5sEvLJmo7?g_st=ac', 'Jl. Tadulako, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('159', 'Penginapan Hikmah', '/uploads/1775113256653.jpg', '0853-9416-1517', '7', '7', '', 'https://maps.app.goo.gl/m6genWjYSHc5CotB9', 'Cabang tiga, Jl. Britama Desa.Kotanaga, Lambunu, Kec. Bolano Lambunu, Kabupaten Parigi Moutong, Sulawesi Tengah 96000', '', '250000', '150000'),
('156', 'Penginapan Mokosua', '/uploads/1775112940049.jpg', '0813-5465-2246', '8', '8', 'Sumber: Facebook https://share.google/dZjFepVpN6Lki30Tq', 'https://maps.app.goo.gl/qhgLcZAYztfadkEf7?g_st=ac', 'Jl. Trans Sulawesi, Bolano, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('160', 'Penginapan Ojo Lali', '/uploads/1775113377270.jpg', '0822-4652-3695', '4', '4', '', 'https://maps.app.goo.gl/wNhn66iooon2gaKu5', 'Jl. Trans Sulawesi, Palapi, Kec. Taopa, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('162', 'Hotel Sakana Beach', '/uploads/1775113671679.jpg', '0821-9624-6246', '7', '7', '', 'https://maps.app.goo.gl/CZ5mJnZzMAC9Y3Zb7?g_st=ac', 'Jl. Trans Sulawesi, Salumpengut, Kec. Moutong, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('174', 'Hotel Ardinta', '/uploads/1775199505355.jpg', '0813-4141-3614', '6', '6', 'Sumber: Kementerian Pariwisata Republik Indonesia https://share.google/RghbsNeuZayFoBRZZ', 'https://maps.app.goo.gl/Jc6e8QJDo3EwQ1cu5?g_st=ac', 'Jl. Abdul Muis, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('175', 'Hotel Sulbar Beach', '/uploads/1775201801935.jpg', '0813-4200-7414', '7', '7', '', 'https://maps.app.goo.gl/vv6XrzaxLS4vEf5X7?g_st=ac', 'Jl. S. Panggesar, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '750000', '350000'),
('177', 'Penginapan Abadi Jaya', '/uploads/1775289754903.jpg', '0822-9310-4856', '5', '5', 'Sumber: Facebook https://share.google/GNeGqNimKqrvhGE43', 'https://www.google.com/maps/place/Penginapan+Abadi+Jaya/@1.0430074,120.8217896,17z/data=!3m1!4b1!4m6!3m5!1s0x32712b4a5589424b:0x55ecd6a454ce5220!8m2!3d1.043002!4d120.8243699!16s%2Fg%2F11bw7dkg3k?entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Jl. Belibis, Tuweley, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '200000', '150000'),
('182', 'Losmen Iloheluma', '/uploads/1775291126686.jpg', '', '13', '13', 'Losmen Iloheluma https://share.google/wbh26eGzgNkwLVllD', 'Losmen Iloheluma https://share.google/wbh26eGzgNkwLVllD', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('185', 'Penginapan Makassar ', '/uploads/1775291833409.jpg', '812-4277-2222', '6', '6', '', 'https://maps.app.goo.gl/JfAcyUJJLjBNgGVN8?g_st=ac', 'Jl. HL. Waani No.48, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('186', 'Wisma Sawerigading', '/uploads/1775291986062.jpg', '0821-8820-5050', '10', '10', '', 'https://maps.app.goo.gl/fUYR3mnZu7yuqKbdA?g_st=ac', 'Jl. Veteran Bumi Harapan No.6, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '200000', '150000'),
('187', 'Boki Dive and Home stay', '/uploads/1775292141558.jpg', '0811-8114-325', '6', '6', 'Bokidive.com', 'https://maps.app.goo.gl/CaTMhTnKqXWr5CS5A?g_st=ac', 'Jl. Gajah Mada No.1, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '550000', '350000'),
('188', 'Penginapan Pingkan', '/uploads/1775292334127.jpg', '813-4141-3614', '8', '8', 'Sumber: Kementerian Pariwisata Republik Indonesia https://share.google/qVIJLgcn5rtcwVEjp', 'https://maps.app.goo.gl/kU6bb1rTn81na62o7', 'Panasakan, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '200000', '200000'),
('189', 'Losmen Medan Sehati', '/uploads/1775292449392.jpg', '0813-5444-7722', '9', '9', '', 'https://maps.app.goo.gl/sGxMFxz7CptTZbRn9?g_st=ac', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '200000', '100000'),
('190', 'Penginapan Al Fi\'ry.', '/uploads/1775292737951.jpg', '0813-2227-795', '8', '8', '', 'https://maps.app.goo.gl/HPcnoBF2zBgDiCfG9?g_st=ac', 'Jl. Belibis No.18, Tuweley, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '250000', '150000'),
('191', 'Penginapan Villaris', '/uploads/1775292823376.jpg', '812-4277-2222', '4', '4', '', '', 'Jl Radio Kabinuang', '', '250000', '150000'),
('194', 'Berlian Mamala Resort', '/uploads/1775445621487.jpg', '0811-451-404', '22', '33', 'Sumber: Instagram https://share.google/JFYPOtlV7EXReGn7o', 'BERLIAN MAMALA RESORT https://share.google/2fKLoe125NUmEJpYD', 'Jl. Poros Ganda-Ganda', '', '1200000', '450000'),
('195', 'Rhia Homestay', '/uploads/1775445763101.jpg', '0852-4223-4213', '4', '8', 'Sumber: Facebook https://share.google/7eG3fFHrXJk2CFSNb', 'https://maps.app.goo.gl/DgJDQwB1jAnarWSU8', 'Belakang toko wajo karpet, Jalan poros, Ganda Ganda, Sulawesi Tengah 94671', '', '350000', '250000'),
('196', 'Hotel Jompi Wisata', '/uploads/1775445898860.jpg', '0852-4056-7637', '21', '32', 'Sumber: Instagram https://share.google/spctn3J7zNQCbGxow', 'https://maps.app.goo.gl/59HnxUZQWGXdp8rAA?g_st=ac', 'Jl. dr. Sahardjo Poros Ganda Ganda, Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '450000', '250000'),
('197', 'D&G Motel', '/uploads/1775446039287.jpg', '0852-4237-1753', '7', '11', 'Sumber: Facebook https://share.google/GCgQnUe4MGRQDO0aT', 'https://maps.app.goo.gl/ACFif2oYp56z6i1m9', 'Samping Kantor BPJS, Jl Poros, Ganda Ganda, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '450000', '250000'),
('198', 'Hotel Kuda Laut', '/uploads/1775446156926.jpg', '0822-9630-3141', '12', '18', 'Sumber: Instagram https://share.google/1CmaKdZQhGQbGNus9', 'https://maps.app.goo.gl/GbQeaYNcqqaqP6eTA?g_st=ac', 'Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '450000', '250000'),
('200', 'Pondok The Kozy', '/uploads/1775446422143.jpg', '0851-4505-3441', '11', '17', '', 'https://maps.app.goo.gl/KVDFcNrfG9UfuQ726?g_st=ac', 'Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '450000', '250000'),
('201', 'Penginapan Ebi', '/uploads/1775446666630.jpg', '', '11', '17', '', 'https://maps.app.goo.gl/s8j8QwF4s3SRpF9w8?g_st=ac', 'Jl. Tarundungi No.5, Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '200000'),
('203', 'J&J 1', '/uploads/1775447079738.jpg', '0823-1644-2705', '11', '17', 'Sumber: Instagram https://share.google/GNhhtiBpXihalfoCG', 'https://maps.app.goo.gl/ms6ofX83hK1t4QVs7', 'Bahontula, Kec. Petasia, Kabupaten Morowali, Sulawesi Tengah 94971', '', '350000', '250000'),
('204', 'J&J 2', '/uploads/1775447325374.jpg', '0823-1644-2705', '10', '30', '', 'https://maps.app.goo.gl/NqJv7onpLtLuV9Tk8', 'Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('205', 'Home Stay Foksa', '/uploads/1775447751617.jpg', '0822-1674-1743', '10', '30', '', 'https://maps.app.goo.gl/6tqqA5YHEGeq4hYD6', 'Jalan W Monginsidi No.2, Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '189000'),
('180', 'Penginapan Nirmala', '/uploads/1775290604682.jpg', '', '11', '11', '', 'https://maps.app.goo.gl/QVi23W8jGsM8rnms7?g_st=ac', 'Jl. RA Kartini, Panasakan, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '200000', '150000'),
('183', 'Penginapan Fikri 1', '/uploads/1775291306239.jpg', '', '12', '12', 'Sumber: Booking.com https://share.google/Lk3AGcG2DLAuukC35', 'https://maps.app.goo.gl/fKNeZNeVVvMNHA7j6?g_st=ac', 'Jl. Merpati, Unnamed Road, Tuweley, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '200000', '150000'),
('181', 'Penginapan Mete Galang', '/uploads/1775290834940.jpg', '0852-9315-7838', '6', '6', '', 'https://maps.app.goo.gl/s7DsSHkG7c8FUAx2A?g_st=ac', 'Jl. Yoto, Tuweley, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '250000', '150000'),
('184', 'Wisma Fikri 2', '/uploads/1775291449872.jpg', '0822-7102-6580', '11', '11', '', 'https://maps.app.goo.gl/2MwJDXWbCgEEzQFM7?g_st=ac', 'Jl. Belibis, Tuweley, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94512', '', '200000', '150000'),
('192', 'Hotel Alatas', '/uploads/1775292954245.jpg', '0812-8574-5428', '14', '14', 'Sumber: Instagram https://share.google/GA6jH2zVXEuwbZkcr', 'https://maps.app.goo.gl/so6pbq91z5B3c7MZ6?g_st=ac', 'Jl. Sultan Hasanuddin, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '400000', '250000'),
('193', 'Penginapan Sederhana', '/uploads/1775293065716.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/5umBvKAfRpCw7sJ77?g_st=ac', 'Jl. K.H. Wahid Hasyim, Unnamed Road, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('202', 'Guest House By Tapi', '/uploads/1775446934581.jpg', '0823-9628-7420', '4', '7', 'https://www.instagram.com/guesthousebytapi?igsh=YTMzd211dXh6N2lh', 'https://maps.app.goo.gl/J7VdghdzYJvV7t8X6', 'Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('206', 'Wisma Jey\'S', '/uploads/1775447919559.jpg', '', '13', '25', '', 'https://maps.app.goo.gl/wgaczVgKa8N3KKmd7', 'Jl. Yos Sudarso, Korololama, Kec. Petasia, Kabupaten Morowali, Sulawesi Tengah 94971', '', '250000', '180000'),
('207', 'Sederhana', '/uploads/1775448070928.jpg', '0852-4106-2961', '13', '20', '', 'https://maps.app.goo.gl/CB3XDSzsK4DFCojq7', 'Jl. Yos Sudarso, Kolonodale, Kec. Petasia, Kabupaten Morowali, Sulawesi Tengah 94971', '', '350000', '250000'),
('208', 'Losmen Jumpandang', '/uploads/1775448552837.jpg', '+1 609-434-3343', '17', '23', '', 'https://maps.app.goo.gl/1iYYYjDWFfjdju866', 'Jl. Yos Sudarso, Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('209', 'Penginapan Daffa Homey ', '/uploads/1775448823741.jpg', '0811-4540-602', '7', '14', 'Sumber: Instagram https://share.google/SrWMsKnaPm1ThS9iL', 'https://maps.app.goo.gl/XxvDNUSuNfB1UBTB6?g_st=ac', 'Jl. Bumi Nangka, Bahontula, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('211', 'Ozon Guest House', '/uploads/1775449127571.jpg', '0812-2238-0463', '5', '8', '', 'https://maps.app.goo.gl/Tj8wBVzTotHJTj5N7?g_st=ac', 'Jl. Lkr. Luar Kolonodale, Korololaki, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94671', '', '350000', '200000'),
('212', 'Penginapan Ade Mala', '/uploads/1775449246467.jpg', '822-9216-2495', '3', '5', '', '1.983944, 121.332306 ', 'Korololama', '', '250000', '150000'),
('215', 'Penginapan Novena', '/uploads/1775449576292.jpg', '0822-1574-3231', '17', '23', '', 'https://maps.app.goo.gl/yMrPLn1WQMDaGEuV9?g_st=ac', 'Bahontula, Kec. Petasia, Kabupaten Morowali, Sulawesi Tengah 94971', '', '250000', '150000'),
('216', 'Dian Homestay', '/uploads/1775449653016.jpg', '0822-1574-3231', '3', '6', '', 'https://maps.app.goo.gl/YCD4GhnakQaGn3sS8', 'Bahontula, Kec. Petasia, Kabupaten Morowali, Sulawesi Tengah 94971', '', '250000', '150000'),
('219', 'Penginapan Sarthika', '/uploads/1775449954094.jpg', '', '4', '10', '', 'https://maps.app.goo.gl/ySPZriMWS1TffWmx5?g_st=ac', 'Jl. Andi . Muhammad, tanggul pelangi, Kolonodale, Sulawesi Tengah 94971', '', '250000', '150000'),
('220', 'Penginapan Diandra', '/uploads/1775450366678.jpg', '813-4100-3444', '4', '10', '', '1.983995, 121.346853.', 'Jl. Poros Ganda-Ganda', '', '350000', '250000'),
('221', 'Penginapan Tera', '/uploads/1775450515590.jpg', '0821-8729-6101', '4', '10', '', 'https://maps.app.goo.gl/71Zokzt4syhBQHx5A?g_st=ac', 'Kec, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('225', 'Pelangi', '/uploads/1775450992937.jpg', '0811-458-401', '11', '17', '', 'https://maps.app.goo.gl/GosZW1Et2d4qoDaf8?g_st=ac', 'Jalan Tarundungi, Bahontula, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('228', 'Penginapan Diandra', '/uploads/1775532131891.jpg', '822-9216-2495', '4', '10', '', '1.983944, 121.332306', 'Jl. Poros Ganda-Ganda', '', '250000', '150000'),
('229', 'Penginapan Tera', '/uploads/1775532249418.jpg', '0821-8729-6101', '4', '10', '', 'https://maps.app.goo.gl/REHBWZnGmg7ajN8D8', 'Kec, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('232', 'Guest House Reysa', '/uploads/1775532665822.jpg', '0858-2431-3231', '10', '15', '', 'https://maps.app.goo.gl/UwAwSfdAC1tLy1Sd9', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '350000', '200000'),
('233', 'Penginapan Harapan Kita', '/uploads/1775532815070.jpg', '0822-9950-7978', '6', '9', '', 'https://maps.app.goo.gl/2GuNp6STX42cF86dA?g_st=ac', 'Jl. Trans Tompira, Tompira, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah', '', '350000', '150000'),
('235', 'Wisma Bintang Emas', '/uploads/1775533013524.jpg', '0852-6668-6700', '7', '11', '', 'https://maps.app.goo.gl/nMUjzcVvEf1RKdPF6?g_st=ac', 'Bunta, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah', '', '250000', '150000'),
('236', 'Bellagio Guest House', '/uploads/1775533115218.jpg', '0822-9952-1540', '20', '30', '', 'https://maps.app.goo.gl/9bNr8Pu9qPcuY5o66?g_st=ac', 'Tompira, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '550000', '450000'),
('238', 'Penginapan 27', '/uploads/1775544268845.jpg', '0851-1771-5277', '13', '20', 'https://taplink.cc/penginapan27molino', 'https://maps.app.goo.gl/ybKSbAAdYXdVEXPP7', 'Jl. Trans Sulawesi Samping Kompi No.B 714, Molino, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah 94963', '', '250000', '150000'),
('214', 'Penginapan Grand 21', '/uploads/1775449475842.jpg', '0851-4390-9788', '8', '12', '', 'https://maps.app.goo.gl/qRVRedEoosrjbWqe6?g_st=ac', 'Jl.trans Sulawesi, Korololama, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('217', 'Zayba Homey House', '/uploads/1775449725673.jpg', '', '7', '11', '', 'https://maps.app.goo.gl/gGWAVqCPDTZSKmTi6?g_st=ac', 'Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94671', '', '350000', '250000'),
('218', 'Penginapan Jts', '/uploads/1775449809936.jpg', '', '3', '6', '', 'https://maps.app.goo.gl/8CRteQiv359ymvHM9?g_st=ac', 'Jl. Lkr. Luar Kolonodale, Korololaki, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('222', 'Wisma Keyla', '/uploads/1775450649269.jpg', '0812-4807-7024', '3', '6', '', 'https://maps.app.goo.gl/L7Lf3xKjyfUtbbJA9?g_st=ac', 'Jl. Wolter Mongisidi, Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('223', 'Wisma Utama', '/uploads/1775450760253.jpg', '0812-4348-8855', '4', '10', '', 'https://maps.app.goo.gl/imo9GwWgH7iXB7JE6', 'Jl. Wolter Mongisidi, Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('224', 'Aulia Inn', '/uploads/1775450862997.jpg', '0813-5556-1062', '9', '14', '', 'https://www.google.com/maps/place/Auliya+Inn/@-1.981784,121.3421763,21z/data=!4m6!3m5!1s0x2d8fe612888f1f77:0x9b6c6a6465554eae!8m2!3d-1.9816945!4d121.3422621!16s%2Fg%2F11c6lydmqp!18m1!1e1?entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Unnamed Road, North Morowali Regency, Central Sulawesi 94971', '', '400000', '150000'),
('227', 'Penginapan Tompira 1', '/uploads/1775482355976.jpg', '0823-4462-3307', '2', '3', '', 'https://maps.app.goo.gl/VGAXBQekRMVq7F6CA?g_st=ac', 'Jl. Trans Sulawesi, Tompira, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('226', 'Riska', '/uploads/1775451109869.jpg', '0822-9678-7870', '5', '8', '', 'https://maps.app.goo.gl/82HpivD55gswEVyf7?g_st=ac', 'Jl. Yos Sudarso, Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('230', 'Penginapan Puncak Tompira', '/uploads/1775532398533.jpg', '', '10', '15', '', 'https://maps.app.goo.gl/gWQDvRWVdmpTUF9cA?g_st=ac', 'Jl. Trans Sulawesi, Solonsa, Kec. Wita Ponda, Kabupaten Morowali, Sulawesi Tengah 94976', '', '550000', '400000'),
('231', 'Penginapan Trans Sulawesi', '/uploads/1775532564829.jpg', '0822-9563-5623', '11', '17', '', 'https://maps.app.goo.gl/8za4ii1FPTH3AgYp6', 'Jl. Trans Sulawesi, Molino, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('234', 'Anggun Homestay', '/uploads/1775532919824.jpg', '0853-4044-4000', '7', '11', '', 'https://maps.app.goo.gl/1LyD6RPmMEeszoEA9?g_st=ac', 'Jl. Trans Sulawesi, Bunta, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '150000'),
('237', 'Penginapan Sartika', '/uploads/1775533254634.jpg', '0822-3960-1632', '4', '6', '', 'https://maps.app.goo.gl/tD3LG5fSQxiV23ZU7', 'Jl. Trans Sulawesi, Bungintimbe, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah', '', '250000', '150000'),
('239', 'Puri Kapala 70', '/uploads/1775544359848.jpg', '', '6', '9', '', 'https://maps.app.goo.gl/nYtq4NiCTs8tQx3B7?g_st=ac', 'Jl. Trans Sulawesi, Bunta, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('240', 'Bravo', '/uploads/1775544516400.jpg', '0822-1798-1658', '10', '15', '', 'https://maps.app.goo.gl/MZqfPHJyykUWbr9D9?g_st=ac', 'Bunta, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('241', 'Putri Cantal', '/uploads/1775544639985.jpg', '0822-1142-1789', '15', '22', '', 'https://maps.app.goo.gl/3tDPjBi8wpVLD89E7', 'Bunta, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah', '', '250000', '150000'),
('242', 'Two Brother Homestay', '/uploads/1775544756831.jpg', '0858-2128-2846', '10', '15', '', 'https://maps.app.goo.gl/8f9rnVnKuvj2Xqaz6?g_st=ac', 'Bunta, Kec. Petasia Timur, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('245', 'Affifo', '/uploads/1775545304885.jpg', '822-9653-6255', '7', '11', '', '2.010156, 121.368685', 'Lembah sumara', '', '250000', '150000'),
('246', 'Cak Lamongan', '/uploads/1775545394292.jpg', '822-1142-1789', '4', '6', '', '2.008453, 121.368541', 'Panca Makmur', '', '250000', '150000'),
('247', 'Arsya', '/uploads/1775545501040.jpg', '858-8195-1713', '2', '3', '', '2.023249, 121.317540', 'Panca Makmur', '', '250000', '200000'),
('252', 'Hani ', '/uploads/1775546377212.jpg', '0823-5300-6542', '8', '12', '', 'https://maps.app.goo.gl/5hvkLmW3uPSzFEzB6?g_st=ac', 'Baturube, Kec. Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('255', 'Anugrah', '/uploads/1775546866939.jpg', '0822-3620-6112', '8', '12', '', 'https://maps.app.goo.gl/vphoj3jQmAbRbzNVA?g_st=ac', 'Jl. Trans Sulawesi, Beteleme, Lembo, North Morowali Regency, Central Sulawesi 94966', '', '350000', '150000'),
('257', 'Rayhan', '/uploads/1775547354979.jpg', '0852-4105-7431', '7', '11', '', 'https://maps.app.goo.gl/vs6CG4NnRN8cNZ9a6', 'Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('261', 'Jawa Timur', '/uploads/1775547962647.jpg', '', '19', '29', '', '', 'Desa Tanaku Raya (wilayah Baturube), Kecamatan Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah.', '', '250000', '150000'),
('262', 'Golden', '/uploads/1775548111889.jpg', '0853-9525-2008', '12', '18', '', 'https://maps.app.goo.gl/U6sW3LEFzAEqouDv9?g_st=ac', 'Unnamed Road, Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('264', 'Guest House Ponteoa', '/uploads/1775548390518.jpg', '0823-1158-3110', '8', '12', '', 'https://maps.app.goo.gl/ySthBZ36K4SAycyf7?g_st=ac', 'Lorong Omega (Samping CU. Wita Mori) ±50, meter ke dalam, Tinompo, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('267', 'Sopwa Royal Hotel ', '/uploads/1775582587090.jpg', '0822-9699-8388', '20', '29', '', 'https://maps.app.goo.gl/NjFUqW3cbAEaMTvK8?g_st=ac', 'Jln.lorong bandara, Keurea, Kec. Bahodopi, Kabupaten Morowali, Sulawesi Tengah 94951', '', '550000', '250000'),
('271', 'Penginapan Nanda San', '/uploads/1775583416787.jpg', '', '3', '5', 'Sumber: Sisparnas https://share.google/VoQvYSz3ndYhlb9Ne', '', 'Desa Pandiri, Kecamatan Mori Atas/Peonea, Morowali Utara.', '', '250000', '150000'),
('274', 'Penginapan Rifky', '/uploads/1775583820807.jpg', '', '6', '9', '', 'https://share.google/JUqww7A9uAAmJxuim', 'Bahodopi, Kec. Bahodopi, Kabupaten Morowali, Sulawesi Tengah 94974', '', '350000', '150000'),
('275', 'Penginapan Jamor', '/uploads/1775583975562.jpg', '0822-7114-0066', '13', '20', '', 'https://maps.app.goo.gl/U2scNJ6raWHc6wmr6', 'Unnamed Road, Tana Sumpu, Kec. Mamosalato, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '350000', '150000'),
('248', 'Jember Indah', '/uploads/1775545711068.jpg', '', '5', '8', '', 'https://maps.app.goo.gl/4DUJzH2TwyA1kaiVA?g_st=ac', 'Tanaku Raya, Kec. Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('249', 'Fitri Jaya', '/uploads/1775545895442.jpg', '', '4', '6', '', 'https://maps.app.goo.gl/2i1cLfbrpFHMKzZz5', 'Jl. Trans Sulawesi, Rata - Baturube, Tanaku Raya, Kec. Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('250', 'Bunga Tani', '/uploads/1775546032727.jpg', '', '13', '20', '', 'https://maps.app.goo.gl/W9vJr4H3nsoeWN2G6?g_st=ac', 'Jl. Trans Sulawesi, Tanaku Raya, Kec. Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('251', 'Anita', '/uploads/1775546221686.jpg', '0813-5510-1781', '11', '17', '', 'https://maps.app.goo.gl/yxTmhQg5CAYgG4u99?g_st=ac', 'Baturube, Kec. Bungku Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('253', 'Nurfita', '/uploads/1775546493121.jpg', '0852-9992-0695', '5', '8', '', 'https://maps.app.goo.gl/VgtCZMJ92Erauzu69?g_st=ac', 'Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('254', 'Simpati', '/uploads/1775546713837.jpg', '', '10', '15', '', 'https://maps.app.goo.gl/D7Y6ZPnkBVARyVMq9', 'Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('256', 'Homestay Khairos', '/uploads/1775547088094.jpg', '0853-4169-5906', '14', '21', 'https://maps.app.goo.gl/padDzbn2ycyE7gUb7?g_st=ac', 'https://maps.app.goo.gl/padDzbn2ycyE7gUb7?g_st=ac', 'Jl.Togolinde, Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '350000', '200000'),
('258', 'Diamond', '/uploads/1775547500914.jpg', '0813-5498-9150', '7', '11', '', 'https://maps.app.goo.gl/tUqdqqNH1KEkQnG97', 'Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('259', 'Nur Aziza', '/uploads/1775547645611.jpg', '0857-5738-9813', '11', '17', '', 'https://maps.app.goo.gl/DC32fzgTShSm3c11A', 'Jl. Trans Sulawesi, Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah', '', '250000', '150000'),
('260', 'Deli\'S Losmen', '/uploads/1775547750909.jpg', '', '3', '5', '', 'https://maps.app.goo.gl/JccWjX7DZm7MpcGX6', 'Jl. Trans Sulawesi, Beteleme, Kec. Lembo, Kabupaten Morowali, Sulawesi Tengah 94966', '', '250000', '150000'),
('263', 'Glory', '/uploads/1775548249285.jpg', '', '13', '20', '', 'https://maps.app.goo.gl/UJydzFxmpvDVYmzi6?g_st=ac', 'Jl. Trans Sulawesi, Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('265', 'Penginapan Clara', '/uploads/1775582189445.jpg', '', '13', '20', '', 'https://maps.app.goo.gl/nc6wru2y3AeM7Uxn8', 'Jl. Trans Sulawesi, Lembontonara, Kec. Mori Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '250000', '150000'),
('266', 'Panorama', '/uploads/1775582368343.jpg', '0852-9937-0403', '8', '12', '', 'https://maps.app.goo.gl/JZF5hQ9hSCvUKBRVA', 'Jl. Trans Sulawesi, Lembontonara, Kec. Mori Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '250000', '150000'),
('268', 'Ti To Ti', '/uploads/1775582760311.jpg', '', '8', '12', '', 'https://maps.app.goo.gl/AbodfoAzqkk95tjq5?g_st=ac', 'Jl. Trans Sulawesi, Lembontonara, Kec. Mori Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '250000', '150000'),
('269', 'Penginapan Hikmah ', '/uploads/1775582909583.jpg', '', '9', '14', '', 'https://maps.app.goo.gl/jvoEM7w3g21xjUWP9', 'Jl. Trans Sulawesi, Lembontonara, Kec. Mori Utara, Kabupaten Morowali, Sulawesi Tengah 94965', '', '250000', '150000'),
('270', 'Anugerah', '/uploads/1775583113678.jpg', '', '24', '36', '', 'https://maps.app.goo.gl/4Px29Qco2VWxrWew9?g_st=ac', 'Jl. Trans Sulawesi, Lembontonara, Kec. Mori Utara, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '250000', '150000'),
('272', 'Penginapan Anugerah Nia', '/uploads/1775583539721.jpg', '', '9', '14', '', 'https://maps.app.goo.gl/pzu97S9Tn6DH7PrBA?g_st=ac', 'Jl. Trans Sulawesi, Tomata, Kec. Mori Atas, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '250000', '150000'),
('273', 'Hotel Trend', '/uploads/1775583653735.jpg', '0823-4914-7824', '12', '18', '', 'https://www.google.com/maps/place/HOTEL+TREND/@-1.995184,120.979399,21z/data=!4m6!3m5!1s0x2d8fd36b2abaa7b1:0x8e96decbf648e436!8m2!3d-1.995187!4d120.9795787!16s%2Fg%2F11gr7cpvyt!18m1!1e1?entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Jl. Trans Sulawesi, Tomata, Kec. Mori Atas, Kabupaten Morowali Utara, Sulawesi Tengah 94965', '', '350000', '150000'),
('278', 'Penginapan Andolia', '/uploads/1775584346622.jpg', '0853-9970-7303', '10', '15', '', 'https://maps.app.goo.gl/X6jk7Ag14emMu2YKA?g_st=ac', 'Unnamed Road No.94972, Tana Sumpu, Kec. Mamosalato, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '250000', '150000'),
('280', 'Hotel Faawaz', '/uploads/1775584760915.jpg', '0822-9053-9907', '23', '23', '', 'https://maps.app.goo.gl/h4c3dtbqHjjAhuyf6?g_st=ac', 'Baka, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '350000', '150000'),
('281', 'Hotel Sidapore', '/uploads/1775584945498.jpg', '0853-9939-6686', '25', '29', 'https://www.facebook.com/sidaporehotel.salakan/', 'https://maps.app.goo.gl/bxKAdjiVaiKMibcSA?g_st=ac', 'Salakan, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '350000', '150000'),
('282', 'Wisma Sidapore Jalur Dua', '/uploads/1775614917901.jpg', '', '11', '17', '', 'https://maps.app.goo.gl/GZzqG2mrdBjU7sdr6?g_st=ac', 'Desa Baka', '', '800000', '388000'),
('283', 'Wisma Sidapore Teluk Bayur', '/uploads/1775615072519.jpg', '', '5', '10', '', 'https://maps.app.goo.gl/WPKGhfPTTkmuh3MaA?g_st=ac', 'Desa Baka', '', '550000', '355000'),
('284', 'Wisma Alpren', '/uploads/1775615290185.jpg', '0812-8522-6831', '9', '15', '', 'https://maps.app.goo.gl/qNHzpdGYjJGFVEAK8', 'Jl.Bhayangkara, Salakan, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94887', '', '550000', '355000'),
('285', 'Penginapan Bharata', '/uploads/1775615832656.jpg', '04622222005', '16', '46', '', 'https://maps.app.goo.gl/kJShrErRx1bne3oJ8?g_st=ac', 'Unnamed Rd, Baka, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885 Peta Penginapan Bharata', '', '200000', '75000'),
('286', 'Penginapan Sengkang', '/uploads/1775616211863.jpg', '62 822-9827-7616', '10', '10', '', 'https://maps.app.goo.gl/tNbZ8gFZdXNyUZVo9', 'M7PP+33M, Bongganan, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah', '', '250000', '150000'),
('287', 'Penginapan Sipatuo', '/uploads/1775616391535.jpg', '+62 821-9431-9003', '13', '13', '', 'Google https://share.google/oOpTTdIKnRlzE6UOc', 'wilayah Bongganan (Salakan)', '', '250000', '150000'),
('288', 'Penginapan Lestari ', '/uploads/1775616605042.jpg', '+62 812-4516-1203', '20', '20', '', 'https://share.google/aimode/L6OE4yGu6F81gcfsk', 'Kelurahan Salakan, Kecamatan Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94785.', '', '250000', '150000'),
('289', 'Penginapan Sana', '/uploads/1775616781784.jpg', '+62 822-7108-9588', '9', '14', '', 'https://maps.app.goo.gl/zDjdP7cEUoaRMe6u6?g_st=ac', 'Kelurahan Bongganan, Kecamatan Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885.', '', '250000', '150000'),
('290', 'Penginapan Sana', '/uploads/1775616874714.jpg', '0853-2218-8628', '9', '14', '', 'https://maps.app.goo.gl/D56sGDffGmG1NUjLA?g_st=ac', 'Jl. Trans Peling No.2, Tompudau, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '350000', '150000'),
('291', 'Penginapan syiar', '/uploads/1775617046788.jpg', '', '11', '9', '', '', 'Desa Bongganan', '', '250000', '150000'),
('292', 'Homestay Pusaka Rifqi', '/uploads/1775617232483.jpg', '0812-4422-2202', '3', '3', '', 'https://maps.app.goo.gl/A9JNAQSSDabF1eb29?g_st=ac', 'M7PR+HCJ Jalan, KRI Tlk. Bayur, Baka, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '250000', '150000'),
('293', 'Homestay Pulau Dewata', '/uploads/1775617360053.jpg', '0812-4196-7047', '17', '17', '', 'https://maps.app.goo.gl/684Dj3XdzdsggrWu7', 'M7MQ+JR6, Jalan Lorong SMAN 1, Baka, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '250000', '150000'),
('294', 'Penginapan Sinar Peling', '/uploads/1775617562876.jpg', '0813-4237-3227', '20', '20', '', 'https://maps.app.goo.gl/XYto4Y5kxn4DrGHW9?g_st=ac', 'Jl. Tlk. Bayur II No.2, Baka, Tinangkung, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94885', '', '250000', '150000'),
('295', 'Penginapan Rahayu', '/uploads/1775617666409.jpg', '', '2', '2', '', 'https://maps.app.goo.gl/MVxnCkUJQRjSQwYF6?g_st=ac', 'PR4G+652, Labasiano, Kec. Buko, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94881', '', '250000', '150000'),
('296', 'Homestay Tiga Putri', '/uploads/1775799505080.jpg', '+62 812-8879-7212.', '4', '4', 'Sumber: Kementerian Pariwisata Republik Indonesia https://share.google/h3ynR4jytZvLnzjIB', 'https://maps.app.goo.gl/RJvQaaFaQLKRYnth7?g_st=ac', 'QXP9+7R8, Luk Panenteng, Kec. Bulagi Utara, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94882', '', '450000', '100000'),
('297', 'Blessing Homestay', '/uploads/1775799745446.jpg', '+62 858-2383-2206 ', '10', '10', 'Sumber: Instagram https://share.google/JrUOCuet1xvUsfBkA', 'https://maps.app.goo.gl/xYw6gfz6ZRcoFGns6?g_st=ac', 'Desa Luk Panenteng', '', '350000', '250000'),
('298', 'Blessing Homestay', '/uploads/1775800021572.jpg', '0856-1547-141', '5', '5', '', 'https://maps.app.goo.gl/qvXdcNcvfi6isuB39', 'Jl G Julu Tumpu No 50, Mangkio Baru, Luwuk, Sulawesi Tengah 94713', '', '350000', '150000'),
('299', 'Homestay Poganda', '/uploads/1775800235825.jpg', '0813-1860-9889', '3', '3', '', 'https://maps.app.goo.gl/EXHcVjf1kA97iU826', 'RW96+XV, Luk Panenteng, Kec. Bulagi Utara, Kabupaten Banggai Kepulauan, Sulawesi Tengah', '', '350000', '250000'),
('300', 'Penginapan Rr tataba', '/uploads/1775800498936.jpg', '085280988436', '4', '4', '', 'https://share.google/RJWSorgikpytI6ANm', 'Jl. Kampis No.8, Tataba, Kec. Buko, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94881', '', '350000', '250000'),
('301', 'Penginapan Rr leme leme', '/uploads/1775800598211.jpg', '', '6', '6', '', 'https://share.google/BloRT7zA5glfpfqR9', ' Jln pelabuhan No.3, Leme-Leme Bungin, Kec. Buko, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94881 Peta Penginapan R3 Leme-leme 4,7', '', '350000', '250000'),
('302', 'Penginapan Novfitri', '/uploads/1775801180032.jpg', '0821-9908-9838', '9', '9', '', 'https://maps.app.goo.gl/1N8JgGA35bjGm9oB7?g_st=ac', 'PRHQ+6QC, Unnamed Road, Leme-Leme Bungin, Kec. Buko, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94881', '', '350000', '250000'),
('303', 'Penginapan Desa', '/uploads/1775828411635.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/L1ktdzH1zAu7cbABA?g_st=ac', 'GR6C+4JJ, Unnamed Road, Lumbi-Lumbia, Kec. Buko Selatan, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94881', '', '100000', '75000'),
('304', 'Penginapan Ceria', '/uploads/1775828517273.jpg', '', '3', '3', '', 'https://maps.app.goo.gl/twycsYJdiKcTUhBw7?g_st=ac', 'GR7C+HW3, Lumbi-Lumbia, Kec. Buko Selatan, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94871', '', '150000', '75000'),
('305', 'Penginapan Galaxy', '/uploads/1775828621400.jpg', '', '9', '9', '', 'https://maps.app.goo.gl/rEhPaLs6g66gvT2d6', 'GR7C+8P4, Apal, Kec. Buko Selatan, Kabupaten Banggai Kepulauan, Sulawesi Tengah', '', '250000', '150000'),
('306', 'Penginapan Hirma', '/uploads/1775828743469.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/LNhR9b5miLMXsvNt7?g_st=ac', 'M37X+PX2, Bulagi Satu, Bulagi, Kabupaten Banggai Kepulauan, Sulawesi Tengah', '', '250000', '150000'),
('307', 'Hotel Boulevard', '/uploads/1775829044108.jpg', '813-2227-795', '23', '23', 'Sumber: Agoda.com https://share.google/iq7SVxIACF0LDWvxP', 'Luwuk Boulevard Hotel https://share.google/0NjoswkzQWCc88U0B', '2QRV+XPP, Jl. RE Martadinata No.64, Karaton, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '750000', '250000'),
('277', 'Penginapan Pettalolo', '/uploads/1775584228399.jpg', '0823-5025-9298', '5', '8', '', 'https://maps.app.goo.gl/1pZD1SnJw4V6KN4x5?g_st=ac', 'Jl. Trans Sulawesi, Tana Sumpu, Kec. Mamosalato, Kabupaten Morowali, Sulawesi Tengah 94972', '', '250000', '150000'),
('279', 'Nurliyah', '/uploads/1775584633942.jpg', '085299920695', '25', '35', '', 'https://maps.app.goo.gl/9e8ze8bbRMcErwBk8', 'Beteleme, Kec. Lembo, Kabupaten Morowali Utara, Sulawesi Tengah 94966', '', '250000', '150000'),
('308', 'Hotel Ceria', '/uploads/1775906843322.jpg', '(0461) 3128499', '13', '13', '', 'https://maps.app.goo.gl/dz3ca43MKVc55X338?g_st=ac', '3R66+74P, Jl. Imam Bonjol, Bungin Tim., Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '350000', '250000'),
('309', 'Hotel Ebony', '/uploads/1775907080536.jpg', '0851-4767-61606', '10', '10', '', 'https://maps.app.goo.gl/S3Un8QXpRbvDjDgm8', '3Q2V+V3C, Jl. Sultan Hasanuddin, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '450000', '350000'),
('310', 'Hotel Erni', '/uploads/1775907210542.jpg', '(0461) 21039', '8', '8', '', 'https://maps.app.goo.gl/u7WRyJ9GxHuGYcf8A', 'JL Danau Tondano No.160, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '350000', '250000'),
('311', 'Hotel Sadar Stay', '/uploads/1775907514042.jpg', '0815-5324-8165', '18', '18', 'https://share.google/vzYuht0pHS3icZ7ap', 'https://maps.app.goo.gl/arEcdDZe9KYaQeA77?g_st=ac', '3Q2V+J5M, Jl. Ahmad Yani, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '350000', '150000'),
('312', 'HOTEL Kota', '/uploads/1775907708628.jpg', '(0461) 21335', '26', '26', '', 'https://maps.app.goo.gl/KwAnbvubXaU49ZWZA', '3Q2Q+F75, Jl. S. Parman No.2, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '550000', '250000'),
('313', 'Hotel gemilang', '/uploads/1775908009868.jpg', '(0461) 325119', '22', '22', '', 'https://maps.app.goo.gl/UJTzaDac48sHCNHu6?g_st=ac', '3Q2P+2V6, Jl. Prof. Moh. Yamin, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '400000', '300000'),
('314', 'Hotel Melati', '/uploads/1775908322271.jpg', '(0461) 21015', '5', '5', '', 'https://maps.app.goo.gl/aKdzKi3tKPmNkzUB8?g_st=ac', 'Jl. Danau Poso No.85, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '350000', '250000'),
('315', 'Hotel Permai', '/uploads/1775910619763.jpg', 'Telp. (0461)  22937 – 22737 ', '41', '41', '', 'Hotel Permai https://share.google/UJJkRRl7ll2rKcRbN', 'Jl. Tanjung Branjangan Kec. Luwuk', '', '350000', '250000'),
('316', 'Hotel Igora ', '/uploads/1775910836761.jpg', '0822-3112-2200', '21', '31', '', 'https://maps.app.goo.gl/fxbFHEZBksYcu1QUA?g_st=ac', 'Jl. Dr. Moh. Hatta No.129, Maahas, Kec. Luwuk Selatan, Kabupaten Banggai, Sulawesi Tengah', '', '350000', '250000'),
('317', 'Hotel Ramayana', '/uploads/1775911016778.jpg', '(0461) 21928', '33', '10', '', 'https://maps.app.goo.gl/XUd3RVTWRYEgQMnC7?g_st=ac', 'Jl. Danau Lindu No.69, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94111', '', '400000', '200000'),
('318', 'Hotel Karathon', '/uploads/1775911207524.jpg', '(0461) 22618 - 22619', '32', '40', '', 'https://maps.app.goo.gl/P9mCiybrrXwpPqvs8?g_st=ac', 'Jl. Dewi sartika No. 123 Luwuk ', '', '450000', '300000'),
('319', 'Green Hotel', '/uploads/1775911491407.jpg', ' (081524770618)', '31', '41', '', 'https://maps.app.goo.gl/8tDW3Ux56WLiVjjE7', 'Jl. Dewi sartika Kel. Karaton luwuk  Tlp. (0461) 3201305 Kec. Luwuk ', '', '400000', '200000'),
('320', 'Hotel Grand soho', '/uploads/1775911741313.jpg', ' (081355501198)', '39', '45', '', 'https://maps.app.goo.gl/MXoociGZuG9aaEi96', 'Jl. Sungai Limboto No. 05 Kec. Luwuk ', '', '550000', '400000'),
('321', 'Hotel Rosalina', '/uploads/1775911858090.jpg', '(0461) 22815', '24', '30', '', 'https://maps.app.goo.gl/sTVUMZwQ1zDTg9727?g_st=ac', 'JL. Kom L Yos Sudarso No.18-2, Soho, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '400000', '250000'),
('322', 'Hotel Imperial', '/uploads/1775912086362.jpg', '(0461) 325157', '25', '30', '', 'https://maps.app.goo.gl/nn61bKPWZAdrd1tS9?g_st=ac', '3Q2R+3V7, JL. Kol.Sugiono, Karaton, Banggai, Kabupaten Banggai, Sulawesi Tengah', '', '350000', '300000'),
('323', 'Hotel Grand soho', '/uploads/1775963727217.jpg', '081355501198', '39', '45', 'Hotel Grand Soho, Banggai - Diskon s.d 50% + Gratis Pembatalan https://share.google/M6N49PrwREuwOWqze', 'https://maps.app.goo.gl/hS46eUR4vhCbQzHT7', 'Jl. Sungai Limboto No. 05 Kec. Luwuk ()', '', '680000', '388000'),
('324', 'Hotel Dinasty', '/uploads/1775963972339.jpg', '081341083325', '33', '45', '', 'https://maps.app.goo.gl/UvhKmU569miiNV3D6?g_st=ac', ' Jl. S. Parman No. 1 Kec Luwuk', '', '350000', '250000'),
('325', 'Hotel Grand Hedser', '/uploads/1775964195507.jpg', '0461) 21933', '32', '32', '', '', '    Jl. RE. Martadinata No.21 Kec. Luwuk', '', '450000', '350000'),
('326', 'Wisma Azhari', '/uploads/1775964422798.jpg', '0853-9930-6666', '23', '35', 'Booking Kamar - AZARI https://share.google/oTL9PFZFLZnJ6MV7h', 'https://maps.app.goo.gl/56tpJkk8dBszNQrQ9', '3R52+46Q, Jl. Imam Bonjol, Bungin, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '250000', '200000'),
('327', 'Losmen Lor', '/uploads/1775964758497.jpg', '0822-2345-6732', '16', '26', '', 'https://maps.app.goo.gl/f7USWUXsaWqZdN6y8', 'Jl. Ahmad Yani No.66, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '250000', '150000'),
('328', 'Losmen M-Three', '/uploads/1775964940558.jpg', '0813-4232-5062', '12', '25', '', 'https://maps.app.goo.gl/QsxJvCcGtDLZm1oL6?g_st=ac', 'Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '350000', '150000'),
('329', 'Losmen Ashari', '/uploads/1775965150549.jpg', '0853-4271-6666', '16', '25', '', 'https://maps.app.goo.gl/SyFC5MHN3kPWtBEL7?g_st=ac', 'Jl. S. Parman No.12, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '250000', '150000'),
('330', 'Penginapan Larotan/Rotan Master', '/uploads/1775965306065.jpg', '', '15', '26', '', 'https://maps.app.goo.gl/n4EcLAMmKydpGxu29?g_st=ac', 'Jl. A. Yani Kec. Luwuk/Pelabuhan Rotan', '', '155000', '100000'),
('331', 'Penginapan Kawanua', '/uploads/1775965431973.jpg', '(0461) 21387', '12', '12', '', 'https://maps.app.goo.gl/qQo9C87vHQtMfgVs5', 'Dongkalan, Jl. Ahmad Yani No.41, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '150000', '100000'),
('332', 'Penginapan Dahlia', '/uploads/1775965575202.jpg', '', '20', '26', '', 'https://maps.app.goo.gl/iTHw2oBULFVRoG997?g_st=ac', 'Jl. Dr. Sutomo Kec. Luwuk/Jl.Dahlia', '', '155000', '85025'),
('333', 'Penginapan Taiyo', '/uploads/1775965720430.jpg', '0815-2478-5337', '16', '26', '', 'https://maps.app.goo.gl/P8aHqWTDxjtxWie86?g_st=ac', 'Jl. Prof. Moh. Yamin, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '350000', '150000'),
('334', 'Penginapan  baru', '/uploads/1775965875338.jpg', '', '10', '10', '', 'https://maps.app.goo.gl/FQrsMQgaa9wb7JFJ9?g_st=ac', 'Jl. Ahmad Yani No.103, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '150000', '100000'),
('335', 'Penginapan Salsabila', '/uploads/1775965984574.jpg', '(0461) 3205591', '12', '18', '', 'https://maps.app.goo.gl/Vbygvix9cYFqahqU9?g_st=ac', 'Jl. Sultan Hasanuddin No.10, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '150000', '100000'),
('336', 'Penginapan garuda', '/uploads/1775966102592.jpg', '0853-9391-7586', '18', '25', '', 'https://maps.app.goo.gl/AcfGWHi9VevrNZQP8?g_st=ac', 'Jl. KH. Agus Salim No.36, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94712', '', '250000', '100000'),
('337', 'Penginapan Solata', '/uploads/1775966205346.jpg', '', '21', '26', '', 'https://maps.app.goo.gl/7QKyhvnnSdHWoWHa9?g_st=ac', '3R9C+4RG, Bungin Tim., Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '250000', '100000'),
('338', 'Penginapan D’COST/Red Doors', '/uploads/1775966292674.jpg', '', '8', '15', '', 'https://maps.app.goo.gl/uGXazUy7nVoZh2L97?g_st=ac', 'Jl.Batu Biring Kel.Bungin timur Kec.Luwuk', '', '250000', '133000'),
('339', 'Penginapan Boboship', '/uploads/1775966587103.jpg', '', '12', '25', 'https://www.tiket.com/hotel/indonesia/penginapan-bobosip-412001639714541965?utm_medium=hotel_pdp%253Bshare_button&utm_external=organic', 'https://maps.app.goo.gl/Jjfb13SVGmAsm7SX6?g_st=ac', 'Kel.Bungin timur Kec.Luwuk', '', '250000', '100000'),
('340', 'Penginapan Jangkar', '/uploads/1775966904647.jpg', '', '17', '26', 'Sumber: Traveloka https://share.google/Cb2X7UzE5h7v4nsRq', 'https://maps.app.goo.gl/wdLVPjt6unCgzAxTA', 'Jl. Mekar Sari Luwuk Kel. Tontouan Kec. Luwuk', '', '350000', '250000'),
('341', 'Penginapan Mitra Kita', '/uploads/1775967042565.jpg', '085298078408', '9', '15', 'https://www.instagram.com/penginapanmitra?igsh=dndmbXR5eGdhaXVj', 'https://maps.app.goo.gl/hiLPQrs5G6AwCTT88?g_st=ac', 'Jl. Wr. Monginsidi No. 29 Kel. Luwuk Kec. Luwuk/Nyiur Atas ', '', '250000', '165000'),
('342', 'Penginapan Duta Merlin', '/uploads/1775967181779.jpg', '', '11', '15', '', 'https://maps.app.goo.gl/ovSFUBnshH39hH2G9?g_st=ac', 'Jl. Wr. Monginsidi Luwuk Kel. Luwuk Kec. Luwuk/Nyiur Bawah (Depan Mitra) ', '', '200000', '150000'),
('343', 'Penginapan See More', '/uploads/1775967384788.jpg', '081226895392', '20', '20', '', 'https://maps.app.goo.gl/tP2YzuGyLUecZ2C57', 'Jl. Tg. Santigi Luwuk Kelurahan Karaton Kec Luwuk/Depan Hotel Karaton ()', '', '100000', '85025'),
('344', 'Penginapan Wisma Permai', '/uploads/1775967561333.jpg', '082192890160', '17', '25', '', 'https://maps.app.goo.gl/2gYvyf2whttrU3zX8?g_st=ac', 'Jl. Tg. Jepara ', '', '100000', '85025'),
('345', 'Hotel Swiss Bell in   Kelas ', '/uploads/1776140503967.jpg', '0461-3128600', '100', '150', 'https://www.google.co.id/aclk?sa=l&ai=DChsSEwigvpzrvuyTAxXziWYCHYwjOQYYACICCAEQCRoCc20&co=1&gclid=Cj0KCQjwqPLOBhCiARIsAKRMPZqAVR-hQzq5f4nYLOEt_noOl3noYfJ7ej9_uJGqNu1rvEp_puD4rnQaAiK2EALw_wcB&cid=CAAS0wHkaBrxZoyQQ07vmitFfnQOOBHmUu4z8LQyVMbR6l8YFO_Pns9UHzwhe8p5Jbb8iH6uW8hOtzYAtI9fCg_l9n-TMPc8g10kflw_uSlNc03xErkNogwWvFA6hyiwXz6QKx3D7qvUTSu3EnD1vIBpphgYLEBAko1I4vuM6kGW9cYxSoY6Y2juQTZL-TfyxfvbOyvx6Rv_2XO9STGs6yrAPKr87HBt7hkbnZXn0Y9klC70FKnWTkxHn6OvVBjgto7ymmmDoUc5h2H-lm0ddlJ53qg_zwKa&sig=AOD64_1FuV5p5Mr_Th6GcY4hvP_r31BwFw&adurl', 'https://maps.app.goo.gl/Ji7XgstSQc18JNGm6?g_st=ac', 'Jl. Kantor DPRD Baru, Kel. Ma’ahas Kecamatan Luwuk Selatan', '', '1200000', '450000'),
('346', 'Hotel Santika         Kelas ', '/uploads/1776140720971.jpg', '(0461) 3202022', '62', '100', 'https://www.mysantika.com/indonesia/banggai/hotel-santika-luwuk-sulawesi-tengah', 'https://maps.app.goo.gl/QJA4sFrRDpKJi8Bh9?g_st=ac', ' Jl. Kakap Komp. Bukit Halimun Kecamatan Luwuk Selatan', '', '2000000', '500000'),
('347', 'Hotel Estrella        Kelas ', '/uploads/1776140965475.jpg', '(0461) 3128080', '77', '100', 'https://www.estrellahotel.id/', 'https://maps.app.goo.gl/Cb3xG3wwt9iG75Ta6?g_st=ac', 'Jln. Mandapar, kawasan Bukit Halimun, tnjung Tuwis Kec. Luwuk Selatan', '', '1200000', '450000'),
('348', 'Hotel citra', '/uploads/1776141155237.jpg', '(0461) 23354', '20', '25', '', 'https://maps.app.goo.gl/TMDmUKAHBsNGqvLH6?g_st=ac', '  Jl. Moh Hatta Kel Ma’ahas Luwuk Kec. Luwuk Selatan', '', '350000', '250000'),
('349', 'Hotel Ananda', '/uploads/1776141322233.jpg', '0856-9654-7236', '8', '10', '', 'https://maps.app.goo.gl/GNvoizLA5T3vdSFx6?g_st=ac', 'depan salon novira, Jl. Pulau Seram No.12a, Jole, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94713', '', '200000', '150000'),
('350', 'DX HOME STAY', '/uploads/1776141576896.jpg', '', '11', '25', '', 'https://maps.app.goo.gl/RhFKC93HHMfrWnhbA?g_st=ac', 'Btn km 5, Jl. Permata No.4 Blok G, RW.6, Tanjung Tuwis, Luwuk Selatan, Banggai Regency, Central Sulawesi 94715', '', '400000', '275090'),
('351', 'Losmen Pulau Bokan', '/uploads/1776141741606.jpg', '', '12', '12', '', 'https://maps.app.goo.gl/amvKbUmYfHXjuGJBA?g_st=ac', 'Jl. Pulau Bokan Kel. Kompo Kec. Luwuk Selatan ', '', '200000', '100000'),
('352', 'Penginapan Anggrek', '/uploads/1776141912779.jpg', '0812-4354-5566', '10', '15', '', 'https://maps.app.goo.gl/dxxUGQg3uyDJppy1A?g_st=ac', 'Jl. Dr. Moh. Hatta No.57, Simpong, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94713', '', '200000', '85025'),
('353', 'Penginapan Aladin', '/uploads/1776142061639.jpg', '082292659408', '10', '15', '', 'https://maps.app.goo.gl/XhiboBBg3Loq7Gju7', 'Jl. Moh Hatta Kel Maahas Kilo 5 Kec. Luwuk Selatan ', '', '250000', '150000'),
('354', 'Penginapan Tuah Saiyo', '/uploads/1776142206295.jpg', '0822-1318-5711', '10', '15', '', 'https://maps.app.goo.gl/jHRhmCSqXEwr4anH7?g_st=ac', 'Jl. Dr. Moh. Hatta No.26, Simpong, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94713', '', '200000', '150000'),
('355', 'Hotel De\'Hills', '/uploads/1776142680213.jpg', '0851-9486-3290', '10', '20', '', 'https://maps.app.goo.gl/FZ1cCCX7i2n8iMgC8?g_st=ac', 'Jl. Lemuru, Bukit Mambual, Kec. Luwuk Selatan, Kabupaten Banggai, Sulawesi Tengah', '', '725000', '300000'),
('356', 'Penginapan Maahas', '/uploads/1776142951233.jpg', '0813-5426-4941', '9', '15', '', 'https://maps.app.goo.gl/ooQnQpXGGCVTTjXt9?g_st=ac', '2QFP+X96, Bukit Mambual, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94711', '', '350000', '150000'),
('357', 'Penginapan Haper Inn', '/uploads/1776143160635.jpg', '0852-9811-9553', '11', '20', '', 'https://maps.app.goo.gl/ykMyBPKfSq21Kesv6?g_st=ac', '2QJH+WX5, Jl. Edelweis, Hanga-Hanga Permai, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94717', '', '250000', '150000'),
('358', 'New Wisma Permai', '/uploads/1776143278880.jpg', '(082291120327)', '10', '15', '', 'https://maps.app.goo.gl/EerV8DunJmBkJSJa9?g_st=ac', '2QMQ+R6P, Jl. Pulau Sulawesi, Jole, Luwuk, Kabupaten Banggai, Sulawesi Tengah 94713', '', '200000', '150000'),
('359', 'Penginapan Plobokan', '/uploads/1776143365927.jpg', '085756174140', '12', '15', '', '', 'Kec. Luwuk Selatan (085756174140)', '', '200000', '100000'),
('360', 'Wisma selebes', '/uploads/1776143524468.jpg', '082291809270', '24', '30', '', 'https://maps.app.goo.gl/SFPWXNedgkwvCtY28', '2QCP+7G4, Jl. Dr. Moh. Hatta, Bukit Mambual, Kec. Luwuk Selatan, Kabupaten Banggai, Sulawesi Tengah', '', '150000', '85025'),
('361', 'Cakrawala Hotel', '/uploads/1776213921378.jpg', '0822-3781-7776', '15', '25', '', 'https://maps.app.goo.gl/hR2E2oXvomnD17yQ6?g_st=ac', 'Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '200000', '100000'),
('362', 'Grand City Hotel', '/uploads/1776214090272.jpg', '0812-4343-9999', '9', '9', '', 'https://maps.app.goo.gl/j3jP9NVXDKCFprtt5?g_st=ac', 'Kalaka, Bunta, Kalaka, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '200000', '100000'),
('363', 'Losmen Citra', '/uploads/1776214200222.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/G5a6awU9sxwRe2Hx9?g_st=ac', '5587+F7C, Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '150000', '85025'),
('364', 'Penginapan pelangi', '/uploads/1776214313933.jpg', '0812-4275-2649', '18', '18', '', 'https://maps.app.goo.gl/VBetKvBLQut8wDpE6', '5598+5R8, Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '200000', '100000'),
('365', 'Penginapan Francisca', '/uploads/1776214467336.jpg', '', '10', '10', '', 'https://maps.app.goo.gl/xtUHWq8RpuYCQj4T6?g_st=ac', '5577+W5R, Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '200000', '100000'),
('366', 'Penginapan Mey Flower', '/uploads/1776214588022.jpg', '0822-9299-9351', '11', '11', '', 'https://maps.app.goo.gl/nkdiF2pTkDohs3MfA?g_st=ac', '5598+P95, Jl. Desa Salabenda, Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '200000', '100000'),
('367', 'Guest House Raudha', '/uploads/1776214731331.jpg', '0811-4540-0077', '7', '7', '', 'https://maps.app.goo.gl/fXw4ttRjUdLtQZJe9?g_st=ac', '5539+J94, Kalaka, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah', '', '350000', '100000'),
('368', 'Guest House Monalisa', '/uploads/1776214836943.jpg', '0822-5953-1175', '8', '8', '', 'https://maps.app.goo.gl/VU9b2cVdUNmSLSxK7?g_st=ac', '558C+F43, Salabenda, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '350000', '150000'),
('369', 'Resort Kalibosi', '/uploads/1776214989120.jpg', '0852-5353-5252', '15', '16', '', 'https://maps.app.goo.gl/pRNFYTtwAPRo22CT9', 'Jl. Trans Sulawesi, Bunta Satu, Kec. Bunta, Kabupaten Banggai, Sulawesi Tengah 94753', '', '550000', '250000'),
('370', 'Hotel Puri Ayu', '/uploads/1776215088698.jpg', '0852-5599-0000', '37', '45', '', 'https://maps.app.goo.gl/QyLy8vCpkjJpiZxH6?g_st=ac', 'G8PJ+GCM, Tirta Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '250000', '200000'),
('371', 'Hotel King Ameer', '/uploads/1776215253397.jpg', '0823-1111-9100', '33', '45', 'https://king-ameer.com/', 'https://maps.app.goo.gl/2gusFEC389f48q5D8?g_st=ac', 'Jalan Ahmad Yani No.17, Tirta Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '550000', '350000'),
('372', 'Hotel R Three ', '/uploads/1776215424320.jpg', '0812-9299-2970', '36', '45', '', 'https://maps.app.goo.gl/BGyqNMEqA3DNitwT8?g_st=ac', 'Jl. Tadulako No.K-18, Jaya Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '350000', '250000'),
('373', 'Senoro Vilage', '/uploads/1776215514835.jpg', '0858-2550-6784', '15', '26', '', 'https://maps.app.goo.gl/rD6nnN5jQuyA1MhE7?g_st=ac', 'Jalan Tadulako No.11a, Jaya Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '550000', '250000'),
('374', 'Penginapan Kerasan', '/uploads/1776215669027.jpg', '0853-4245-2898', '24', '36', '', 'https://maps.app.goo.gl/TRQ7EGSPycQHHugr5?g_st=ac', 'G89G+PW2, unit12, Tirta Sari, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '250000', '200000'),
('375', 'Penginapan Pinaria', '/uploads/1776215757055.jpg', '', '10', '15', '', 'https://maps.app.goo.gl/3v1RC3JgFufXpS5AA?g_st=ac', 'G8MP+5G7, Jaya Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '350000', '200000'),
('376', 'Penginapan Lembongan', '/uploads/1776215856319.jpg', '0821-8708-5915', '10', '10', '', 'https://maps.app.goo.gl/nYkc92EPqkfUci6W7?g_st=ac', 'G8FG+7M3, Jaya Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '350000', '200000'),
('377', 'Penginapan Budi Arta', '/uploads/1776222367040.jpg', '0852-1485-6028', '15', '14', '', 'https://maps.app.goo.gl/RxqW5ynAJ4tAhcer7', 'F625+5HV, Makapa, Kec. Toili Bar., Kabupaten Banggai, Sulawesi Tengah 94765', '', '250000', '100000'),
('378', 'Penginapan Andika Wahyu', '/uploads/1776222484964.jpg', '0852-8047-5777', '15', '15', '', 'https://maps.app.goo.gl/zm3suKEr4CmDgHJa8', 'G8HM+G7H, Jaya Kencana, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah 94765', '', '250000', '150000'),
('379', 'Penginapan Valentine', '/uploads/1776222603726.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/ufaLNcej2zELQm89A', 'Pandan Wangi, Kec. Toili Bar., Kabupaten Banggai, Sulawesi Tengah', '', '200000', '100000'),
('380', 'Penginapan D’Viva', '/uploads/1776222745511.jpg', '0815-2444-2843', '10', '10', '', 'https://maps.app.goo.gl/EAF43JiT6ysRnPn68?g_st=ac', 'F626+64F, Unnamed Road, Makapa, Kec. Toili Bar., Kabupaten Banggai, Sulawesi Tengah 94765', '', '150000', '80000'),
('381', 'Penginapan Donggi Senoro', '/uploads/1776222863086.jpg', '0856-5628-6231', '6', '6', '', 'https://maps.app.goo.gl/xATZBjWQLYJRxUqAA?g_st=ac', 'Sinorang, Kec. Batui Sel., Kabupaten Banggai, Sulawesi Tengah 94762', '', '150000', '80000'),
('382', 'Penginapan Bukit Indah ', '/uploads/1776223039448.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/EHndyXq6rmAL68z78', 'Desa Dongin Kec. Toili Barat', '', '100000', '80000'),
('383', 'Penginapan Idola', '/uploads/1776223169213.jpg', '0822-8106-6147', '6', '6', '', 'https://maps.app.goo.gl/8cBGFqBNwMJykdxM7?g_st=ac', 'GWCM+6XH, Bente, Kec. Bungku Tengah, Kabupaten Morowali, Sulawesi Tengah 94973', '', '150000', '80000'),
('384', 'Penginapan Pondok Wisata', '/uploads/1776223269387.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/JrLhMPS5bY4pibmL6?g_st=ac', 'F77X+7VW, Pandan Wangi, Kec. Toili Bar., Kabupaten Banggai, Sulawesi Tengah', '', '100000', '80000'),
('385', 'Hotel B & B  Grand Villy', '/uploads/1776223480060.jpg', '0822-9612-4345', '9', '9', 'https://maps.app.goo.gl/1PhFVZKbyxxKcV2F7?g_st=ac', 'http://bnbgrandvhilly.blogspot.com/2017/09/selamat-datang-di-b-grand-vhilly-batui.html', 'PH93+R9J, Jl. Trans Luwuk, Sisipan, Kec. Batui, Kabupaten Banggai, Sulawesi Tengah 94761', '', '350000', '250000'),
('386', 'Penginapan Faren', '/uploads/1776223624934.jpg', '0853-5327-4078', '8', '8', '', 'https://maps.app.goo.gl/26RKq2zYjM9ccpPY7?g_st=ac', 'PHC6+4C9, Sisipan, Kec. Batui, Kabupaten Banggai, Sulawesi Tengah 94761', '', '100000', '80000'),
('387', 'Homestay Asyifa', '/uploads/1776223877194.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/upvAV5BLdEfpKZcW9?g_st=ac', 'Kel. Tolando Kecamatan Batui', '', '100000', '80000'),
('388', 'Homestay Dua Bintang', '/uploads/1776224004037.jpg', '0857-5742-4824', '6', '6', '', 'https://maps.app.goo.gl/PX9YU6EvXbuEMGpi8', 'Sisipan, Kec. Batui, Kabupaten Banggai, Sulawesi Tengah', '', '100000', '80000'),
('389', 'Homesatay Pelangi', '/uploads/1776224125042.jpg', '0822-9385-5725', '8', '10', '', 'https://maps.app.goo.gl/cWHdv8CFPQihXWjw8?g_st=ac', 'Uso, Kec. Batui, Kabupaten Banggai, Sulawesi Tengah 94761', '', '150000', '80000'),
('390', 'Penginapan Waraswati', '/uploads/1776657620530.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/76viQPCHHQpSxgZw7?g_st=ac', 'Pagimana', '', '200000', '100000'),
('391', 'Penginapan ester', '/uploads/1776657736712.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/1FTkPKxRKcPbAfud9?g_st=ac', '6M35+463, Jl. Trans Sulawesi, Pagimana, Kabupaten Banggai, Sulawesi Tengah 94752', '', '200000', '100000'),
('392', 'Penginapan Srikandi', '/uploads/1776657955557.jpg', '0813-4212-9270', '3', '3', '', 'https://maps.app.goo.gl/dtjYLqE933WWrtGG8?g_st=ac', '45J2+76Q, Tangeban, Kec. Masama, Kabupaten Banggai, Sulawesi Tengah 94772', '', '200000', '100000'),
('393', 'Penginapan Surya Buah', '/uploads/1776658237615.jpg', '', '10', '10', '', 'https://maps.app.goo.gl/SCwmTfAw8fV2u58Y9?g_st=ac', 'H9HF+JCM, Sidoharjo, Kec. Toili, Kabupaten Banggai, Sulawesi Tengah', '', '200000', '100000'),
('394', 'Penginapan Duta ', '/uploads/1776658388717.jpg', '0813-4258-5900', '10', '10', '', 'https://maps.app.goo.gl/boQEfHFQrYvdXKvq7?g_st=ac', '499V+FMG, Unnamed Road, Dale-Dale, Balantak, Banggai Regency, Central Sulawesi 94773', '', '200000', '100000'),
('395', 'Penginapan Adi Mulya', '/uploads/1776658574931.jpg', '0822-4629-7554', '10', '10', '', 'https://maps.app.goo.gl/ED9mKPfg7qBnpm4k8?g_st=ac', '39PJ+HJG, Gorontalo, Kec. Balantak Sel., Kabupaten Banggai, Sulawesi Tengah 94773', '', '200000', '100000'),
('396', 'Penginapan Berkat/Vico', '/uploads/1776660164157.jpg', '0852-1516-6277', '5', '5', '', 'https://maps.app.goo.gl/1U9383vxp37uV4gi8?g_st=ac', '77F2+QGW Behoa, Doda, Kec. Lore Tengah, Kabupaten Poso, Sulawesi Tengah 94654', '', '350000', '150000'),
('397', 'Resort Tompotika', '/uploads/1776660419944.jpg', '0813-3792-2773', '5', '5', 'https://divingsulawesi-tompotika.com/', 'https://maps.app.goo.gl/iG97ckwBzLC1JKKq5', 'kecamatan, Pulau Dua, Balantak Utara, Banggai Regency, Sulawesi Utara 94773', '', '600000', '350000'),
('398', 'Penginapan Evril Penthouse', '/uploads/1776660682428.jpg', '0813-4291-3410', '7', '7', '', 'https://maps.app.goo.gl/wryAHPFXyBfq35wY8', 'Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '600000', '250000'),
('399', 'Roa-Roa Resort', '/uploads/1776660861654.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/b5PR8rodf17xo8k59?g_st=ac', '5CMJ+M9, Kuntang, Kec. Balantak Utara, Kabupaten Banggai, Sulawesi Tengah', '', '600000', '400000'),
('400', 'Losmen cahaya wulan', '/uploads/1776661027047.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/umsmRcYamDkLk6cE8?g_st=ac', 'HRJX+C35, Jl. Poros Amolengu, Langgapulu, Kec. Kolono, Kabupaten Konawe Selatan, Sulawesi Tenggara 93395', '', '350000', '150000'),
('401', 'Siuri Cottages', '/uploads/1776661279566.jpg', '0852-4105-8225', '15', '15', 'https://www.siuricottages.com/', 'https://maps.app.goo.gl/a1PqKpkCVNHZANFY8', 'Jl. Trans Sulawesi, Pasir Putih, Pamona Sel., Kabupaten Poso, Sulawesi Tengah 94664', '', '650000', '350000'),
('402', 'Bali Cottage ', '/uploads/1776661444466.jpg', '0811-4443-868', '18', '25', '', 'https://maps.app.goo.gl/7SRvJvD7AKYX17hS8?g_st=ac', 'Jalan Trans wisata, siuri, Toinasa, Tentena, Kec. Pamona Bar., Kabupaten Poso, Sulawesi Tengah 94663', '', '600000', '90000'),
('403', 'Penginapan Pantai Indah Saluopa', '/uploads/1776661602814.jpg', '', '26', '35', '', 'https://maps.app.goo.gl/7nfJHVM2K2xujCXq7?g_st=ac', '6G7P+PHQ, Unnamed Road, Danau, Kabupaten Poso, Sulawesi Tengah 94663', '', '600000', '250000'),
('404', 'Home Stay Cendrawasih', '/uploads/1776661895566.jpg', '0812-4325-9428', '7', '7', '', 'https://maps.app.goo.gl/HKpZGz73py8c38Xg7?g_st=ac', '5GVG+9XV, Danau, Kabupaten Poso, Sulawesi Tengah 94664', '', '600000', '300000'),
('405', 'Pelangi Resort', '/uploads/1776662089649.jpg', '0812-6992-5288', '16', '20', '', 'https://maps.app.goo.gl/j9RMT5dWbFGzYHco6', 'Jl. Tonusu-Meko, Danau, Kabupaten Poso, Sulawesi Tengah 94663', '', '600000', '350000'),
('406', 'Siuri Permai', '/uploads/1776662267549.jpg', '0851-4609-9846', '3', '4', '', '', 'Tentena, Danau, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('407', 'MD Hotel', '/uploads/1776662683725.jpg', '0821-9212-7431', '8', '15', '', 'https://maps.app.goo.gl/hzkAASCQ7bWw7xwc9?g_st=ac', '4H5M+4PM, Jl. Sungai Bongka, Uentanaga Atas, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '680000', '350000'),
('408', 'Penginapan  pasir kuning ', '/uploads/1776771478437.jpg', '0813-5440-5559', '19', '25', '', 'https://maps.app.goo.gl/crvkcGeM7vMif1P3A?g_st=ac', 'Siuri, Danau, Kabupaten Poso, Sulawesi Tengah', '', '350000', '250000'),
('409', 'Penginapan Pasir Kuning', '/uploads/1776824361199.jpg', '0813-5440-5559', '19', '25', '', 'https://maps.app.goo.gl/YoRSsxdZRhXW7pWV8?g_st=ac', 'Siuri, Danau, Kabupaten Poso, Sulawesi Tengah 94664', '', '350000', '250000'),
('410', 'Losmen Alindo', '/uploads/1776824479969.jpg', '', '10', '10', '', 'https://maps.app.goo.gl/NaJ9eqdZZH2odesP6?g_st=ac', '6MX2+67V, Tentena, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '125000', '100000'),
('411', 'Losmen Bet Shalom', '/uploads/1776824692956.jpg', '085397731234', '14', '14', '', 'https://maps.app.goo.gl/q1cPFUZgBTtdb2578?g_st=ac', 'Kel. Pamona', '', '250000', '150000'),
('412', 'Ue Datu Cottage', '/uploads/1776824849986.jpg', '0811-3441-597', '5', '5', '', 'https://maps.app.goo.gl/KuAgvn19AtzWPneM9?g_st=ac', 'Lorong Ue Datu 92-93, Tentena - Poso, Pamona, Kec. Pamona Utara, Palu, Sulawesi Tengah 94663', '', '275000', '150000'),
('413', 'Hotel Mulia', '/uploads/1776824978762.jpg', '0853-9923-3069', '8', '8', '', 'https://maps.app.goo.gl/jDqrhfevUa6N4PjN7?g_st=ac', '7M44+G9C, Jl. Trans Sulawesi, Tentena, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '150000'),
('414', 'Home Stay Rano Poso', '/uploads/1776825137994.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/Cf25ZUXeRJjFHhxV9?g_st=ac', '6JRV+3W4, Jl. Setia Budi, Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '150000'),
('415', 'Mega Guest House', '/uploads/1776825233145.jpg', '', '11', '11', '', 'https://maps.app.goo.gl/Rk2xrXmx8PR2qJ4ZA?g_st=ac', 'Jl. Torulemba. kel. Pamona, kec. Pamona Puselemba, Pamona, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('416', 'Penginapan Queen', '/uploads/1776825372449.jpg', '0822-3854-3742', '15', '15', '', 'https://maps.app.goo.gl/DAZeEf6QS8u7PoRd9?g_st=ac', 'Jl. Trans Sulawesi No.36, Tentena, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '250000', '150000'),
('417', 'Penginapan Manggala ', '/uploads/1777003418772.jpg', '', '10', '10', '', 'https://maps.app.goo.gl/zv8SUmG6np8NbJTPA?g_st=ac', '6JPR+694, Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '200000', '100000'),
('418', 'Atalambu Hill', '/uploads/1777004905179.jpg', '', '4', '6', '', 'https://share.google/9DkJAxuzZCa7YacxI', 'Kota Tentena, Sangele, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('419', 'Hotel Pamona Indah', '/uploads/1777005180586.jpg', '0838-8331-949', '15', '19', '', 'https://maps.app.goo.gl/ZCbE5qeJrD6crwX56?g_st=ac', '6JMR+R4W, Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94664', '', '350000', '250000'),
('420', 'Danau Poso resort ', '/uploads/1777005451234.jpg', '0852-9996-4464', '25', '36', '', 'https://maps.app.goo.gl/yhmJ54eEjSSBXZRv6', '6JJR+CR8, Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '1200000', '355000'),
('421', 'Amadeo Guest House', '/uploads/1777030858409.jpg', '0822-9900-0672', '8', '15', '', 'https://maps.app.goo.gl/MEcttTjnt5arhAZS9?g_st=ac', 'Jl. Torulemba No.147, Pamona Pusalemba, Pamona, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '275000'),
('422', 'Penginapan Victory', '/uploads/1777031098453.jpg', '0813-5511-8099', '16', '26', 'https://www.victorytentena.com/', 'https://maps.app.goo.gl/rnjD3Dmve9EcwwSn9?g_st=ac', 'Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '175000'),
('423', 'Losmen Dolidi', '/uploads/1777031269439.jpg', '(0458) 2221047', '16', '26', '', 'https://maps.app.goo.gl/hzaXQmEjFW3CkoZRA?g_st=ac', '6JVW+6RR, Jl. Setia Budi, Tentena, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '250000', '150000'),
('424', 'Losmen Anugrah', '/uploads/1777031425423.jpg', '0813-4235-7354', '9', '15', '', 'https://maps.app.goo.gl/HWomX2cncEqFBRHh8', 'Q98R+6FV, Leling Bar., Kec. Tommo, Kabupaten Mamuju, Sulawesi Barat 91562', '', '350000', '150000'),
('425', 'Amadeo Guest House', '/uploads/1777103426415.jpg', '0822-9900-0672', '8', '16', 'https://www.instagram.com/amadeo_guesthouse?igsh=M2N3bno4OGY5aDY=', 'https://maps.app.goo.gl/j4bnDfd3qR2nNcSn9', 'Jl. Torulemba No.147, Pamona Pusalemba, Pamona, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('426', 'Penginapan Victory', '/uploads/1777103788542.jpg', '0813-5511-8099', '16', '26', 'Voctorytentena com', 'https://maps.app.goo.gl/sYW1bh9do6uePu5c8?g_st=ac', 'Sangele, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('427', 'Losmen Dolidi', '/uploads/1777103906423.jpg', '(0458) 2221047', '16', '26', '', 'https://maps.app.goo.gl/XygE7jW4Rsn38kLM9?g_st=ac', '6JVW+6RR, Jl. Setia Budi, Tentena, Kec. Pamona Utara, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('428', 'Penginapan Anugerah ', '/uploads/1777104061639.jpg', '', '22', '36', '', 'https://maps.app.goo.gl/d4m8wX2M7JCQxjB46?g_st=ac', '7M23+MH4, Unnamed Rd, Tentena, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('429', 'Penginapan Tropicana', '/uploads/1777104227938.jpg', '0821-9192-8899', '5', '6', '', 'https://maps.app.goo.gl/7jEymPGHtPMwzXo77?g_st=ac', 'Pamona, Pamona Pusalemba, Kabupaten Poso, Sulawesi Tengah 94663', '', '350000', '250000'),
('430', 'Torau Resort', '/uploads/1777104352834.jpg', '0821-9595-9566', '16', '26', 'Torauresort com', 'https://maps.app.goo.gl/EDvRibZnqdPZaP889', 'Tentena, Torau, Siuri, Danau, Kabupaten Poso, Sulawesi Tengah 94664', '', '1200000', '500000'),
('431', 'Kartika Beach Hotel', '/uploads/1777104632302.jpg', '', '23', '36', '', 'https://share.google/D5zYPqc4E72X3aYV9', 'Jl. Pulau Sabang No. 142 Poso Kota', '', '550000', '250000'),
('432', 'Ancyra Hotel', '/uploads/1777104819027.jpg', '0821-8909-0998', '70', '100', 'Ancyrahotel.com', 'https://maps.app.goo.gl/95yjNN7swHKU3K1d7?g_st=ac', 'Complex, City Mall, Jl. Pulau Sabang No.72, Kayamanya, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94617', '', '1200000', '571463'),
('433', 'Hotel 99', '/uploads/1777104940772.jpg', '0822-1066-4348', '35', '45', '', 'https://maps.app.goo.gl/HfcmbzkkKC7p1KU29?g_st=ac', 'Jl. Pulau Seram, Gebang Rejo, Kec. Poso Kota Sel., Kabupaten Poso, Sulawesi Tengah 94612', '', '350000', '250000'),
('434', 'Hotel Anugrah', '/uploads/1777105074516.jpg', '0852-9889-2590', '20', '36', '', 'https://maps.app.goo.gl/yoQrmCBvHZ8Qioe28?g_st=ac', 'JQ33+957, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '250000', '100000'),
('435', 'Hotel Natuna', '/uploads/1777105186783.jpg', '(0452) 22980', '18', '29', '', 'https://maps.app.goo.gl/u56t52czcur1DhTs7?g_st=ac', 'Jl. Pulau Natuna No.1, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '350000', '250000'),
('436', 'Hotel 77', '/uploads/1777105298328.jpg', '0813-5421-7004', '33', '40', '', 'https://maps.app.goo.gl/QSMzSxrv26DYUah88', 'Jl. Pulau Seram No.17, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '350000', '250000'),
('437', 'Hotel Otanaha', '/uploads/1777105399295.jpg', '0811-4501-889', '24', '35', '', 'https://maps.app.goo.gl/mqZ1HKihf1XYr9YWA?g_st=ac', 'Lombugia, Kec. Poso Kota Utara, Kabupaten Poso, Sulawesi Tengah 94615', '', '350000', '200000'),
('438', 'Losmen Alugoro', '/uploads/1777105514522.jpg', '0852-3107-2799', '23', '40', '', 'https://maps.app.goo.gl/nXDyXwrRmSy87NhaA?g_st=ac', 'Jl. Pulau Sumatera No.20, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '350000', '250000'),
('439', 'Hotel Alamanda', '/uploads/1777105630543.jpg', '0811-4530-085', '35', '45', '', 'https://maps.app.goo.gl/jZjgh2ZW5EjTPpHJ6?g_st=ac', 'Jl. Pulau Bali No.1, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '200000', '60000'),
('440', 'Penginapan Nusantara', '/uploads/1777105784898.jpg', '(0452) 21885', '12', '12', '', 'https://maps.app.goo.gl/yfSVY7mfxUvSpGRP6', 'JQ32+V6H, Jl. Pulau Morotai, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '150000', '80000'),
('441', 'Makarios Hotel', '/uploads/1777105947271.jpg', '0813-2227-795', '11', '26', '', 'https://maps.app.goo.gl/DLzke797sLvrNYKx6?g_st=ac', 'Jalan Marunduh No.No.9, Kasintuwu, North Poso Kota, Poso Regency, Central Sulawesi 94615', '', '200000', '80000'),
('442', 'Losmen Azzahara', '/uploads/1777106042543.jpg', '0852-5675-0565', '12', '19', '', 'https://maps.app.goo.gl/7zuk71eznn5cfFku9', 'JQ54+43H, Jl. Pulau Sumatera, Gebang Rejo, Kec. Poso Kota Sel., Kabupaten Poso, Sulawesi Tengah 94612', '', '150000', '100000'),
('443', 'Home Stay Srikandi', '/uploads/1777106152485.jpg', '0813-5451-3133', '10', '20', '', 'https://maps.app.goo.gl/CEynhYmCDFULgwHR7?g_st=ac', 'Jl. P. Sumbawa No.3, Gebang Rejo, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah 94612', '', '200000', '100000'),
('444', 'Losmen 88', '/uploads/1777106304277.jpg', '0823-3707-0412', '14', '25', '', 'https://maps.app.goo.gl/qkFhMLZVRFp7BP4p7?g_st=ac', 'JP6V+PRH, Jl. Pulau Sabang, Kayamanya, Kec. Poso Kota, Kabupaten Poso, Sulawesi Tengah', '', '200000', '150000'),
('445', 'Hotel Pandawa ', '/uploads/1777106414459.jpg', '(0452) 325252', '18', '20', '', 'https://maps.app.goo.gl/A9Hg5vQNjyPHdxFW7?g_st=ac', 'Jl. Pulau Sumatera No.25, Gebang Rejo, Kec. Poso Kota Sel., Kabupaten Poso, Sulawesi Tengah 94612', '', '350000', '100000'),
('446', 'Hotel Wisata ', '/uploads/1777106543921.jpg', '(0452) 324211', '10', '20', '', 'https://maps.app.goo.gl/oBXM9VfvNvkKzM4K7?g_st=ac', 'Jl. Pattimura No.19, Lawanga, Kec. Poso Kota Utara, Kabupaten Poso, Sulawesi Tengah 94615', '', '250000', '150000'),
('447', 'Penginapan Jalilus', '/uploads/1777106789957.jpg', '0858-4595-9435', '12', '12', '', 'https://maps.app.goo.gl/5vELtpk2fy8BEKVf6?g_st=ac', 'Jl. Tabatoki No.1a, Ranononcu, Kec. Poso Kota Sel., Kabupaten Poso, Sulawesi Tengah 94614', '', '250000', '200000'),
('448', 'Penginapan anggrek ', '/uploads/1777106889976.jpg', '0823-9371-8555', '24', '34', '', 'https://maps.app.goo.gl/uQn1fbB6GuqjQPi4A', 'WMCP+54X, Pendolo, Kec. Pamona Sel., Kabupaten Poso, Sulawesi Tengah 94664', '', '350000', '150000'),
('449', 'Pendolo Cottages ', '/uploads/1777107043634.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/gAmhwhmwAhChLdSE8?g_st=ac', 'WMMR+6F5, Jl. Trans Sulawesi, Danau, Kabupaten Poso, Sulawesi Tengah 94664', '', '550000', '350000'),
('450', 'National Cottages', '/uploads/1777107156281.jpg', '0821-8858-7930', '21', '21', '', 'https://maps.app.goo.gl/dJEJiPYi3JUeuu4CA?g_st=ac', 'Jl. Trans Sulawesi, Pasir Putih, Kec. Pamona Sel., Kabupaten Poso, Sulawesi Tengah 94664', '', '600000', '350000'),
('451', 'Mulia Poso Lake hotel ', '/uploads/1777107270468.jpg', '0822-8341-0554', '21', '21', '', 'https://maps.app.goo.gl/GF1S7XDzVRvPhgwf9?g_st=ac', 'WMMR+HXM, Danau, Kabupaten Poso, Sulawesi Tengah 94664', '', '550000', '250000'),
('452', 'Penginapan Victory', '/uploads/1777107436352.jpg', '', '7', '7', '', 'https://maps.app.goo.gl/GsecyBxuzBWSGfLH7', 'Desa Pendolo', '', '350000', '150000'),
('453', 'Penginapan Cahaya Batu - Batu', '/uploads/1777336809575.jpg', '', '17', '17', '', 'https://maps.app.goo.gl/78ydgGZu7FbSmtdWA?g_st=ac', 'VP98+29W, Panda Jaya, Kec. Pamona Sel., Kabupaten Poso, Sulawesi Tengah 94664', '', '250000', '150000'),
('454', 'Penginapan Rizky', '/uploads/1777336972438.jpg', '', '7', '7', '', '775P+392, Doda, Kec. Lore Tengah, Kabupaten Poso, Sulawesi Tengah 94654', '775P+392, Doda, Kec. Lore Tengah, Kabupaten Poso, Sulawesi Tengah 94654', '', '250000', '150000'),
('455', 'Penginapan Berkat', '/uploads/1777337173792.jpg', '0852-1516-6277', '7', '7', '', 'https://maps.app.goo.gl/UU9fR5gJMK9doxey6?g_st=ac', '77F2+QGW Behoa, Doda, Kec. Lore Tengah, Kabupaten Poso, Sulawesi Tengah 94654', '', '250000', '150000'),
('456', 'Penginapan Monalisa', '/uploads/1777337271724.jpg', '0813-5426-1746', '7', '7', '', 'https://maps.app.goo.gl/JWaDWzmmepGsAVqb9?g_st=ac', 'Jalan Pramuka No.21, Wuasa, Kec. Lore Utara, Kabupaten Poso, Sulawesi Tengah 94653', '', '200000', '100000'),
('457', 'Penginapan Sendi', '/uploads/1777337398246.jpg', '0851-6557-3656', '11', '11', '', 'https://maps.app.goo.gl/3GGNb1R1cQearLcp7?g_st=ac', 'H8V7+466, Wuasa, Kec. Lore Utara, Kabupaten Poso, Sulawesi Tengah 94653', '', '250000', '100000'),
('458', 'Penginapan Nasional', '/uploads/1777337487876.jpg', '0813-1221-3557', '24', '24', '', 'https://maps.app.goo.gl/VxFxFS18qBbQmLXt6?g_st=ac', 'H8P6+FPQ, Unnamed Road, Wuasa, Kec. Lore Utara, Kabupaten Poso, Sulawesi Tengah 94653', '', '200000', '100000'),
('459', 'Penginapan Ningsih', '/uploads/1777337905546.jpg', '', '18', '18', '', 'https://maps.app.goo.gl/wXyXHcGcgb6ZqxVv8?g_st=ac', '47WJ+GCX, Kolori, Kec. Lore Bar., Kabupaten Poso, Sulawesi Tengah 94654', '', '200000', '100000'),
('460', 'Penginapan Rizky', '/uploads/1777338207532.jpg', '', '7', '7', '', 'https://maps.app.goo.gl/brYqTZZnYuT2TNR96?g_st=ac', '47RM+GMJ Depan gereja GKST pniel, Samping lapangan, Bomba, Kec. Lore Sel., Kabupaten Poso, Sulawesi Tengah 94654', '', '250000', '150000'),
('461', 'Penginapan Dini', '/uploads/1777338370004.jpg', '', '6', '6', '', 'https://maps.app.goo.gl/qKTbheAyP1RkopXK9?g_st=ac', '454C+84M, Tuare, Kec. Lore Bar., Kabupaten Poso, Sulawesi Tengah 94654', '', '250000', '150000'),
('462', 'Penginapan Imanuel', '/uploads/1777338525560.jpg', '0813-1111-1751', '7', '7', '', 'https://maps.app.goo.gl/Qg5oCzcPPTSavHWJ9?g_st=ac', '468X+W83, Unnamed Road, Gintu, Kec. Lore Sel., Kabupaten Poso, Sulawesi Tengah 94654', '', '250000', '150000'),
('463', 'Penginapan Nur Hidayat', '/uploads/1777338637251.jpg', '', '5', '5', '', 'https://maps.app.goo.gl/LXZ44CAgzhpv8Ywy8?g_st=ac', 'H8GQ+RJW, Watumaeta, Kec. Lore Utara, Kabupaten Poso, Sulawesi Tengah 94653', '', '200000', '150000'),
('464', 'Penginapan Pantai Cinta Fitri', '/uploads/1777338906455.jpg', '0811-444-756', '15', '15', '', 'https://maps.app.goo.gl/T8eDx2S5Q1odKD179?g_st=ac', 'H4H9+4XG, Jl Trans Sulawesi, Uekuli, Kec. Tojo, Kabupaten Tojo Una-Una, Sulawesi Tengah 94681', '', '200000', '100000'),
('465', 'Hotel Ananda', '/uploads/1777339040019.jpg', '0822-7116-0426', '44', '59', '', 'https://maps.app.goo.gl/v28kLh9M5se5iJGM7', 'Jl. Lapasere, Ampana, Ampana Kota, Tojo Una-Una Regency, Central Sulawesi 94683', '', '200000', '100000'),
('466', 'Penginapan Carissa', '/uploads/1777339781888.jpg', '', '14', '26', '', 'https://maps.app.goo.gl/NaTcGWiFC6yXAJ65A?g_st=ac', '4HJG+H8G, Uentanaga Bawah, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '250000', '100000'),
('467', 'Penginapan Ampana', '/uploads/1777339928137.jpg', '', '7', '7', '', 'https://maps.app.goo.gl/DhRdeb28tCJzWwZf9', 'Jl. Sultan Hasanudin, Ampana, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '250000', '100000'),
('468', 'Khayangan Resort', '/uploads/1777340101400.jpg', '0851-3869-1268', '15', '25', '', 'https://maps.app.goo.gl/TpH6jdWb91exRzdR8?g_st=ac', 'Uentanaga Bawah, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '600000', '350000'),
('469', 'Losmen Fahmi', '/uploads/1777340197212.jpg', '', '5', '9', '', 'https://maps.app.goo.gl/FuizMGvTX1VFKLo4A?g_st=ac', '4HJ9+G32, Ampana, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '200000', '150000'),
('470', 'Penginapan mulia Ampana ', '/uploads/1777340412483.jpg', '(0464) 21144', '17', '26', '', 'https://maps.app.goo.gl/1Bz4bPQ4Fw3brkkB9?g_st=ac', 'Jl. Sultan Hasanudin No.43, Ampana, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '150000'),
('471', 'Penginapan Santafur', '/uploads/1777340637188.jpg', '', '12', '15', '', 'https://maps.app.goo.gl/bmVnQXxe9sAFEC378?g_st=ac', '4HJC+GCJ, Ampana, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '150000'),
('472', 'Latifa Homestay', '/uploads/1777340739136.jpg', '', '20', '25', '', 'https://maps.app.goo.gl/qVJ3d8rzWgGvGW628?g_st=ac', '4H94+M22, Jl. Mata Ancami, Bailo, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '150000'),
('473', 'Ganza Beach Cottage ', '/uploads/1777341260931.jpg', '', '6', '6', '', 'Gansa Bailo cottage https://share.google/VaW18SbHVLgT8KcqZ', '4HH3+6V7, Jl. Tohiti, Bailo, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '150000'),
('474', '88 Resort', '/uploads/1777341418431.jpg', '', '10', '15', '', 'https://maps.app.goo.gl/ppgB9UMqbZetiz4K8?g_st=ac', 'Jl. Sultan Hasanudin No.108, Bailo, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '150000'),
('475', 'Hotel Plaza', '/uploads/1777341535713.jpg', '(0464) 21091', '12', '12', '', 'https://maps.app.goo.gl/yV6Bu16Y59CkQN276?g_st=ac', 'Jl. Kartini No.45, Uentanaga Bawah, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '300000'),
('476', 'Penginapan Victory', '/uploads/1777341637485.jpg', '', '9', '15', '', 'https://maps.app.goo.gl/vjmmCZRVFnX9ihHH9?g_st=ac', '4HGH+MW8, Jl. Sungai Ampana No.11, Uentanaga Atas, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '250000'),
('477', 'Penginapan MD', '/uploads/1777341757816.jpg', '0821-9212-7431', '8', '9', '', 'https://maps.app.goo.gl/nacSYKwiYe2ZYWTb8?g_st=ac', '4H5M+4PM, Jl. Sungai Bongka, Uentanaga Atas, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '200000'),
('478', 'Hotel Oasis', '/uploads/1777341867942.jpg', '0853-4007-0079', '23', '36', '', 'https://maps.app.goo.gl/RJRdyHqueQGhijTd6?g_st=ac', 'Jl. RA Kartini No.5, Uentanaga Bawah, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '680000', '350000'),
('479', 'Grand PINK Hotel', '/uploads/1777341988200.jpg', '0812-4516-0588', '46', '56', 'Grandponkhotel.com', 'https://maps.app.goo.gl/Wo7YAFxSiv7y4CQE6', '4HJH+R92, Jalan, Uentanaga Bawah, Ampana Kota, Tojo Una-Una Regency, Central Sulawesi 94683', '', '350000', '200000'),
('480', 'Family Homestay', '/uploads/1777342194648.jpg', '0811-4568-186', '6', '12', '', 'https://maps.app.goo.gl/oh2RCAfTDATu3TxH6?g_st=ac', 'Jl. Yos Sudarso No.6, Uentanaga Bawah, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '250000'),
('481', 'Hotel Irama', '/uploads/1777342373282.jpg', '', '8', '10', '', 'https://maps.app.goo.gl/NuHgUyWTJztYLP3S7?g_st=ac', 'Jln. R.A Kartini, Uentanaga Bawah', '', '350000', '250000'),
('482', 'Hotel Lawaka', '/uploads/1777342505935.jpg', '(0464) 21690', '30', '47', '', 'https://maps.app.goo.gl/bQvbXN3xXL8cDwtn8', '4HRW+6PC, Jl. Tj. Lawaka, Dondo, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '680000', '350000'),
('483', 'Penginapan Resty', '/uploads/1777342620188.jpg', '0822-9325-5665', '8', '8', '', 'https://maps.app.goo.gl/h8A8VYKyteamA2Lg8?g_st=ac', '4JQ4+78J, Dondo, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '350000', '250000'),
('484', 'Penginapan Kurnia', '/uploads/1777343059067.jpg', '', '10', '10', '', '', 'Jl. Ahmad Yani, Dondo', '', '250000', '150000'),
('485', 'Penginapan Tripel R', '/uploads/1777343105059.jpg', '0852-5625-1424', '2', '2', '', 'https://maps.app.goo.gl/93AdaQVWTudrqisw5?g_st=ac', '646C+6W8, jln.Transsulawesi, Bahodopi, Kec. Bahodopi, Kabupaten Morowali, Sulawesi Tengah 94974', '', '350000', '150000'),
('486', 'Home Stay Tanjung Api', '/uploads/1777343388685.jpg', '0852-4100-3685', '2', '2', '3rhomestay.com', 'https://maps.app.goo.gl/H4QBmEK2ayZn8mzT9?g_st=ac', 'kompleks SMKN 1, Labuan, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '250000', '150000'),
('487', 'Home Stay Tanjung Api', '/uploads/1777343482937.jpg', '', '5', '10', '', '', 'Labuan', '', '350000', '150000'),
('488', 'Penginapan Sunset', '/uploads/1777343519937.jpg', '', '9', '14', '', '', 'Labuan', '', '350000', '150000'),
('489', 'Marina Cottage', '/uploads/1777343658934.jpg', '0823-4995-1833', '31', '49', '', 'https://maps.app.goo.gl/fzk8vXEdsjtYH5Jk9?g_st=ac', '4JW2+37, Jl. Tj. Api No.33, Labuan, Kec. Ampana Kota, Kabupaten Tojo Una-Una, Sulawesi Tengah 94683', '', '504000', '350000'),
('490', 'Nebula Cottage', '/uploads/1777343762063.jpg', '0822-5944-5457', '4', '6', 'https://nebulacottages.weebly.com/', 'https://maps.app.goo.gl/UjPjx6EyMNACwKmL8?g_st=ac', 'Labuan', '', '350000', '150000'),
('491', 'Balayudha', '/uploads/1777343913753.jpg', '', '4', '4', '', 'https://maps.app.goo.gl/1ADWcNKtuvGMi4PB9?g_st=ac', 'P267+9X5, Bulan Jaya, Kec. Ampana Tete, Kabupaten Tojo Una-Una, Sulawesi Tengah 94765', '', '350000', '150000'),
('492', 'Lumintu penginapan ', '/uploads/1777344070620.jpg', '0853-4122-4224', '3', '4', '', '', '4JFR+RH8, Jl. Samratulangi, Tete B, Kec. Ampana Tete, Kabupaten Tojo Una-Una, Sulawesi Tengah 94684', '', '250000', '100000'),
('64', 'PALU GOLDEN HOTEL ', '/uploads/1779525663839.jpg', '(0451) 8456565', '35', '57', 'Amenitas Pariwisata di Kabupaten Donggala https://share.google/rDWGEYV5iGAqF4LpJ', 'https://maps.app.goo.gl/o6MD7YaxKW4Tr9Qt8?g_st=ac', '4V89+695, Jl. Raden Saleh No.1, Besusu Bar., Kec. Palu Tim., Kota Palu, Sulawesi Tengah 94118', '', '1000000', '300000'),
('129', 'Penginapan Awinda', '/uploads/1774949720315.jpg', '0852-1183-9384', '22', '22', 'Sumber: Sisparnas https://share.google/trbfz3ZQeq5c8zKcZ', 'https://maps.app.goo.gl/HFrLvcuVgF2CnuvE6?g_st=ac', 'Jl. Trans Sulawesi, Bainaa Sel., Kec. Tinombo, Kabupaten Parigi Moutong, Sulawesi Tengah', '', '250000', '150000'),
('90', 'Penginapan Andi Patiwiri', '/uploads/1774765454564.jpg', '0822-1181-6445', '10', '10', 'Amenitas Pariwisata di Kabupaten Parigi Moutong https://share.google/C5BKYiqik4nJZgOBv', 'https://maps.app.goo.gl/qyY2qJJ86yWTTWwKA?g_st=ac', 'Jl. Pramuka, Bantaya, Kec. Parigi, Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '220000', '165000'),
('82', 'Penginapan Parigi Selatan', '/uploads/1774763221873.jpg', '0813-4125-7697', '12', '12', '-', 'https://maps.app.goo.gl/BwegWgud7GtqpHRQ7?g_st=ac', 'Masigi, Kec. Parigi Bar., Kabupaten Parigi Moutong, Sulawesi Tengah 94471', '', '250000', '250000'),
('119', 'Hotel Zein ', '/uploads/1774948233324.jpg', '0853-9847-0789', '8', '8', 'https://share.google/j431SHYcHo3fo0EKm', 'https://www.google.com/maps/place/ZEIN+HOTEL+AMPIBABO/@-0.4586126,120.0616702,17z/data=!3m1!4b1!4m6!3m5!1s0x2d8a2f688c14acdb:0x4e899852d2a8170a!8m2!3d-0.458618!4d120.0642505!16s%2Fg%2F11h21y29rb?entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Ampibabo Utara, Kec. Ampibabo, Kabupaten Parigi Moutong, Sulawesi Tengah 94474', '', '280000', '280000'),
('151', 'Penginapan Bengawan Solo', '/uploads/1775112132451.jpg', '', '15', '15', '', 'https://maps.app.goo.gl/zMw5kiDC6GpisrW48', 'Jl. Ki Hajar Dewantara, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('153', 'Penginapan Melati', '/uploads/1775112409201.jpg', '', '11', '11', '', 'https://www.google.com/maps/place/Penginapan+Melati/@0.5426391,120.7285344,20.12z/data=!4m6!3m5!1s0x3276f830b5732c39:0xbcce580e9cc13e7d!8m2!3d0.5426184!4d120.7289717!16s%2Fg%2F11f3v57xtr?hl=id-ID&entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Jl. Ki Hajar Dewantara, Kotaraya, Mepanga, Kabupaten Parigi Moutong, Sulawesi Tengah 94479', '', '250000', '150000'),
('179', 'Wisma Kawanua', '/uploads/1775290446151.jpg', '(0453) 21524', '8', '8', 'Sumber: Facebook https://share.google/RERp6tit1C5zIKBVX', 'https://maps.app.goo.gl/JiHqrEZ8UsTRTfC79?g_st=ac', 'Pantoloan - Toli Toli Jl. Ladapi, Baru, Kec. Baolan, Kabupaten Toli-Toli, Sulawesi Tengah 94514', '', '250000', '150000'),
('199', 'Nayla Guest House', '/uploads/1775446286863.jpg', '0852-5570-5444', '20', '30', 'Sumber: Instagram https://share.google/B4zdvi8BXNlKcVeBj', 'Guest House Nayla https://share.google/yURsMVgPuOWl1hxPk', 'Jl. Kuda Laut, Bahoue, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '350000', '250000'),
('210', 'Bougenville', '/uploads/1775448962003.jpg', '0822-1352-4321', '14', '21', 'Sumber: Facebook https://share.google/FFSBJSkQEXfY2ipOD', 'https://maps.app.goo.gl/iR2N14KTqqqBfaGy7?g_st=ac', 'Jl. Lkr Luar Kolonodale, Unnamed Road, Kolonodale, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '400000', '250000'),
('213', 'Penginapan Asa Aroa', '/uploads/1775449361334.jpg', '0858-8195-1713', '18', '27', '', 'https://www.google.com/maps/place/Penginapan+Asa+Aroa/@-2.018028,121.3419952,17z/data=!3m1!4b1!4m6!3m5!1s0x2d8fe73fffbcadf3:0x2c749c94916a2033!8m2!3d-2.0180334!4d121.3445701!16s%2Fg%2F11pvhg363t!18m1!1e1?entry=ttu&g_ep=EgoyMDI2MDYwMy4xIKXMDSoASAFQAw%3D%3D', 'Jl. Trans Sulawesi, Unnamed Road, Korololama, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '200000'),
('243', 'Ziv Guest House', '/uploads/1775544962094.jpg', '0813-5460-8376', '5', '8', '', 'https://maps.app.goo.gl/jTCSyxkoDdcm4Ag27', 'Jl. Trans Sulawesi, Bunta, Kec. Petasia, Kabupaten Morowali Utara, Sulawesi Tengah 94971', '', '250000', '150000'),
('276', 'Penginapan Deny', '/uploads/1775584110343.jpg', '', '6', '9', '', 'https://maps.app.goo.gl/JZ5ea3ctgC8e5LNX6?g_st=ac', 'Jl. Trans Sulawesi, Unnamed Road, Tana Sumpu, Kec. Mamosalato, Kabupaten Morowali Utara, Sulawesi Tengah 94972', '', '350000', '150000');

INSERT INTO `Kuliner` (`id`, `nama_makanan`, `foto`, `deskripsi_id`, `deskripsi_en`, `lokasi`, `link_video`) VALUES
('4', 'Ayam Panggang Biromaru ', '/uploads/1774538101428.jpeg', 'Ayam panggang Biromaru adalah kuliner legendaris khas kabupaten sigi, Sulawesi Tengah (populer di area Palu) yang menggunakan ayam kampung muda.
Dengan cita rasa: Gurih, manis, dan berlemak dengan bumbu rempah lokal yang meresap ke dalam ayam kampung muda yang dilumuri bumbu kental (berbahan dasar santan) Kemudian dipanggang/dibakar berulang kali hingga matang, empuk dan aromatik. Disajikan dengan ketupat, kuah santan (uta dada), rica rica (sambal), dan perasan jeruk.
Hidangan ini merupakan ikon kuliner sigi yang sudah terkenal sejak tahun 1950-an.', 'Biromaru roast chicken is a legendary culinary dish typical of Sigi district, Central Sulawesi (popular in the Palu area) which uses young free-range chicken.
 With taste: Savory, sweet and fatty with local spices that are infused into young free-range chicken coated in thick spices (made from coconut milk). Then grilled/grilled repeatedly until cooked, tender and aromatic.  Served with ketupat, coconut milk sauce (uta dada), rica rica (chili sauce), and orange juice.
 This dish is a culinary icon of Sigi that has been famous since the 1950s.', 'Kabupaten Sigi', ''),
('16', 'Kaledo', '/uploads/1774937784596.jpg', 'Kaledo adalah makanan khas dari Palu yang sangat populer dan menjadi ikon kuliner daerah tersebut. Nama “Kaledo” sendiri merupakan singkatan dari Kaki Lembu Donggala.

Ciri Khas Kaledo
Menggunakan tulang kaki sapi dengan sumsum yang melimpah
Disajikan dalam kuah bening, asam, dan sedikit pedas
Biasanya dimakan bersama ubi rebus, bukan nasi
Disajikan dengan sedotan untuk menikmati sumsum di dalam tulang

Rasa & Sensasi
Kaledo memiliki rasa yang unik:

Segar dari asam (biasanya dari asam jawa atau belimbing wuluh)
Gurih dari kaldu tulang sapi
Pedas ringan dari cabai
Kombinasi ini membuatnya sangat cocok dinikmati saat cuaca panas maupun hujan.

Cara Menikmati
Seruput kuahnya terlebih dahulu
Gunakan sedotan untuk mengambil sumsum
Nikmati daging yang menempel di tulang
Padukan dengan sambal dan ubi rebus', 'Kaledo is a typical food from Palu which is very popular and has become a culinary icon of the area.  The name "Kaledo" itself is an abbreviation of Donggala Ox Leg.

 Characteristics of Kaledo
 Using beef leg bones with abundant marrow
 Served in a clear, sour and slightly spicy sauce
 Usually eaten with boiled sweet potatoes, not rice
 Served with a straw to enjoy the marrow inside the bone

 Taste', 'Kabupaten Donggala', ''),
('17', 'Uvempoi', '/uploads/1774938780385.jpg', 'Uvempoi adalah salah satu makanan tradisional dari Palu yang terkenal dengan kuah asam segar dan cita rasa khas daerah Kaili.

Apa itu Uvempoi?

Uvempoi adalah sup daging sapi, biasanya menggunakan tulang rusuk yang masih ada dagingnya.

Nama “Uvempoi” berasal dari bahasa Kaili:

Uve = air
Mpoi = asam
Jadi, arti sederhananya adalah “air/kuah asam”
Ciri Khas Uvempoi
Kuah bening, asam, dan segar
Bumbu sederhana: asam jawa, cabai, garam
Daging dimasak sampai empuk dan meresap
Biasanya disajikan dengan:
Burasa (nasi santan dalam daun pisang)
Atau nasi/ubi rebus

Rasa & Sensasi
Rasanya:
Asam segar (ciri utama)
Gurih dari kaldu daging
Sedikit pedas
Cocok banget dimakan saat cuaca dingin atau saat ingin makanan berkuah yang ringan tapi nikmat.', 'Uvempoi is a traditional food from Palu which is famous for its fresh sour sauce and the typical taste of the Kaili region.

 What is Uvempoi?

 Uvempoi is a beef stew, usually using ribs that still have meat on them.

 The name "Uvempoi" comes from the Kaili language:

 Uve = water
 Mpoi = sour
 So, the simple meaning is "water/sour sauce"
 Characteristics of Uvempoi
 Clear, sour and fresh sauce
 Simple spices: tamarind, chili, salt
 The meat is cooked until tender and marinated
 Usually served with:
 Burasa (coconut milk rice in banana leaves)
 Or boiled rice/sweet potatoes

 Taste', 'Palu', ''),
('18', 'Utadada', '/uploads/1774940102823.jpg', 'Utadada adalah salah satu kuliner tradisional dari Palu yang berasal dari masyarakat suku Kaili. Hidangan ini dikenal sebagai olahan jeroan sapi berkuah santan dengan cita rasa gurih dan khas.

Apa itu Utadada?

Utadada merupakan masakan berbahan dasar:

Jeroan sapi (usus, babat, hati, dll.)
Dimasak dengan kuah santan kental
Dibumbui rempah-rempah khas lokal

Hidangan ini sering dianggap sebagai makanan tradisional yang kaya rasa dan bernilai budaya.

Ciri Khas Utadada
Kuah kental dan gurih dari santan
Aroma rempah yang kuat
Tekstur jeroan yang empuk dan lembut
Biasanya disajikan panas dengan nasi atau burasa
Rasa & Sensasi

Rasanya:

Gurih dominan dari santan
Sedikit pedas
Aroma khas jeroan yang kuat dan autentik

Berbeda dengan Kaledo atau Uvempoi yang segar-asam, Utadada lebih “berat” dan kaya rasa.', 'Utadada is a traditional culinary dish from Palu that originates from the Kaili tribe.  This dish is known as processed beef offal in coconut milk sauce with a savory and distinctive taste.

 What is Utadada?

 Utadada is a dish made from:

 Beef offal (intestines, tripe, liver, etc.)
 Cooked with thick coconut milk sauce
 Seasoned with typical local spices

 This dish is often considered a traditional food that is rich in flavor and has cultural value.

 Characteristics of Utadada
 Thick and tasty sauce made from coconut milk
 Strong spice aroma
 The texture of the innards is soft and tender
 Usually served hot with rice or burasa
 Taste', 'Palu', ''),
('21', 'DuoSole', '/uploads/1774941516075.jpg', 'Duo Sole atau sering disebut Duo Sale adalah salah satu makanan khas dari Palu yang sangat populer di kalangan masyarakat Kaili. Hidangan ini biasanya berupa sambal atau lauk dari ikan kecil (teri) yang diolah dengan bumbu khas.

Apa itu Duo Sole?
Terbuat dari ikan duo (mirip ikan teri kecil) yang dikeringkan
Dimasak dengan cabai, bawang, dan tomat
Bisa berupa sambal atau lauk kering

Nama:

Duo = ikan kecil
Sale = dikeringkan / diasapi
Ciri Khas Duo Sole
Rasa gurih, asin, dan sedikit pedas
Kadang ada sentuhan manis dari tomat
Tekstur ikan renyah setelah digoreng
Aroma khas dari ikan kering

Duo sale tidak terlalu pedas dibanding sambal daerah lain, tapi tetap menggugah selera.

Cara Menikmati

Biasanya dimakan dengan:

Nasi putih hangat
Nasi jagung khas Palu
Disandingkan dengan sayur seperti uta kelo (daun kelor)

Bahkan sering jadi pelengkap makanan khas lain seperti Kaledo.

Keunikan & Nilai Budaya
Berasal dari tradisi masyarakat pesisir yang mengawetkan ikan dengan cara dikeringkan
Menjadi lauk sederhana tapi kaya rasa dan bergizi
Tinggi protein dan kalsium dari ikan kecil
Kenapa Wajib Dicoba?
Ikon kuliner sederhana khas Palu
Rasanya bikin “nambah nasi” 
Cocok untuk pecinta makanan gurih pedas', 'Duo Sole or often called Duo Sale is a typical food from Palu which is very popular among the Kaili people.  This dish usually consists of chili sauce or a side dish made from small fish (anchovies) prepared with special spices.

 What is Duo Sole?
 Made from dried duo fish (similar to small anchovies).
 Cooked with chilies, onions and tomatoes
 It can be in the form of chili sauce or dry side dishes

 Name:

 Duo = small fish
 Sale = dried / smoked
 Distinctive Characteristics of Duo Sole
 Savory, salty and slightly spicy taste
 Sometimes there is a touch of sweetness from tomatoes
 The texture of the fish is crispy after frying
 The distinctive aroma of dried fish

 Duo sale is not too spicy compared to other regional chili sauces, but still appetizing.

 How to Enjoy

 Usually eaten with:

 Warm white rice
 Palu specialty corn rice
 Paired with vegetables such as uta kelo (moringa leaves)

 In fact, it is often used as a complement to other typical foods such as Kaledo.

 Uniqueness', 'Kota Palu', ''),
('19', 'Masakan Khas Kaili', '/uploads/1779334389618.png', 'Masakan khas suku Kaili dari Palu terkenal dengan cita rasa asam, gurih, dan segar, serta penggunaan bahan lokal seperti ikan laut, daging sapi, dan rempah sederhana.

Berikut beberapa kuliner khas Kaili yang wajib kamu tahu:

1. Kaledo (Kaki Lembu Donggala)
Sup dari kaki sapi dengan kuah asam segar
Disajikan dengan ubi rebus
Ikonik karena sumsum tulangnya yang diseruput pakai sedotan

 Ini adalah makanan paling terkenal dari Palu.

 2. Uvempoi
Sup rusuk sapi berkuah asam
Rasa ringan, segar, dan sedikit pedas
Biasanya dimakan dengan burasa
3. Utadada
Olahan jeroan sapi dengan santan
Kuah kental dan gurih
Cocok untuk pecinta masakan berempah kuat
4. Palumara
Masakan ikan kuah kuning
Bumbu kunyit, asam, dan cabai
Rasanya segar dan sedikit pedas

Mirip dengan ikan kuah kuning di daerah timur Indonesia lainnya.

5. Burasa
Nasi dimasak dengan santan lalu dibungkus daun pisang
Teksturnya lembut dan gurih
Biasanya jadi pendamping utama berbagai lauk
6. Duo Sale
Ikan roa atau ikan kecil yang diasap/kering
Rasanya gurih dan sedikit asin
Sering dijadikan lauk sederhana atau oleh-oleh
Ciri Khas Masakan Kaili
Dominan rasa asam segar (asam jawa/belimbing)
Banyak menggunakan ikan laut & sapi
Bumbu sederhana tapi kuat rasa alami
Disajikan hangat dengan pelengkap tradisional', 'The typical cuisine of the Kaili tribe from Palu is famous for its sour, savory and fresh taste, as well as the use of local ingredients such as sea fish, beef and simple spices.

 Here are some typical Kaili culinary delights that you must know:

 1. Kaledo (Donggala Ox Leg)
 Beef leg soup with fresh sour sauce
 Served with boiled sweet potato
 Iconic because the bone marrow is slurped using a straw

  This is the most famous food from Palu.

  2. Uvempoi
 Beef rib soup with sour sauce
 The taste is light, fresh and slightly spicy
 Usually eaten with burasa
 3. Utadada
 Processed beef offal with coconut milk
 Thick and tasty sauce
 Suitable for lovers of strong spiced dishes
 4. Palumara
 Fish dish in yellow sauce
 Turmeric, tamarind and chili spices
 It tastes fresh and slightly spicy

 Similar to other yellow sauce fish in eastern Indonesia.

 5. Burasa
 Rice is cooked in coconut milk and then wrapped in banana leaves
 The texture is soft and tasty
 Usually it is the main accompaniment to various side dishes
 6. Duo Sale
 Smoked/dried roa fish or small fish
 It tastes savory and slightly salty
 Often used as a simple side dish or souvenir
 Characteristics of Kaili Cuisine
 Dominant fresh sour taste (tamarind/star fruit)
 Many use sea fish', 'Palu', ''),
('25', 'Tombouat', '/uploads/1774945917799.jpg', 'Tombouat adalah salah satu makanan tradisional khas dari Buol yang terkenal dengan kuah asam pedas segar dan bahan utama ikan laut.

Apa itu Tombouat?

Tombouat merupakan:

Masakan berbahan dasar ikan laut segar
Dimasak dengan kuah asam pedas
Menggunakan bumbu sederhana khas daerah pesisir

Ikan yang biasa digunakan:

Ikan kakap
Ikan tongkol
Ikan kerapu
Ciri Khas Tombouat
Kuah bening, asam, dan pedas
Aroma segar dari bahan alami
Tanpa santan (lebih ringan)
Rasa kuat tapi tidak terlalu berat
Rasa & Sensasi
Asam segar (biasanya dari asam jawa atau belimbing)
Pedas ringan–sedang
Gurih alami dari ikan

sangat cocok dimakan saat:

Cuaca panas 
Atau saat ingin makanan ringan dan menyegarkan
Cara Menikmati

Biasanya disajikan dengan:

Nasi putih hangat
Sambal tambahan
Lalapan sederhana', 'Tombouat is a typical traditional food from Buol which is famous for its fresh spicy sour sauce and sea fish as the main ingredient.

 What is Tombouat?

 Tombouat is:

 A dish made from fresh sea fish
 Cooked with spicy sour sauce
 Using simple spices typical of coastal areas

 Commonly used fish:

 Snapper
 Tuna fish
 Grouper fish
 Typical Characteristics of Tombouat
 Clear, sour and spicy sauce
 Fresh aroma from natural ingredients
 Without coconut milk (lighter)
 Strong taste but not too heavy
 Taste', 'Kabupaten Buol', ''),
('22', 'Ambal', '/uploads/1774941813615.jpg', 'Ambal adalah salah satu makanan tradisional khas dari Buol yang terkenal dengan kuah gurih dan kaya rempah. Hidangan ini banyak dijumpai di masyarakat pesisir dan menjadi bagian dari budaya kuliner lokal.

Apa itu Ambal?

Ambal merupakan:

Masakan berbahan dasar ikan laut segar
Dimasak dengan kuah santan atau kuah kuning
Menggunakan bumbu seperti kunyit, bawang, cabai, dan rempah lokal

Biasanya menggunakan ikan seperti:
Ikan kakap
Ikan tongkol
Atau ikan laut lain yang segar
Ciri Khas Ambal
Kuah gurih, sedikit pedas, dan harum rempah
Warna bisa kuning (kunyit) atau putih santan
Tekstur ikan lembut dan segar
Aroma khas masakan pesisir
Cara Penyajian

Ambal biasanya disajikan dengan:

Nasi putih hangat 
Sambal khas daerah
Lalapan sederhana
Kapan Disajikan?
Acara adat & keluarga
Jamuan tamu
Makan sehari-hari masyarakat Buol
Cita Rasa
Gurih dominan dari santan
Segar dari ikan laut
Sedikit pedas dan wangi rempah
Keunikan Ambal
Mencerminkan budaya pesisir Buol
Menggunakan bahan sederhana tapi rasa kaya
Mirip dengan beberapa masakan ikan Nusantara, tapi punya sentuhan lokal khas Buol', 'Ambal is a typical traditional food from Buol which is famous for its savory sauce and rich spices.  This dish is often found in coastal communities and is part of the local culinary culture.

 What is Ambal?

 Ambal is:

 A dish made from fresh sea fish
 Cooked with coconut milk or yellow sauce
 Using spices such as turmeric, onions, chilies and local spices

 Usually use fish such as:
 Snapper
 Tuna fish
 Or other fresh sea fish
 Characteristics of Ambal
 Savory sauce, slightly spicy, and fragrant with spices
 The color can be yellow (turmeric) or white in coconut milk
 The texture of the fish is soft and fresh
 Typical aroma of coastal cuisine
 How to Serve

 Ambal is usually served with:

 Warm white rice 
 Typical regional chili sauce
 Simple salad
 When is it served?
 Traditional event', 'Kabupaten Buol', ''),
('24', 'Ikan Bakar Donggala', '/uploads/1774945710322.jpg', 'Rumah makan ini adalah salah satu tempat makan ikan bakar paling terkenal di Donggala, tepatnya di jalur Trans Palu–Donggala.

Lokasi & Suasana
Terletak di kawasan Kabonga, Donggala
Dekat pantai → bisa makan sambil lihat laut 
Cocok untuk:
Makan keluarga
Nongkrong santai
Rombongan

Banyak pengunjung bilang tempat ini punya pemandangan laut yang indah dan suasana nyaman

Menu Andalan
Ikan bakar (kakap, tuna, dll)
Seafood: udang, cumi
Sambal khas (rica, dabu-dabu)
Nasi & lalapan

Ciri khasnya:

Ikan segar langsung dibakar
Bumbu khas Sulawesi yang gurih & pedas
Review & Kesan Pengunjung
Banyak yang menyebut:
Rasa enak & ikan segar
Cocok untuk makan siang & malam rame-rame
Rating sekitar 4.2/5 dengan ratusan ulasan
Tapi ada juga catatan:
Kadang ramai saat jam makan siang
Pelayanan bisa sedikit lama', 'This restaurant is one of the most famous places to eat grilled fish in Donggala, precisely on the Trans Palu–Donggala route.

 Location', 'Donggala', ''),
('20', 'Lalampa', '/uploads/1774941255074.jpg', 'Lalampa adalah makanan khas dari daerah Parigi Moutong (Toboli) yang juga sangat populer di Palu. Kuliner ini sering disebut sebagai “lemper khas Sulawesi”, tapi punya cita rasa dan cara masak yang berbeda.

Apa itu Lalampa?

Lalampa adalah:

Beras ketan yang dimasak dengan santan
Diisi dengan ikan cakalang/tuna suwir berbumbu pedas
Dibungkus daun pisang
Lalu dipanggang di atas bara api

Proses dibakar inilah yang membuat lalampa punya aroma khas yang tidak dimiliki lemper biasa

Ciri Khas Lalampa
Bentuk lonjong seperti lontong/lemper
Rasa gurih, pedas, dan sedikit smoky (aroma bakar)
Tekstur kenyal dari ketan
Aromanya harum dari daun pisang
Asal & Keunikan
Berasal dari Desa Toboli, Kabupaten Parigi Moutong
Sudah ada sejak sekitar tahun 1930-an
Banyak dijual di sepanjang jalan Trans Sulawesi (tempat singgah pengendara)
Bahkan telah diakui sebagai kekayaan budaya komunal (KIK)
Kapan Dimakan?
Camilan saat perjalanan jauh
Teman minum kopi
Hidangan acara adat & keluarga
Kenapa Wajib Dicoba?
Ikon kuliner jalanan Sulawesi Tengah
Rasanya unik: gurih + pedas + aroma bakar
Mudah ditemukan dan harga terjangkau', 'Lalampa is a typical food from the Parigi Moutong (Toboli) area which is also very popular in Palu.  This culinary dish is often referred to as "typical Sulawesi lemper", but it has a different taste and cooking method.

 What is Lalampa?

 Lalampa is:

 Sticky rice cooked with coconut milk
 Filled with spicy shredded skipjack tuna/tuna
 Wrapped in banana leaves
 Then grilled over hot coals

 The burning process is what makes lalampa have a distinctive aroma that ordinary lemper doesn\'t have

 Characteristics of Lalampa
 Oval shape like lontong/lemper
 Savory, spicy and slightly smoky taste (grilled aroma)
 Chewy texture of sticky rice
 The aroma is fragrant from banana leaves
 Origin', 'Kabupaten Parigi', ''),
('23', 'Utadada dan Uvempoi', '/uploads/1774945416967.png', 'Di Kabupaten Sigi, dua kuliner khas dari masyarakat suku Kaili yang sangat terkenal adalah Utadada dan Uvempoi. Keduanya sering hadir dalam acara adat maupun hidangan sehari-hari, tetapi memiliki cita rasa yang berbeda.

 Utadada

Utadada adalah masakan tradisional berbahan dasar jeroan sapi yang dimasak dengan santan.

Ciri khas:
Kuah kental dan gurih dari santan
Menggunakan jeroan (usus, babat, hati)
Aroma rempah kuat
Tekstur lembut dan kaya rasa
Rasa:
Dominan gurih dan sedikit pedas
Lebih “berat” dibanding masakan berkuah lain
Biasanya disajikan saat:
Acara adat Kaili
Syukuran & pesta keluarga
Hari besar seperti Idul Fitri & Idul Adha
Uvempoi

Uvempoi adalah sup daging (biasanya rusuk sapi) dengan kuah asam segar.

Ciri khas:
Kuah bening dan asam
Bumbu sederhana (asam, cabai, garam)
Daging empuk dan ringan
Rasa:
Asam segar dan gurih ringan
Lebih menyegarkan dibanding Utadada
Penyajian:
Biasanya dengan burasa atau nasi putih
Cocok dimakan saat cuaca panas
Nilai Budaya di Sigi

Kedua makanan ini:

Merupakan bagian dari warisan kuliner suku Kaili
Menggambarkan kebersamaan dalam acara adat
Masih dilestarikan hingga sekarang di Sigi dan Palu', 'In Sigi Regency, two very famous culinary specialties from the Kaili tribe are Utadada and Uvempoi.  Both are often present in traditional events and everyday dishes, but have different tastes.

  Utadada

 Utadada is a traditional dish made from beef offal cooked in coconut milk.

 Distinctive features:
 Thick and tasty sauce made from coconut milk
 Using offal (intestine, tripe, liver)
 Strong spice aroma
 Soft texture and rich taste
 Taste:
 Dominantly savory and slightly spicy
 Heavier than other soupy dishes
 Usually served when:
 Kaili traditional event
 Thanksgiving', 'Sigi', '');

INSERT INTO `RumahMakan` (`id`, `resto`, `kulinerId`, `link_gmaps`, `link_video`) VALUES
('16', 'Madamba 1', '4', 'https://maps.app.goo.gl/C1CKcEELMZD97PgG7', NULL),
('17', 'Warung Singgani', '4', 'https://maps.app.goo.gl/7RqFjBWCeTqmwDPy9', NULL),
('18', 'Palu Kuring Cafe Resto', '4', 'https://maps.app.goo.gl/8t4Whswxon855Uit5', NULL),
('19', 'Kaledo Loli', '16', 'https://maps.app.goo.gl/gJRx2NKoD4M4mdxW6', NULL),
('20', 'Kaledo Om Bae', '16', 'https://maps.app.goo.gl/UbvMEZJXQXkEHswU9', NULL),
('21', 'Kaledo Stereo', '16', 'https://maps.app.goo.gl/TnZ64vGXzJHbWNabA', NULL),
('22', 'Kaledo Stereo Puebongo', '16', 'https://maps.app.goo.gl/5Hunjev8RZAfGgRMA', NULL),
('23', 'Kaledo Stereo Yos Sudarso', '16', 'https://maps.app.goo.gl/pD6xCsdEVuQJN2z89', NULL),
('24', 'Kaledo Stereo Silae Puncak', '16', 'https://maps.app.goo.gl/43N1V3RzQnPoodXF6', NULL),
('25', 'Kaledo Tumbelaka', '16', 'https://maps.app.goo.gl/8Gn5MQXaNHWRqXCb6', NULL),
('26', 'Kaledo Om Pado', '16', 'https://maps.app.goo.gl/1Kt9hgYSfE5mWgCR6', NULL),
('27', 'Kaledo Watusampu', '16', 'https://maps.app.goo.gl/1KxLzHAQT9eSQbYt5', NULL),
('28', 'Kaledo Megaria', '16', 'https://maps.app.goo.gl/PYswdeSfjWruhZqe8', NULL),
('29', 'Uvempoi Tinai Jami', '17', 'Jl. Kunduri Lrg. 1, Balaroa, Kec. Palu Bar., Kota Palu, Sulawesi Tengah 94111', NULL),
('30', 'Uvempoi Ina Djuha', '17', 'https://maps.app.goo.gl/TQNURowZ6kukV4DM8', NULL),
('31', 'Warung Umi Bela', '17', 'https://maps.app.goo.gl/4dVJGNteDgQkZ2MdA', NULL),
('32', 'Utadada Bawah Jembatan', '18', 'https://maps.app.goo.gl/SEmYanbXDwvNkzPH6', NULL),
('33', 'Warung Uta Dada Mama Jana', '18', 'Jl. Tonomoro, Balane, Kec. Kinovaro, Kabupaten Sigi, Sulawesi Tengah', NULL),
('34', 'Laguna Cafe', '19', 'https://maps.app.goo.gl/vmW2srtHhrvtES6u7', NULL),
('35', 'Warung Resep Candy', '19', 'https://maps.app.goo.gl/MHYNTyu8jTdHUPfr9', NULL),
('36', 'Rumah Makan Tinaku', '19', 'https://maps.app.goo.gl/rn55BM8dCBAcqf1r7', NULL),
('37', 'Rumah Makan Tinaku 2', '19', 'https://maps.app.goo.gl/CtVYfuMZU4prGW7y7', NULL),
('38', 'Kedai Thoma\'ss', '19', 'https://maps.app.goo.gl/DxGB25VZJX6di5EK9', NULL),
('39', 'Dapur Kaili', '19', 'https://maps.app.goo.gl/YJiX8wU9VfC4gEPx9', NULL),
('40', 'Kedai Kopi dan Raja Lalampa', '20', 'https://maps.app.goo.gl/FEc6JeH5f2M6fyUu9', NULL),
('41', 'Lalampa Makuni', '20', 'https://maps.app.goo.gl/Mo9Sz6WoDzvhDcuY9', NULL),
('42', 'Duo Sole', '21', '3VMH+7Q6, Tatura Utara, Palu Selatan, Palu City, Central Sulawesi 94111', NULL),
('43', 'Kedai Dua Putri Pantai Maninang', '22', 'https://maps.app.goo.gl/LYv3irSqrSpVBMaX6', NULL),
('44', 'Rumah Makan Poering', '23', 'https://maps.app.goo.gl/V14qZi1CPKkUxpQG7', NULL),
('45', 'Rumah Makan Ikan Bakar Terminal Indah', '24', 'https://maps.app.goo.gl/Z8aHY6MT7E7Krypo6', NULL),
('46', '', '25', 'https://maps.app.goo.gl/UMXrcXg3MU6gkCpf9', NULL);

INSERT INTO `TourPackage` (`id`, `nama_wisata_id`, `nama_wisata_en`, `harga`, `deskripsi_id`, `deskripsi_en`, `kontak`, `media`, `lokasi_id`, `lokasi_en`, `link_video`) VALUES
('3', 'Poso Bada Valley', 'Poso Bada Valley', '2900000', 'Wisata patung megalit di Lembah Bada adalah perpaduan sejarah kuno, misteri, dan keindahan alam. Keunikan bentuk patung serta asal-usulnya yang belum terpecahkan menjadikan tempat ini sangat menarik bagi wisatawan, peneliti, maupun pecinta sejarah.', 'Megalith statue tourism in the Bada Valley is a combination of ancient history, mystery and natural beauty.  The unique shape of the statue and its unsolved origins make this place very interesting for tourists, researchers and history lovers.', '628114545954', '/uploads/1775444432662.jpeg', 'Gebang Rejo, Kabupaten Poso, Sulawesi Tengah', 'Gebang Rejo, Poso Regency, Central Sulawesi', ''),
('4', 'Ampana Togean Island', 'Ampana Togean Island', '2250000', 'Kepulauan Togean adalah salah satu surga wisata tersembunyi di Indonesia yang terletak di Teluk Tomini, tepatnya di wilayah Sulawesi Tengah. Destinasi ini terkenal dengan keindahan alamnya yang masih sangat alami dan belum terlalu ramai wisatawan.
', 'The Togean Islands are one of the hidden tourist paradises in Indonesia, located in Tomini Bay, precisely in the Central Sulawesi region.  This destination is famous for its natural beauty which is still very natural and not too crowded with tourists.', '6281340814811', '/uploads/1775445067007.jpeg', 'Kabupaten Tojo Una-Una, Sulawesi Tengah', 'Tojo Una-Una Regency, Central Sulawesi', ''),
('5', 'Paisupok Lake', 'Paisupok Lake', '2600000', 'Paisu Pok Lake adalah salah satu destinasi wisata alam yang sangat unik dan masih tergolong “hidden gem” di Indonesia. Terletak di Pulau Peleng, kawasan Banggai Kepulauan, danau ini terkenal karena kejernihan airnya yang luar biasa—bahkan sering disebut sebagai salah satu danau terjernih di Indonesia.', 'Paisu Pok Lake is a very unique natural tourist destination and is still classified as a "hidden gem" in Indonesia.  Located on Peleng Island, Banggai Islands area, this lake is famous for its extraordinary water clarity—it is often referred to as one of the clearest lakes in Indonesia.', '628114337690', '/uploads/1775445525037.jpeg', 'Luk Panenteng, Kec. Bulagi Utara, Kabupaten Banggai Kepulauan, Sulawesi Tengah 94882', 'Luk Panenteng, District.  North Bulagi, Banggai Islands Regency, Central Sulawesi 94882', ''),
('6', 'Kadidiri Island', 'Kadidiri Island', '2500000', 'Kadidiri Island adalah salah satu pulau tropis paling indah di gugusan Kepulauan Togean, yang terletak di Teluk Tomini, Sulawesi Tengah. Pulau ini terkenal karena suasananya yang masih sangat alami, jauh dari keramaian, dan cocok untuk pelancong yang mencari ketenangan.
', 'Kadidiri Island is one of the most beautiful tropical islands in the Togean Islands group, located in Tomini Bay, Central Sulawesi.  This island is famous for its very natural atmosphere, far from the crowds, and suitable for travelers looking for tranquility.', '6282140715684', '/uploads/1775445922826.jpeg', 'Kadidiri Island, Tanjung Pude, Una-Una, Tojo Una-Una Regency, Central Sulawesi 94691', 'Kadidiri Island, Tanjung Pude, Una-Una, Tojo Una-Una Regency, Central Sulawesi 94691', ''),
('7', 'Desa Wisata Malangga', 'Malangga Tourism Village', '1500000', 'Desa Wisata Malangga terletak di Malangga, bagian dari Kabupaten Tolitoli, Sulawesi Tengah. Desa ini mulai dikenal sebagai destinasi wisata berbasis alam dan budaya yang masih sangat alami, cocok untuk wisatawan yang ingin merasakan suasana pedesaan yang tenang dan autentik.', 'Malangga Tourism Village is located in Malangga, part of Tolitoli Regency, Central Sulawesi.  This village is starting to be known as a nature and culture-based tourist destination that is still very natural, suitable for tourists who want to experience a calm and authentic rural atmosphere.', '6285241409652', '/uploads/1775447386155.jpeg', '4V77+WH, Lakatan, Kabupate, Kabupaten Toli-Toli, Sulawesi Tengah', '4V77 WH, Lakatan, Regency, Toli-Toli Regency, Central Sulawesi', ''),
('9', 'Jellyfish Lake Togean', 'Jellyfish Lake Togean', '800000', 'Pulau Ubur-ubur di Kepulauan Togean adalah salah satu tempat paling unik di Indonesia, terutama karena keberadaan danau ubur-uburnya yang tidak menyengat. dan Berenang di sini terasa seperti berada di dunia lain—ubur-ubur bergerak pelan di air yang tenang, tanpa rasa takut tersengat. Banyak orang menyebutnya sebagai salah satu pengalaman snorkeling paling unik di Indonesia.

', 'Jellyfish Island in the Togean Islands is one of the most unique places in Indonesia, especially because of its stingless jellyfish lake.  and Swimming here feels like being in another world—jellyfish move slowly in the calm water, without the fear of being stung.  Many people call it one of the most unique snorkeling experiences in Indonesia.', '6281340321110', '/uploads/1775450842946.jpeg', 'Katupat, Kec. Togean, Kabupaten Tojo Una-Una, Sulawesi Tengah 94691', 'Katupat, District.  Togean, Tojo Una-Una Regency, Central Sulawesi 94691', ''),
('10', 'Sambori island', '', '1100000', 'Pulau Sambori (Sambori Island) adalah sebuah pulau eksotis dan relatif tersembunyi di Kabupaten Morowali, Provinsi Sulawesi Tengah, Indonesia. Pulau ini merupakan bagian dari gugusan kepulauan yang dikelilingi laut biru jernih dan dikenal sebagai surga bahari yang masih alami dan asri yang belum banyak tersentuh wisatawan massal.
', 'Sambori Island (Sambori Island) is an exotic and relatively hidden island in Morowali Regency, Central Sulawesi Province, Indonesia.  This island is part of a group of islands surrounded by clear blue sea and is known as an unspoiled and beautiful marine paradise that has not been touched by many mass tourists.', '6281214888500', '/uploads/1775452304953.jpeg', 'Matarape, Menui Kepulauan, Kabupaten Morowali, Sulawesi Tengah', 'Matarape, Menui Islands, Morowali Regency, Central Sulawesi', ''),
('11', 'Reconnect Island', 'Reconnect Island', '3500000', 'Reconnect Island adalah sebuah resor pulau pribadi dan pusat selam (dive center) yang terletak di **Pulau Buka Buka, di lepas pantai **Tojo Una‑Una, Sulawesi Tengah, Indonesia. Ini bukan sekadar tujuan wisata biasa — tempat ini dirancang sebagai tempat untuk “terputus dari hiruk‑pikuk kehidupan modern dan menyatu kembali dengan alam, diri sendiri, dan komunitas sekitar”.', 'Reconnect Island is a private island resort and dive center located on **Pulau Buka Buka, off the coast of **Tojo Una‑Una, Central Sulawesi, Indonesia.  This is not just another tourist destination — it was designed as a place to “disconnect from the hustle and bustle of modern life and reconnect with nature, oneself and the surrounding community.”', '6281246091346', '/uploads/1775455291348.jpeg', 'BukaBuka Island, Sulawesi Tengah 94684', 'BukaBuka Island, Central Sulawesi 94684', ''),
('12', 'Danau Lindu ', 'Lindu Lake', '650000', 'Taman Nasional Lore Lindu memiliki keistimewaan taman nasional ini terletak pada keragaman jenis fauna dan flora yang tidak ditemukan di taman nasional lain di dunia. Yah, TNLL menjadi rumah bagi flora dan fauna endemik langka yang hanya terdapat di Sulawesi ini. TNLL buka setiap hari dari pagi hingga sore hari. Dan tetap dijaga keistimewaannya sebagai kawasan Ekowisata & Konservasi.', 'Lore Lindu National Park (TNLL) The specialty of this national park lies in the diversity of fauna and flora that are not found in other national parks in the world.  Well, TNLL is home to rare endemic flora and fauna that only exist in Sulawesi.  TNLL is open every day from morning to evening.  And its privileges as an Ecotourism area are still maintained', '6282293882138', '/uploads/1777800108461.jpg', 'https://maps.app.goo.gl/GMPismfa2zpzpw5H6', 'https://maps.app.goo.gl/GMPismfa2zpzpw5H6', ''),
('14', 'Paralayang Salena ', 'Paragliding Salena', '700000', 'Berada di dataran tinggi, Dusun Salena salah satu lokasi paralayang   di kota Palu, menyajikan pemandangan hijau dengan hamparan kebun milik warga.  Dari atas ketinggian pengunjung akan dimanjakan dengan pemandangan lepas Teluk Palu dan landscape Kota Palu yang begitu eksotis. ', 'Located in the highlands, Salena Hamlet is one of the paragliding locations in the city of Palu, offering green views with expanses of residents\' gardens.   From the top, visitors will be treated to views of Palu Bay and the exotic landscape of Palu City.', '6285397987873', '/uploads/1779340102083.jpeg', 'Kota Palu, Sulawesi Tengah', 'Palu City, Central Sulawesi', ''),
('13', 'Desa Wisata Tenun Towale ', 'Towale Weaving Tourism Village', '540000', 'Sejak ditetapkan sebagai Desa Wisata Tenun oleh Bank Indonesia pada tahun 2020, Desa Towale yang terletak di Kabupaten Donggala, Sulawesi Tengah, terus aktif memproduksi kain Tenun Donggala dan memasarkannya ke berbagai wilayah di seluruh Indonesia.', 'Towale Village is a typical batik weaving tourist village in Central Sulawesi.', '6285397987873', '/uploads/1779337185416.jpeg', 'Donggala, Desa Towale, Sulawesi Tengah', 'Donggala, Towale Village, Central Sulawesi', ''),
('15', 'Sunset Trip Tanjung Karang ', 'Tanjung Karang Sunset Trip', '2750000', 'Wisata Sunset Trip Tanjung Karang adalah salah satu agenda terbaik untuk menikmati matahari terbenam dengan latar belakang laut biru jernih di Pantai Tanjung Karang, Donggala. Pantai ini berjarak sekitar 40 km (45–60 menit perjalanan darat) dari Kota Palu. Paket Wisata yang tertera sudah termaksud untuk 15 orang/trip.', 'The Tanjung Karang Sunset Trip is one of the best agendas for enjoying the sunset against the backdrop of the clear blue sea at Tanjung Karang Beach, Donggala.  This beach is about 40 km (45–60 minutes by land) from Palu City.  The tour package listed is intended for 15 people per trip', '6285397987873', '/uploads/1779341235418.jpeg', 'Tanjung Karang, Donggala, Sulawesi Tengah.', 'Tanjung Karang, Donggala, Central Sulawesi.', '');

INSERT INTO `Ulasan` (`id`, `nama`, `rating`, `komentar`, `createdAt`) VALUES
('1', 'Amanda', '5', 'Luk Panenteng bagus banget, ingin kesana lagi', '2026-03-16 18:44:37.627');

INSERT INTO `User` (`id`, `nama_Lengkap`, `jenis_kelamin`, `username`, `password`, `role`) VALUES
('1', 'Super Admin Dinas Pariwisata', 'Laki-laki', 'superadminPariwsata', '$2b$10$pRv4UKJ81vDd.vidDxJcbu0Bo2NJHrDm76IXUYC3UIKTnHKtF8Pg2', 'superAdmin'),
('15', 'Lilah Ramadanti', 'Perempuan', 'Danti', '$2b$10$A52dW9B431pfvNxxsO1d3O5.k940bNLvDUCYHxVooi8FP9s32vAZ2', 'Admin'),
('16', 'Ainun Lestari', 'Perempuan', 'Ainun', '$2b$10$QWmNiAtZq0Os7vkr4kgdWu4CwAVI1fJhWZF0NphEJY0cLieh9EwsS', 'Admin'),
('10', 'Pemasaran', 'Perempuan', '@pemasaran_123', '$2b$10$nofsLFCMUbY/fUJ4UZh1iOT6/AUMw7hbr8jxJCQajJ.1GgOqUsQ.e', 'Admin');

INSERT INTO `Visitor` (`id`, `uid`, `userAgent`, `createdAt`) VALUES
('2d4ebea4-3782-4c30-920f-bdf3bd09c699', 'test123', 'curl/8.5.0', '2026-03-13 17:05:28.111'),
('8e546ca1-1640-4e52-884d-db1c0608b285', '12cdedbe-672b-4dd6-ade3-3907c1819039', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-13 17:17:51.398'),
('ed758a93-8825-440c-87e3-59c01aa9ca4b', 'e96e8e78-4d51-4854-af98-eaf3726e6f3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2026-03-13 19:48:11.909'),
('3e0d1bbe-989e-4f65-937d-ad73661c0aaa', 'b05a2fa2-c493-40ab-b60a-75aa5312811b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148', '2026-03-13 19:48:14.423'),
('25a40f9a-6454-4dd6-ac71-8ff44752af79', '2f4eed5b-b7fa-4463-b3f5-f48654bb7bbe', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1', '2026-03-13 19:50:35.368'),
('15506064-364e-4014-98b4-06676841c4ff', 'bf086350-756a-49ae-a071-8df4e805ef12', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1', '2026-03-13 19:50:35.691'),
('773363e8-beaf-47fd-a005-76d8d757f75e', '7af9515e-c6f8-4985-a782-8f5208e0f634', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1', '2026-03-13 19:50:44.257'),
('e7e005ed-ada6-45f9-b788-84e69adc0d72', '8cd71969-8d24-43b2-81c9-2f3d424c3182', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36', '2026-03-13 19:51:12.771'),
('d2bda5fc-1119-4fa6-91b7-8c087e519e75', '3e54d3dc-6a3a-4331-8176-457a15f5e088', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-13 20:17:16.808'),
('3e528d5f-0f58-4202-8967-a0d107406261', '407e88f1-8e7a-42f2-ab46-734d70776ef0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', '2026-03-13 20:23:51.97'),
('e2e51dce-6a72-4acc-ad77-fa9ae78efa4b', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1', '2026-03-13 20:28:29.982'),
('98146024-5322-4c0a-9b31-145ea026c53f', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-14 04:48:09.299'),
('23376721-f474-4b2b-bad7-b0031438fe75', 'bd162006-68f8-40f2-8d99-5a491d933b6b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-14 06:31:33.875'),
('87072633-5e8d-4a39-89fc-4776d79808dc', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-14 07:14:53.561'),
('1a6e2aef-f3e5-4e6d-bfe3-9d244ad697fb', '46f0f828-d1a6-4979-a3ef-230906aaf674', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-14 07:22:00.154'),
('b5c4845f-0a28-403f-af47-a0b02167f6e5', 'c1909a97-6b06-49e4-b6cc-cd254c86de9c', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-15 08:26:04.671'),
('300c90e3-8d63-4d2f-a7ab-735c1dbe17ca', 'eb133ba6-005c-416a-8809-1f7a240b856d', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-16 06:47:37.83'),
('b758a732-2ee7-4174-9064-8a77ab919140', '4b6f8636-007e-44db-b450-4d9743bdff2c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', '2026-03-16 06:52:18.503'),
('08eeec13-43ac-405f-ae67-3743b15e50f1', '2eafb623-f85a-4b8c-8592-fae962728922', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-16 18:49:14.66'),
('e527cc2f-f14b-460e-85bc-a478f1bdc8f9', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '2026-03-17 02:00:28.495'),
('c38e577b-61ef-4c8f-a027-e3f2436c7889', '30c76bb4-8980-4a76-b38d-28571daa2689', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-18 08:50:19.778'),
('4ae5573e-594e-443e-a5cf-5dac2d022c5a', '77f4f9e1-21f8-4b55-b396-f741a04d731c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', '2026-03-18 09:10:09.487'),
('5522167b-cce9-4b5e-bd85-349be869b1d4', 'c2cbad4e-2d0a-4032-9b3f-d4c8a15997fe', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-18 11:19:34.131'),
('e74bb0d3-5441-4b59-9e21-d61ccbb70c8e', 'd02af506-cb81-4904-b877-2cf996988364', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-18 22:45:52.995'),
('5f56c28b-0ef5-4321-8421-eb6252890996', '00599e7d-4750-490d-84ab-051982fba9e7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-21 23:16:00.11'),
('01bf5cc4-6740-4810-8fb5-3258497276f8', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-23 16:18:24.021'),
('2e202bf1-40e1-4448-be8b-003ea952955c', '2ee02eb6-a392-49e9-80c6-d14e9e20610f', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-03-24 04:20:07.2'),
('a594f8f0-d878-4817-aa5b-b72ef773bb76', '7ae3bd66-4305-498f-8c79-0ecc81c9e20f', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-03-24 21:27:23.857'),
('5384cf8e-9f7e-4e0b-a1cc-291d80a44c3b', '710b727f-bb42-47fd-8104-ee4d0c25f31f', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-03-25 06:39:58.418'),
('16c143f2-b48c-44ad-9980-9fa4669c352a', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 05:35:06.007'),
('b8c04f89-0bfc-4469-bea9-73092ea60b10', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 07:00:53.49'),
('8916032c-0ebb-4b4c-adee-1d633b010846', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-30 14:41:38.638'),
('7b7f7983-881c-49fb-8998-cc665a2363bf', '24a0ce90-aff8-4449-9ed9-e7287ac9df5b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '2026-03-30 19:57:00.711'),
('c0618dd3-4255-4fbf-855d-cabbb9970d2b', '4be94977-d434-4c24-95c4-821070818c54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 07:23:06.305'),
('5be98ac1-d3bb-4b32-9a99-ac469d9b527f', 'ef5de50b-ae4a-4bd6-ba56-0a2cea2a58ac', 'Mozilla/5.0 (Linux; Android 16; Redmi Pad 2 Build/BP2A.250605.031.A3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.52.2-gn', '2026-03-31 11:09:15.433'),
('096d44d8-0d18-4ecb-a5f7-8a29a773d165', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-03-31 20:10:43.306'),
('0bb6334c-861e-44e0-8d6c-5b77ec2ea7c7', '1bb984db-c32a-432a-9106-1e88f09a2bb5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 03:51:40.427'),
('42f53fe8-64f4-496d-87ff-22c948b26314', '79e70e32-ca85-4187-802c-b4928fa56c9e', 'AdsBot-Google (+http://www.google.com/adsbot.html)', '2026-04-02 11:01:24.261'),
('8be3fe75-b612-4f29-a97a-df6e16ea57ed', '978bf32b-f1d8-408a-a590-ca64b4670618', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-02 15:43:43.068'),
('3e45f217-60bd-4cd2-b7a4-4e09ab407fa9', '4f2ad68e-935e-4c28-85f7-55ad926cc54b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1', '2026-04-02 18:57:28.76'),
('132cf8a0-a204-413a-9c31-c53dff5cf247', 'c30cc8af-a5e5-4eb7-b62c-a0597dd6c273', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1', '2026-04-06 03:11:52.914'),
('f6c40240-5f8c-4ef6-9e3f-519fcfc4e119', '4cef30a1-3218-4d15-8df8-47e811549011', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-04-06 07:55:02.301'),
('276644ad-9c8a-4b00-a037-4fb9b3f4b443', '2fee9e51-9285-419e-a75b-cb473ce206cb', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '2026-04-07 16:51:05.179'),
('a2fd5d2d-e2e9-44d2-81c1-3ea55079bd83', '2424cb40-0224-40bf-9ffc-90f107cf5837', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.3 Mobile/15E148 Safari/604.1', '2026-04-09 02:09:02.054'),
('421aed4b-7f1d-4484-9cc0-a83254b8defc', '0ce3d572-34cb-429c-b0ce-096cc08a90fe', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-11 11:46:52.246'),
('9c31d6a7-222a-4480-8a46-ee8a415ae6ca', '3ef96255-59c8-4d19-a6c2-39e430413c04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 13:25:40.65'),
('1382cc14-1d10-49b7-8b6a-a063d3abef28', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '2026-04-15 06:04:38.912'),
('5951fe55-fce1-48b4-9a22-53db7058e0e3', '48ebe759-bc9b-4da7-8ae9-75c327f5079a', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-18 02:51:34.161'),
('0b711bea-1486-43ef-8213-1566fab8c80f', '641280aa-4ebc-4ca6-84a8-5c14ac51bf6c', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-04-18 17:52:31.096'),
('79a405b5-83ff-41b5-9b6f-a3b74d6c2ef7', '5230bf6a-dff7-458b-ab9f-14aa083e6e9a', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-04-19 14:39:26.492'),
('f5b065e5-8538-4315-b39b-d7e17c3ea2b4', 'f45b385f-4a48-4579-9413-8c3fa4812dcb', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/146.0.7680.177 Safari/537.36', '2026-04-19 14:39:53.456'),
('ec19567a-c319-415c-b752-f6441cd36e2c', '4112a135-a046-42d8-8974-50fb7c6be5b5', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-04-19 14:39:54.04'),
('73008b4b-d69b-4cb4-b704-d54077001dbf', 'ac2f1584-3bd3-4085-8af7-45b7b0a0f230', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-04-19 19:41:35.787'),
('d4d16252-6ade-4796-9c22-04871f3b5e52', 'c2f3bb02-dee6-477f-a7f2-8248ca635986', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-20 01:23:23.27'),
('93b2305b-b401-4e60-a47c-a9b696e6c043', 'a7255e66-8dae-4f08-a0e8-0c7a2c14eb08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 02:13:24.66'),
('39e42969-97c2-4442-95da-eb9f44816351', '5dcbe090-a39c-4489-8791-e911e18316eb', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-04-21 12:47:35.385'),
('73184a3f-cdc6-4f8c-8a84-37203e2d7225', '4a276ff6-d65f-4df6-a64f-9f235254111b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '2026-04-22 15:28:43.938'),
('a037584a-d9a9-4007-8f3f-7d7713e29eb3', '7cbc2620-7d58-4edb-a2f5-54eb32a4d006', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 10:04:32.433'),
('177191bf-489e-4139-862f-3cac1108a24a', '02f8a0b6-c6c9-49ed-9e7a-e84115ea2031', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 05:21:14.965'),
('3838ffb0-9e3f-488b-992e-c6a1805ed08c', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-27 02:44:38.257'),
('8496d9a5-7d70-46a6-b174-0b4a194c33e1', '65178772-7b79-491f-9e4a-f7463b0c9064', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 01:46:59.403'),
('f403acab-ddfc-4ac3-ad41-154786b8bb47', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-28 01:54:16.2'),
('6e5b084f-50a0-4829-bc10-7acefb64b0fa', 'fe31c17e-8df0-49d1-a589-31a08cba9e56', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-28 01:58:00.177'),
('d5d945f2-fd30-42c5-8a2d-d85ee0aead20', '4173f63f-c03c-4186-88a6-2f6a477b76a7', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 02:11:32.321'),
('924d8a72-e75b-4174-809d-eaa83ade88ed', '873fa615-179d-4bf6-8752-ed4533bd55f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 02:43:49.083'),
('cde57007-18cd-4ed6-8158-9ebd3aad513f', 'ee3ac370-f8e1-462b-a28f-dbdd9393c42b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '2026-04-28 03:51:16.732'),
('426338b0-8255-4a5c-b8f4-e5fccdc76715', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 04:12:58.837'),
('0fea23c9-ce78-4d92-9774-388d3082e44c', '16ed285c-3ded-4400-9f49-d4de12973903', 'Mozilla/5.0 (compatible; Google-App-Companion)', '2026-09-22 07:40:56.788'),
('f8f14716-e3e1-4171-af12-5eecdd59366b', '052c82bf-f52a-4dfe-8bd3-5cbbcf4e9332', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.7.4 Mobile/15E148 Safari/604.1', '2026-04-28 05:23:42.472'),
('31eaa102-e357-4b81-b3ae-1f28313d4d76', '5239ef4f-0997-4731-bce6-617e8c6b01f0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 05:07:40.347'),
('29b63062-007e-480d-ac21-e53b33024adf', 'e5660ee1-6ace-4434-995a-398d3c453b40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 03:03:52.583'),
('13d3f8ad-e52f-42be-a8a8-7b22d5b94edd', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 04:17:40.25'),
('4aa1e4d3-a1a6-4040-890b-761dca8d7035', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '2026-04-30 06:53:14.877'),
('0fe9977c-60fe-40f8-bbaf-1bf56908b863', 'f333199a-9063-49d3-9e9f-da32ab26b173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', '2026-04-30 12:34:47.283'),
('b51dfa78-35c4-40cd-95aa-8e74e7fee10d', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '2026-04-30 19:43:40.234'),
('6f9cbd0d-9973-47de-b88e-cbb752cb9a87', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 06:03:35.356'),
('7783f008-b2f5-4bab-9f98-550f911894be', '745ebef7-c41b-43aa-bb58-2a34988618e4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', '2026-05-04 01:32:45.88'),
('e28032a3-dcb8-4c8c-903e-5b3ae95bcbea', '92ecce48-bad9-4a19-9d04-b83ea77a470b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-05-04 01:32:46.609'),
('ec801969-bf57-4d2b-b637-c2fa3e4e1156', '82889493-df2e-4219-8b77-fd0a8627dcf5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 01:34:25.925'),
('c56af87d-a400-41f4-9188-d77e2bb4ed04', '0b799dfd-f7e8-4465-b707-034b90ab2d2d', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-05-04 01:35:29.427'),
('04df537d-3752-4f31-87a4-970e72fa93f7', '1b8b01ae-06c2-470c-bbf8-dcfc9fe6a313', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-05-04 01:36:42.864'),
('fbec0978-3c97-4286-b658-e996db01e279', '29ea4d08-3fca-4ccc-b97a-b68974eea7b6', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', '2026-05-04 01:40:27.531'),
('61ad01cf-5f68-47ee-ad97-8d554813c946', '1d186eba-f3cf-4610-bfb0-e88a2b33ecc0', 'Mozilla/5.0 (Linux; Android 15; en; Infinix X6850B Build/SP1A.210812.016) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.111 HiBrowser/v2.25.12.1;lang=id;nation=ID;locale=id_ID UWS/ Mobile Safari/537.36', '2026-05-04 01:40:53.945'),
('f1210d2f-9bd6-40cd-bec1-1c62da5ebebc', '1545f18d-e76c-4ce4-a72a-f268fb9df2a3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', '2026-05-04 01:42:35.086'),
('e89e1b9f-07f2-4a84-b80a-4235a7fa826d', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-05-04 01:48:30.413'),
('149af525-9813-4e7f-bc18-0ec5e9e2aba0', 'b70cb78e-ba1c-4460-bc6c-183d343e2e67', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-05-04 02:06:16.796'),
('f9d9a452-4908-48a3-be1a-1f73df590820', 'e8b71ecb-20eb-4a16-8f76-8525bc6092d5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1', '2026-05-04 02:11:19.719'),
('91c48623-666e-466c-9614-a9de66e1ff72', 'fa38da91-55d0-401e-911e-947f8e090cc5', 'Mozilla/5.0 (Linux; Android 12; vivo 1920) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/15.0.2.1', '2026-05-04 02:18:21.064'),
('3785187a-e15f-4e85-821b-91ce7b7b4a49', 'd6e3fe69-fea1-456a-8e48-bad34599b0cf', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-05-04 02:20:44.943'),
('8232d599-13de-4c32-b414-5933056f02d1', '0f87d95d-c2c2-430a-b641-9c6419090758', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-05-04 02:39:57.423'),
('7fc1fdc4-7036-4ec4-8136-55eca7d22444', '496561b9-b9d2-414f-8cdd-8a9585bdb94e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 05:31:16.921'),
('9c92a011-5285-4390-b0f7-afd96b22b7be', '845b8855-ca54-430e-a7d6-6f5948c1e5eb', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.6312.118 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.22.1-gn', '2026-05-05 03:26:55.407'),
('dfa9bcbe-0edf-4509-acce-d44edf52d768', '4e3ba45b-ef44-47c3-bc5d-ca1d83ca7c42', 'Mozilla/5.0 (Linux; Android 11; moto g power (2022)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36 Chrome-Lighthouse', '2026-05-05 08:05:28.913'),
('669e672b-a602-43fc-b84c-a1e9374238c2', '309403aa-c248-44ff-aa18-f82f8fac2357', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Chrome-Lighthouse', '2026-05-05 08:05:30.374'),
('43dcf518-4093-47d7-8a6a-f6ea701c10d3', '5590cc7c-d9cf-470a-87cc-fe9f6c9896dc', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Safari/605.1.15', '2026-05-05 11:22:20.188'),
('a6055574-c62b-443a-8ff1-f0597a86764d', 'bbc83d38-90a9-42e5-abaf-71a79c78a4eb', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1', '2026-05-05 16:41:27.643'),
('1f5e3c01-7396-4c4d-81a8-e381bb248e05', 'e815459c-2910-4634-ba20-9c5feaad92db', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1', '2026-05-06 12:28:06.506'),
('de81e23f-b0d2-48ec-9ccc-ae5bee85898f', '598b9352-2233-42ff-92e3-8db69aa15b24', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/143.0.7499.4 Safari/537.36', '2026-05-08 21:29:10.156'),
('e0859884-b4be-4bce-9c14-c0b0b80b49fa', '798c60ed-f64d-4858-9b2c-e7a2182914c3', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-10 01:39:44.102'),
('c258335f-61ae-4d3c-9519-61de0ea167b5', 'a278e8dc-6125-4558-9e7d-ae17ef65f975', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/147.0.7727.116 Safari/537.36', '2026-05-10 01:40:11.128'),
('c6a0658d-3f69-4529-9334-62db08be50a1', '29a1f95c-fd71-460e-b4f4-d5e9342ec1ff', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-10 01:40:12.619'),
('f886a488-25d8-4957-a711-f6205d43d4ae', '76e1ba66-32b9-495f-b972-7f17f972ac02', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-10 14:29:47.093'),
('ad28b890-e588-48bc-91a3-c6e084cb3062', '66faed17-d2bf-4f26-a187-9acb600b1970', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-05-12 10:21:56.568'),
('04071b55-1497-4337-a619-6103e39f7f50', 'a738d75e-5106-44a8-8269-342898b93acd', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1', '2026-05-12 11:28:06.015'),
('68bc714f-c6ec-4559-9013-017010cee5b0', '5ca276c9-58a7-401b-875f-0d6d81c9b737', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-12 11:30:27.604'),
('82f708ee-e229-45a2-9181-2aa09b722d71', 'f7d49ce5-f007-433d-a8de-de005cca1504', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/136.0.0.0 Safari/537.36', '2026-05-12 14:33:13.289'),
('08008adf-cae6-47af-85e3-25c6793f7a3f', 'fe3f231a-0f61-4b27-9b49-bb469ce7407f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', '2026-05-13 07:07:21.042'),
('a12490ed-121d-47c9-917d-2f5faed360fd', '137834ab-f0f0-4b76-ad4b-630b3afcf13f', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-18 18:47:08.666'),
('2c76d21e-6c34-4560-83ca-06b88de6131d', '431ce852-1b87-4fce-a246-f4bfc23afd15', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-19 16:38:57.448'),
('f3e78e91-7df7-41d5-8937-3865ce9694ef', '18d15e32-92ea-447d-b636-7ea52bfa118b', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-20 13:10:48.146'),
('52f25875-bd0a-44cc-ba33-cfef52aef03a', 'c6824ce3-ba80-4e7f-8088-7f2999a6c3bd', 'Mozilla/5.0 (Linux; Android 12; Mi 10T Pro Build/SKQ1.211006.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7049.79 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.55.0-gn', '2026-05-21 02:42:35.428'),
('f8dc2b78-e995-434b-8739-059effeafa09', '9c5f23f5-483d-41aa-9baa-640065c748d5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-21 02:42:39.767'),
('46012ef8-e319-42f7-98b0-c95694a82f3e', 'ce07da6d-d51c-4e13-be1f-0785a45173fb', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', '2026-05-21 02:45:51.392'),
('49081d3d-87c7-4a22-b648-0b629044d6bd', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-21 04:28:11.629'),
('d9fd51ef-d574-4713-a7dc-ffac58bd50a9', '38066954-48c8-44b8-a7fc-f211b7fbf42d', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604.1', '2026-05-21 05:14:58.978'),
('33878348-c622-45d1-ba9d-c8ab81c686fc', '45232e0a-f38b-43f3-90cd-d004531c3725', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-21 06:17:03.625'),
('f1e4ca02-5f6d-49cd-b5c4-fae9cb7cf181', '9949a544-8816-48bd-a89b-fb58ed1ab9e7', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/148.0.7778.96 Safari/537.36', '2026-05-21 06:17:04.597'),
('ab5d75fe-a05f-48a0-98a6-19b540f88661', '9b3504eb-80d1-4968-b2b2-5c4593058203', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-22 02:18:26.736'),
('cefe132b-422a-4bc0-be0c-bebbcbc11e1b', 'edb006f3-f96f-4e67-8287-26bab8d045c8', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-22 04:58:28.08'),
('c00bd180-a48b-4014-8f21-9cf9a05c2c30', '71be093a-a805-4a42-bbef-c88ad371bb9d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', '2026-05-23 03:39:01.554'),
('7e0fe579-d05a-4870-a14c-9a9c0d911d3f', '6764c273-b7b4-44f6-a096-84000a981131', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', '2026-05-23 03:46:54.297'),
('35fb5243-97af-43a1-9138-4f8fd5b6e057', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-23 07:48:37.961'),
('b1f949be-7b8e-4c1d-bc73-393ee1715d49', '0c2d29a7-5953-4577-857f-4809ee520583', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-23 09:49:12.183'),
('a249d8b6-4d95-4f28-a199-57beb506939b', '7988e75f-9249-4ea1-a669-ea3cf88db2e2', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)', '2026-05-23 20:14:56.874'),
('fbf5e21e-d12c-4a87-936b-7cec4732574f', '14c8cf99-d07a-432d-806d-dbb79c506a69', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)', '2026-05-24 20:06:21.611'),
('415f0b1a-821e-4729-ac30-bb75a3951bfa', '5761d08c-b51e-46c2-8948-9991b86c1e48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-05-24 20:07:11.525'),
('f6a5ca4c-c053-497b-bbf2-73f5f35e8beb', '3f7ec401-7d47-49db-a007-ca79c7bf8448', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1', '2026-05-25 01:13:15.838'),
('39638db3-44d4-4049-952a-095cddff93c7', 'd5863f91-92e4-4102-bd0d-a49cbf60fbd3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-05-25 03:35:37.427'),
('52fdcdb9-82f5-4d05-9a8b-4c2d145a40a2', '14c24eb3-3494-4785-a1e0-2ccac9df28f2', 'Mozilla/5.0 (iPhone17,5; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 FireKeepers/1.7.0', '2026-05-26 09:04:44.077'),
('481af3dd-6a5f-4ef4-955b-96934ddb0de7', '69ee3959-1681-4fca-8641-1c7981635bef', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-27 14:41:50.037'),
('9ff8a1b5-036a-4fd2-9e1b-a237f5c38e9a', '5e6f9238-f99b-4b01-8dc1-ee9a7331ffd9', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/147.0.7727.116 Safari/537.36', '2026-05-31 16:02:50.094'),
('7e13e33f-4b50-4af9-9d90-939f8be34390', 'd4dc9d71-b3fb-4878-9f04-047a2a65510d', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-05-31 16:02:52.234'),
('3ee1a0ca-55d7-418b-9b4d-90bbe5228411', '75e984e2-c5b3-4ded-982c-2496e8034069', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-01 14:09:38.659'),
('a9e8edc2-dc1a-486d-935f-fb6ea1399388', '49cf0080-358f-4409-80c2-13dc51ae62e5', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-01 15:30:56.066'),
('26c62c7c-07b7-4bf8-b5e8-b23e76b75563', 'eddfa7b5-965c-40a0-9eca-f54e86f9929e', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-02 20:28:18.584'),
('27424c0d-32da-46dc-aeda-42aa9d713c7f', '223feb8c-81bd-4292-952a-66d668314851', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-03 01:42:50.852'),
('2a308a9f-1ec6-44bb-8a05-0c688781cb0c', '0b535c4b-ec3e-46d3-9c0c-1ffebe20d9cf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-06-03 03:35:10.166'),
('378b0b64-d6dd-407c-b924-e92f007e0521', '0999a7e4-d7d5-43b5-a3e9-5dea47bf0e1b', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-03 12:07:16.442'),
('12ae6e37-a90f-4013-b595-cf806a15527c', '46ac6e49-63fb-4f64-b891-d19ea1d05dd3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-06-03 18:24:39.18'),
('797964c5-6214-49d3-a37b-229e3a409554', 'c9d53cd1-7c92-4de7-97bc-7f3be41f282d', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-04 12:40:20.937'),
('500498cb-9ded-4cd4-976f-33b9c687d7fc', '5e0ed9ed-9fea-4820-a709-c5666819f601', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-04 20:06:25.408'),
('3e4e0fb2-bd75-4d18-aa43-10acac4f6a11', 'c8421f45-4842-43c7-94a0-b74172efe037', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-05 01:19:22.418'),
('7ce5c9bd-f507-4f9f-853e-74102cd02bf1', '64d40f05-b47b-478b-890a-3f399386edb6', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-05 07:00:43.912'),
('a4175902-3ea4-4cc6-94c1-017baf008efb', '979d8442-183c-4f6c-89f0-4df7faebda27', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-05 16:39:23.996'),
('182e2c3c-92aa-4c73-8009-31af35787c6f', '55321b05-4990-48da-8ab2-6666970e5c10', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-05 18:49:51.791'),
('efe2205c-6089-47a3-8105-efdcf744331e', '7825a28a-2a07-46c6-8cfe-34ecb6b6bfcd', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-06-06 09:14:53.699'),
('c3e0d291-7d02-49c0-b79a-6b2922a700a3', '39f41327-4ce8-4d07-9f2c-efc1b73c88c2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-06-06 09:14:53.792'),
('8a9e1a62-0ad0-49d8-a616-7858ee7846f8', '76959704-30ab-4085-b279-624adb04a87f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-08 07:14:46.325'),
('07622425-9510-4c61-8e92-f7b763680238', '897ef352-2b13-4aed-9395-0a61cd940bdf', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-08 07:47:11.295'),
('97a3416d-9949-4d17-b4f1-295494055bc5', '2fa89ffe-df22-4471-98e9-7e08fa9dafdb', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-06-10 01:25:23.099'),
('224c0b6e-7613-416f-9695-e56257c80b20', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-10 02:00:40.473'),
('d985fefe-d6f2-4d4b-840d-46918cb96bd9', 'a9cdd67b-ba1c-4af5-add9-a10364c22726', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-06-10 06:17:56.514'),
('4a563794-3df2-4735-877c-ac0728cd88c4', '85e19924-d61a-4713-ad60-16a05b687ef6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-06-13 02:04:18.981'),
('c37c5793-3cdb-4d82-b788-a2ea68d9d01d', '321d4eb0-e56f-49d7-81ea-e7a303aca59a', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-14 11:43:34.247'),
('d2a2e2f0-2c9e-466c-8513-9759645470c2', '717e6b36-15ed-4c5f-b0af-94ffc1c63d0f', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-14 11:44:08.954'),
('6c73c736-cb1f-4c21-bef2-d6e2f2ae1263', 'effd2fd5-7d42-44e0-9ec4-0c3be62a0d6b', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/148.0.7778.96 Safari/537.36', '2026-06-14 11:44:09.575'),
('53954995-0e3f-402d-83e1-dd442a24ebfa', 'cb4c530e-b9cc-4c1f-a335-6c3fe0c2d2cd', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/136.0.0.0 Safari/537.36 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '2026-06-14 23:30:58.499'),
('40e117dc-1155-4f8a-94df-1be77bed12ea', '58404b13-ff4b-45c7-9458-dcb3da54cb07', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/136.0.0.0 Safari/537.36', '2026-06-14 23:46:54.816'),
('7749fa31-0d55-4a94-bffb-330440c9a700', '46c9f744-1ebd-4840-925b-488294a00c84', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-15 08:23:28.37'),
('8185522a-669f-4776-9af9-afc4d6606854', '1568f140-e9a9-4d38-8e40-f465e4368b08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-17 16:12:04.129'),
('69bf2da4-7ab5-4875-84c2-3e28871a181e', '00b9b437-9b4c-4d38-93a6-8fe95c33768d', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-19 08:55:04.685'),
('ac1fc96f-7f20-463a-86bc-7cf7b82c3b4c', 'dc92f326-c6b3-47d4-8ef6-0687342f0c4e', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-06-20 21:41:41.2'),
('b84c22c3-eb80-4079-aae0-eceb7a762ead', 'ef667b87-c15a-41fa-9b77-528f383e5dc7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-06-21 15:42:01.072'),
('ffa3f8b2-8845-4e72-a4a4-d5a9704ce8c1', '1b181850-5ab3-4f6a-9220-81ee7e8e00fb', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-25 10:41:53.511'),
('ca9d4fdd-efd3-4c6b-9bb3-6f53a9f1a0bb', '632408d3-1e81-4a7e-981a-82f32ada1071', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-06-25 13:57:10.429'),
('095516cb-56b8-47e4-99be-bfbe63cc0a7a', '9244a351-ee79-4131-96dd-5a98bce7b3a4', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-26 03:50:29.312'),
('ca6ddca1-86e9-44bd-9220-a6ecf7291137', '8aa0e8e9-ca22-45fb-a1a9-59fd8026811c', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/148.0.7778.96 Safari/537.36', '2026-06-26 03:50:30.017'),
('cb100c1c-f6bf-4bfa-93da-6bc76ea4d8cd', 'da0e0bca-6669-4a84-8e33-cf88b8ac037b', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-06-26 14:25:13.616'),
('661d0df5-ca3d-42b7-a8d8-c63a66113d16', '7eed7e22-6544-4005-84b7-df0c459f1029', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-27 16:27:10.376'),
('d5e585c8-f0a9-45ec-993e-bed14216a456', '8cb50e0a-bf92-41be-8a37-5528d082aed4', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-06-30 09:29:35.464'),
('a8217033-25b6-4197-90b5-d28353e6d954', 'efb87cff-4abe-4f33-89d2-a7c715fe6eb2', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-06-30 20:07:02.172'),
('cb87227d-7322-4d1b-b22a-abb583617f31', '1fd2120e-2fac-483c-bb71-107637bf45de', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.7827.200 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-01 08:24:41.542'),
('51b1eb7b-27b9-4919-989e-ebc0cfa7b8a2', 'ea2df3cf-9aeb-4009-8274-5c0456533b46', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.7827.200 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-02 00:58:42.498'),
('a4ded378-eb29-4f62-9691-164290828121', '213d268a-2942-4089-b7dc-cda1f78a7374', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-03 03:16:34.957'),
('bc5fb32f-835f-4e61-84af-3d27c2ca35c7', '48f894dd-8cd2-48bc-94a7-04c3ea402749', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-03 07:11:07.855'),
('bad8263f-3618-4c3f-9760-5fb07a2f6415', '1d70bb42-dda8-42ad-bb74-6768cf258b59', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Safari/605.1.15', '2026-07-03 18:24:13.977'),
('6b84abfb-e21b-4442-9f47-3bb6607c84d0', '5a2190cb-ace7-43aa-adba-133ca180588f', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-04 01:04:06.811'),
('04119740-aa3e-4af0-b6da-8f288480c4c2', 'a15d86ad-5cfd-4673-91bc-0c3b9b7aa936', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-06 09:11:27.677'),
('ec35c400-7dfd-405f-b6a0-4efaaa51a834', 'c199d2cd-abfb-4ced-82f8-75300fb87cfb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.6422.60 Safari/537.36 Edge/12.246', '2026-07-07 12:24:55.163'),
('0f88a2bf-a811-4ae6-9b0b-63fd7dbef681', 'eba6537d-63f5-42bf-a999-4196e4b6a236', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-07-08 05:06:24.947'),
('af82d39c-8f6b-43db-aba4-abc8860e372c', 'e4afcb95-30d4-4bf2-bf52-15ba2b6b9554', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-07-08 15:57:39.903'),
('32c72dd4-d937-48d1-9d24-23e248deb180', '63cc34b9-446d-4004-938b-b2f28fd86cd0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-07-09 02:11:26.946'),
('0bb58e33-35fc-4885-936a-e2bed503d1b6', '8bfc6aab-2093-49c5-b060-a92af795545f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-09 04:13:05.815'),
('0b4d884b-29fe-42a0-9cc9-cdc2a528bda3', '3301f03b-85e7-4d29-964e-cf7e5493b87f', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/150.0.7871.46 Safari/537.36', '2026-07-12 04:10:52.233'),
('f8b17d2c-08ab-465a-bcb4-b482c3897f17', 'ada3309c-6540-4594-a4f9-391badde524e', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.46 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-12 04:10:53.395'),
('d09668d6-afa8-4e46-9240-ad9f9352e6c4', '4ba8a81b-8426-484e-b9b5-2bf543fa2bd8', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-12 05:50:35.104'),
('7d9e2fa2-f77f-4203-af2d-d1eff656f65c', '2fc888ad-4b95-44af-afcb-479f7b46eb56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.8412.1154 Mobile Safari/537.36', '2026-07-12 07:22:19.39'),
('d4068cf1-db07-45f1-9a8d-77c49d101200', '9c4aa737-5487-4f9b-b56a-b796e3a64540', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-13 05:33:23.169'),
('5ae97d87-2371-4ca8-a562-4ce7eabe3e9a', '9e4e7ca8-eaec-4e42-87a6-d7321459b312', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', '2026-07-13 07:13:38.35'),
('8b9648b7-4a42-42b7-90a5-3405e93bb047', 'fb6c95ee-43bd-4c60-9a68-490af64d574b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0', '2026-07-14 03:29:01.251'),
('13183fc9-7d54-45f6-8cd6-009723b18984', 'd014913e-196d-4f81-81ca-e89a6dc7bf2f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-15 03:08:46.936'),
('7c8f52fc-7c71-4707-8ff8-f7197df08902', 'a6ec5421-895b-4721-9e6f-a0713dc5be99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-07-17 01:32:39.483'),
('13a0c909-25f6-4f7f-bcca-ead08fc9cc13', 'e4f06b00-d3df-4268-8dfa-e91b95efda43', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-07-17 09:30:41.299'),
('3b44faa2-a014-4cbc-be90-048c1000dcc4', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-07-19 04:23:21.872'),
('282d1235-e5ff-4fed-8d39-f6e11774d93d', 'd23e2218-aaa1-4f45-b75a-5a0ea6837fd8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 09:00:39.098'),
('339844b9-0b0c-458d-bcba-2e4e3a98d31c', '5fc6aff7-d4e7-49cb-9b84-ca14e992f71d', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.128 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-20 23:28:19.962'),
('8d17e9b1-0147-4393-9d4c-df53127ec6a7', 'c690fa40-5988-4550-bb1c-31c525b64150', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-07-21 03:26:44.466'),
('e57e4968-9795-4bae-8697-5c4506ca8d37', 'fa91aed1-60d9-4e4c-8c62-9ffd67778de6', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1', '2026-07-21 03:36:11.152'),
('76530466-4159-44ec-9e8e-99db4b0bf775', 'a96b0e96-96c7-4541-91a1-98e4608f19a4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_16 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.2 Mobile/15E148 Safari/604.1', '2026-07-21 11:31:45.888'),
('a6fa9c78-b0ff-4297-93d3-2f3d8c2ee322', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-21 11:32:38.251'),
('598bfd1a-064d-4733-8a01-f9dd868cb31e', '8aee794c-2eba-4896-9536-29c2da2fb4ee', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1', '2026-07-22 02:59:10.826'),
('9dcbf3d8-9e33-4086-8ecb-b720d909b7c1', '23f085d3-9fe9-42be-b66b-90eece1b06f3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-22 03:02:43.174'),
('4fc7af22-1edc-4f0c-b41d-5525202948bb', '5a0af7e8-e9be-46ad-8beb-835a8dfaf7ba', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-22 23:49:46.263'),
('7975e768-37a6-446d-93bc-aa1f9921a3cb', '6caa1eb3-8e25-4b3a-85bf-ebd97fb12266', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', '2026-07-24 01:26:19.292'),
('cb7ffe79-63a5-4043-865f-6edcc27d0597', '680c9d2c-bb8e-422d-9d99-bc7195236681', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-24 14:32:38.782'),
('44660af2-e6b4-445e-ae9f-11f8c667d59d', 'b56d686d-713f-4b80-b82c-f157f7bae6d5', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/136.0.0.0 Safari/537.36 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '2026-07-25 18:04:36.362'),
('2b9f9dff-076c-40e7-9076-90401c7a9af2', '79f1d32c-1ae1-4b1d-be17-3e659647945d', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/136.0.0.0 Safari/537.36', '2026-07-25 18:21:03.563'),
('9903d9b3-ed83-4464-b151-792b5427a42e', '8a63e3b1-50a3-4563-8604-323677581478', 'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/537.36 (KHTML, like Gecko)  VivoBrowser/16.2.5.1 Chrome/131.0.6778.200 Safari/537.36', '2026-07-26 02:55:48.312'),
('9bd7459e-5f79-4909-ba8c-31e5a99d7e88', '89685f43-b554-494d-bb03-b50fd5485186', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-07-26 13:01:03.326'),
('c550ba30-e902-4211-843d-b97aadf6944e', 'ac7e4334-6930-40f5-9a23-8469558521fa', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '2026-07-27 04:15:00.83'),
('c348ad1f-cbec-434a-9db6-b908b19b1526', 'e89187cb-0513-4a0a-82d1-546f9c7da943', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-27 05:40:03.398'),
('83296ef8-ba00-4918-b3d9-32c9ed45095e', 'ec4b1e96-a580-4cbe-bceb-98d3c73fa564', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1', '2026-07-27 15:30:20.475'),
('881d5328-d89f-412c-bf2a-7d516b6aae6f', 'aac1f164-08a5-435b-97ca-16b3d0ae71fd', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2026-07-28 03:42:33.462'),
('3cdc9cbb-14a9-4591-9305-6cc85bdb2bb0', '4ba02842-b8bd-4e79-a1bc-9453de45ee92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-29 02:54:15.365'),
('32aa3ef4-7683-416e-8a1a-9bf20379fb70', 'c8d3d4b3-9a43-4640-ab4d-be3f82f85669', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '2026-07-29 11:06:50.192'),
('cbae3148-d851-4cc3-8c43-2ea96af87ede', '3a5375ef-a133-41b3-8afb-57b5f13f122a', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/150.0.7871.186 Safari/537.36', '2026-07-31 14:08:26.202'),
('d2281b28-d7ee-4a2d-947f-e88aaa954e13', '335e41e4-90c6-4d21-9891-c7ffce566e73', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-07-31 14:08:26.858'),
('4cca5ede-0d78-48fb-8440-847d496fb725', 'ff8c95e1-b083-4ffc-98fb-bb8b32817bad', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-08-01 05:52:32.56'),
('4e2be706-42f9-4548-aaef-5def98693310', '90627271-7714-43a2-b052-402229b9de1c', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_16 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.2 Mobile/15E148 Safari/604.1', '2026-08-02 22:39:29.424'),
('cd0a7e02-1b56-44c2-bdf6-16532c5215be', '614e4ef9-200c-41ca-9112-96f68496b0fb', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-03 00:32:34.212'),
('0c2ae85f-b9cb-49e2-a2cc-0e59b4ce7566', 'dbb40839-e4b9-434b-a082-1ad6f1e2bdbc', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '2026-08-03 00:32:41.383'),
('a995e2ee-0177-4613-9715-e61c6ea80ad2', 'c164ee57-1f8c-477c-a343-e3a4b873df1f', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-03 00:33:09.011'),
('4b56345a-7394-4997-9a5f-fc918ac52a00', '35ed3d9d-8d51-46ed-a601-30a48dac1a33', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-03 00:45:03.266'),
('469897c0-c5bb-4038-b770-b7ed63c0849e', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-03 01:11:02.989'),
('7d1201a3-cbda-40a9-929e-5ff1400ac5b6', '662cfff4-8aa9-4570-b096-610f3c8cc950', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-08-03 17:38:31.329'),
('dcc9bbb9-6437-4d3e-a1d6-4499975a2806', 'f3a469bc-ebd6-4e1e-9706-ec236c1fb3b5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-04 04:42:50.311'),
('15e99900-d87e-43b4-9d37-c8ad43aec7ac', '1997b8c4-0e46-4323-b3fe-420dc299118f', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-04 16:43:52.621'),
('193cfc85-6dea-47f2-ba67-4c6ef5fcea70', '00c55c0d-737c-42d6-b79d-a5e12a6825ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-05 05:18:32.824'),
('c2968ac7-58e3-4678-9738-6b447ae61197', '938eb48c-9725-4387-a8bb-def662110de8', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5.2 Mobile/15E148 Safari/604.1', '2026-08-05 05:23:04.972'),
('a63f19ee-1f09-45f6-91de-d7dd61ba4185', '89972c5f-7903-4a12-91da-caac900f9db5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2026-08-05 12:54:54.465'),
('2164d9a2-e12e-44d5-8b66-1b669bfb850b', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-05 15:29:47.889'),
('136e15d8-ee60-46cb-9b45-2a007ecf6ae4', '764f3dff-aaa4-4672-bf36-26c71df7c290', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-08-05 18:16:16.66'),
('4966b664-5d5e-4eee-9d0c-dd3ad8b0b311', '35a86bbb-9af1-4c5f-bb61-68653bd3353c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-06 00:14:58.8'),
('54b79d7e-0a49-4338-9be8-2a0ddac15441', 'bbfb8289-4569-4d33-a7e1-264e8aadd01b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '2026-08-06 02:22:21.322'),
('359995bb-c0bc-4505-aa3f-153bf84bbfbf', '67efdc58-1abb-40a9-8136-d73f19cfc9bc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-06 04:00:08.592'),
('aac378f3-6b99-4caf-9ec0-b0965555af21', '4c54ca7d-2ffd-466c-83f0-dd0a363b447d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', '2026-08-06 04:12:26.81'),
('7b0108c6-162c-423f-922e-fb91d3e9b4da', 'c58c5919-73d3-4060-968d-84a5f3b45670', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-06 05:02:23.699'),
('f550d71e-b0fb-4dc6-aecd-a44f6d93d514', '7b3c6b19-0bc6-4802-ade4-a2fe6f888e72', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-06 06:10:37.377'),
('926d142d-2713-4da0-8ba7-37d411d9d67a', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-06 06:14:08.751'),
('ab038aae-cb3e-4476-9ff7-c5a7301cf063', '99dd6433-3325-4d19-8a64-a5fc0bae6dc4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', '2026-08-06 09:04:21.317'),
('976451d8-6172-4dab-b39e-e3646e1f3d03', '6a3810e5-1974-47ba-a202-e06dfe9641d8', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-06 09:52:17.313'),
('3c5be61f-bc03-47b1-bb0c-ce4db33ab52c', '79a5fe24-e146-4319-9f67-aab5fd70b081', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', '2026-08-06 13:30:55.239'),
('83724f84-8ca6-4ecc-8e91-a463d151beec', '0819bcf2-da3e-4b59-a1c3-d83d2c427dab', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-06 22:09:56.17'),
('7c2c3892-cd07-4cd4-b77e-434334d53922', 'b04c4a01-fe59-43be-9f83-9cf9bdfbb092', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-07 00:39:00.232'),
('debefb14-c822-4a63-b743-7fd3334f572a', '5bf71bf4-1cc7-4c52-8454-5c8349b538db', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-07 07:01:30.232'),
('64550b02-31b7-40b1-914c-ea23ec4314fa', '1e81cc93-a1f3-4ff5-afe7-c7117767af8c', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-08-07 16:46:21.057'),
('bd3740d4-f23d-4890-95d7-7efece8b733c', 'cabfad5d-bf03-4df1-8715-e11829679799', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-08 08:28:26.739'),
('5c1897cc-a698-493c-9bb5-d76f3797bbaa', 'dc13c2d6-2e8d-4a56-8f12-74c47745a550', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.5253.1974 Mobile Safari/537.36', '2026-08-08 09:39:42.322'),
('c03feb4d-94d0-4146-b46f-2cc5f174d661', 'e61cd19e-3e60-4ed3-91ff-13cc8079fa95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-08 15:32:40.113'),
('bfc2ac43-72d1-4902-98c2-ba89ea38bb15', '7a0b6759-01d4-4807-91d9-146036d1cc54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-08-09 07:08:33.529'),
('7abf6a38-616c-473f-9fcb-6ab050cbd05b', 'd674ad8d-7441-45d2-abc0-cdb0966f80ea', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-08-09 09:49:33.322'),
('eb39eeb4-021b-4681-bea9-05cec3e02530', '4c0ca788-7767-4149-aea4-cde6376b0abd', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-10 09:06:16.527'),
('2927b9b5-8830-4ff3-9b73-171aaf4d6b1f', '72c57eea-b6d8-4ead-9374-6ed3d3ac53dd', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-11 00:54:40.291'),
('39bfa865-1ad4-4278-a3d0-61f1e0c3a8d8', '26023b92-50df-47cc-bcc2-aaeb0292a3ea', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-11 05:38:45.71'),
('3d0f6c97-4d95-46c8-8257-ca6955871879', '95711971-abf8-4546-ac6d-745af4e67d2e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', '2026-08-11 10:19:45.189'),
('075de708-2893-4696-9097-1cf607f11313', '2ef6cead-44a0-49e2-9294-3b7855c95eac', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5.2 Mobile/15E148 Safari/604.1', '2026-08-11 13:13:09.106'),
('312d46fc-8750-4815-b642-e0db2dfb6899', 'fc8a7b88-68db-4fa9-966b-437ac4e0c30e', 'Mozilla/5.0 (Linux; Android 8.1.0; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36 PTST/260802.202201', '2026-08-11 14:59:40.455'),
('84dae8fb-6f34-47b3-b734-8f253df66fc1', 'cae7da7f-d2b1-4078-9c60-5cf172424dbb', 'Mozilla/5.0 (Linux; Android 8.1.0; Moto G (4)) AppleWebKit/537.36 (KHTML like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36 PTST/260802.202201', '2026-08-11 15:03:26.877'),
('b7b73e0b-6c6a-454c-83e7-24dcf4a6d331', '05eb77d4-7772-4d63-967a-614b5221898c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-12 01:33:42.635'),
('3da8ab80-0f95-4707-ad01-840796c05bd8', '31825993-6fa9-46f6-9bc7-3d9d316fa995', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-12 09:07:28.516'),
('c883d129-7536-4cb8-9c28-07083d63fbf5', '6d2013b1-6b5a-48a7-840a-63a220149897', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.4662.1782 Mobile Safari/537.36', '2026-08-12 09:55:30.028'),
('4663904a-270a-4859-9a55-8df1e959d692', '5704277c-fdfb-478a-9b3e-28e2bbf7b1be', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-08-14 19:52:28.25'),
('d0650e1c-5511-4905-9d06-e7e6121f5f05', '01ab0122-5c1b-4267-8aff-bc46776faa99', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-08-15 05:00:28.468'),
('de6b9f18-826e-4f4e-b4ef-81299187d237', '30a530d6-fd53-414b-82df-75ce95c3362e', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.7871.186 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-17 09:51:14.306'),
('abf61a5b-fac9-4d14-8073-f18d316175fb', '8396e71e-098f-4876-8237-06b3a10dfc7b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.7.2 Mobile/15E148 Safari/604.1', '2026-08-18 18:59:59.082'),
('b37be58f-430b-4342-b445-b0fefc78703d', 'a0c0c069-52e6-4ec2-941d-da4fb28b6d6a', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6 Safari/605.1.15', '2026-08-18 21:15:37.383'),
('27b16b24-5d5d-4c6c-847c-8b371ece4c44', '0e404fd3-9a72-40a1-877b-97efae74db2f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 02:11:34.298'),
('f3f65367-b270-4fe6-914a-602e2070a933', '8c48757f-d520-4546-a3c6-4cc01832bfb3', 'Mozilla/5.0 (Linux; U; Android 15; en-id; CPH2591 Build/AP3A.240617.008) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.5970.168 Mobile Safari/537.36 HeyTapBrowser/45.14.5.1', '2026-08-19 12:51:01.66'),
('a1ed3144-7d65-4955-aff0-d9044de8bef1', 'ef90e038-c09d-402f-b763-dec969697be8', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; https://zhanzhang.toutiao.com/)', '2026-08-19 19:16:44.772'),
('7ba65d86-7983-4eac-ae6d-08c0ce8dbed8', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-19 19:45:16.491'),
('8bc1f73b-3301-4ef2-830e-d59e16c2392f', 'b5ba8873-05c1-4bcb-a2dc-db472140fa17', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-08-19 23:09:25.043'),
('2aada69a-9ed9-4593-8767-04c80e84a2b7', '7d5070e8-90f6-4bf2-a393-67c148feec2e', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-19 23:13:34.764'),
('b6467bc2-bb00-4dd0-97a9-43acd07e9c99', '8aa98fcb-9d3e-48d1-a39a-13e760c5cb3d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Mobile Safari/537.36', '2026-08-19 23:15:03.587'),
('073737ed-df62-42e9-a993-41c5424bf1d4', 'c77974b5-289d-4481-a7f7-8b95d70586dd', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 23:17:00.965'),
('2784f273-dcba-422c-89f9-d87f9c606c4d', 'beaeef52-b1e9-46e6-b9f6-e8dd1b0df570', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 23:19:03.533'),
('f1ab3cce-4938-46f8-b5f1-a2fcfd0c6757', 'e3b8b79e-b4b5-4540-808c-96fd75e547a1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 23:19:53.551'),
('e21dce53-3223-43b9-bc0b-fe9dd8332a43', '08a1b9d3-9bb2-48fe-a9cf-60a17921d8d9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 23:33:16.996'),
('fb67e9ba-e7d7-4449-a59e-2b11ce7c7694', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-19 23:47:21.331'),
('70bc1eb8-e863-46d5-9771-cdb222eb39be', '4fad2e72-4073-43a3-9aa2-a2dab8561382', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-20 00:10:33.385'),
('18c0cc2f-f9f4-4cf5-8f19-c339a8349108', '146ca0a5-befb-483a-8522-daa8a61209db', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-20 00:11:26.847'),
('179accc2-2a8e-4e1d-959d-0a1f109e755a', '1899f0f7-0bc9-4b18-ab99-b7465aa75aec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-08-20 01:34:44.783'),
('7851e31f-8de5-4984-b314-a89f2cfbc34b', '467c688b-22e1-46ba-990a-011c16aa91a9', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-21 12:08:04.574'),
('b9ee48d4-9193-47f5-a8e9-62d22d6ddbc9', 'cc611959-2b5c-4625-9308-c1df0a488430', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-22 09:24:39.495'),
('d4abc8cc-019a-4f22-b0b9-475bafed9449', 'ac5f98a1-ee95-412c-9013-844e098ebbf3', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/151.0.7922.108 Safari/537.36', '2026-08-22 19:05:01.11'),
('d8413dc0-cfcb-4572-862d-6d69088cab11', '3107d7fd-784b-40d3-9d29-fc2e795caacf', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.108 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-22 19:05:01.801'),
('65a3a6f4-e6ae-40ff-be38-77759b28c828', '95003ce1-37d7-4886-8929-386657f3c5f3', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-24 06:35:14.124'),
('8422ba12-60d6-4427-a4a5-b4e8b6645bf9', '4ade0100-a6a2-4035-89a6-4f9aaf219f9b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-24 09:50:48.051'),
('026092e9-0ae5-4e9d-a190-aa85e21b1997', '8dcf1eed-612f-4636-8bb6-0cc204f3c4b4', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-24 15:32:16.629'),
('114de920-76c0-4a32-8226-c494539e6794', '03224d60-6f5a-4eff-b161-a3d91d026677', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-25 15:44:58.903'),
('bf07bf26-98b9-48c4-b51e-fd13e93c8dac', '5e49c99a-4090-4e10-b09c-030317775d05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', '2026-08-26 02:08:10.334'),
('19ad55fb-623f-4dbc-9935-bc4366195bce', 'aa7ca2ca-388d-4758-8b4e-0b548f82a382', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-26 06:09:37.715'),
('e045632e-ed62-4bd4-b8a4-a443808a934d', '8afd0116-7a41-4c73-820b-129cafcc3a73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-26 09:35:04.424'),
('47cc829d-e874-4945-ae78-a78c3f6b2b2b', 'e74e1f84-d766-4d3b-9d05-60138547040a', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-26 14:31:29.61'),
('b4d718d8-9e7e-49a3-826b-db2e520ed097', 'b5fa8ca5-e18a-4e46-bdbc-23b2d54b1461', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-26 18:26:40.931'),
('ae1cae23-78c7-4115-93d4-61d3e435af53', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-27 03:00:44.531'),
('1d691d51-231d-4d4a-93b7-ba6ce2eb7395', '1f77e496-1fa2-44e0-84f8-fe2b409cbe73', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-27 03:01:23.44'),
('16515e18-39d2-482b-b1b3-d1985c42e5f9', '621ff57d-435d-46f1-9e64-a23ecb6bdcc1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '2026-08-27 03:05:44.578'),
('ffc84ef7-71fd-4f39-ad6d-9116879904c4', 'b5f9df09-c144-4787-9d68-193abb6e1d7f', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-08-27 07:58:12.409'),
('a5bb2e1a-8e62-484d-9320-9ac26f566db7', '3b3c4378-f670-4b8e-87d9-9cb86a14cbd0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-08-27 10:04:01.175'),
('1c366299-777f-4c45-b157-e74d340640d1', 'd736fb46-40b4-4802-8b7e-b5cdffbc073e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-27 12:09:05.742'),
('6e772fbd-b6a7-47a3-936c-34a9f7bb69ad', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-30 09:55:29.468'),
('063c37d7-6507-4121-b257-07cf333d87fa', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-08-31 01:54:08.757'),
('6aec36a6-7c6b-454f-97fb-883435a3ded1', '24c2d018-ac5c-47ea-a97b-2c6f4246c980', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-31 02:06:16.723'),
('7883b680-f5f5-485d-ac70-a64fc190aa47', '7bf9ac75-9b35-4e32-bb08-97c88d4d82b6', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-08-31 02:31:09.808'),
('915ee6d9-130b-434f-9f68-597af3e2130f', '34d1deec-fed3-46ec-80f6-bbeeddb71ff4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-08-31 07:23:55.383'),
('49388791-5fdd-4058-ae10-d2e7f252352b', '00f4dae0-9765-41fa-a5ea-68b6b6c358a7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', '2026-09-01 00:32:25.632'),
('70042800-e1a6-4d26-a713-0205b6955cde', '511de449-f3ae-4f3e-935a-7dbe9fc678e0', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)', '2026-09-01 11:54:35.217'),
('79c1d341-082f-4d13-8d19-bb9fba5eddaf', 'ba76689a-4adb-4795-be1d-e71d0c118c08', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', '2026-09-03 01:22:21.931'),
('bc562474-72b3-40e2-9547-b6333bc79377', '88217ff2-45b6-43d2-b2c2-a6735b3572f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-03 13:17:29.948'),
('1714f0f5-846a-49a5-95dd-a93d72982625', '212c3397-bf8d-43e0-8926-451e5cc39f91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-03 13:17:29.948'),
('d678452e-f29f-45e5-8fa6-6fd41ee9ab26', '44fc2ce5-4f89-4362-ab22-53416285dca6', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-09-03 19:21:34.325'),
('59dcc77c-6f9c-4803-ae55-c4302c144c3e', 'f33c2f38-9fda-4873-a61d-7c81b46d3306', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-04 13:34:12.987'),
('f3569091-f86b-49a2-ac27-fc1edaca192d', 'ac4a2b56-2ac3-4d15-b2c7-1332d6be10ad', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.64 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-04 13:35:53.16'),
('fe4c666b-e15d-4728-b92e-b2aaf40544da', '9e5623a4-197e-4ec7-8381-9d7530aafb93', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/151.0.7922.173 Safari/537.36', '2026-09-04 13:35:53.794'),
('cf044d37-abb3-4a37-9cff-30935cd8c048', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-07 01:51:05.837'),
('b8cd77b7-aceb-495f-953a-3605ebe2f38c', '8e025f8a-1d80-4d59-81d9-78da5a8dbcb3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Mobile/15E148 Safari/604.1', '2026-09-07 07:45:46.149'),
('8137f202-fdf4-49de-8f75-973581b2136f', '1336a300-7acb-4d26-844c-b1bd983cc257', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', '2026-09-07 12:22:04.251'),
('5eaea46e-8f43-4ebe-b944-f1da43cbea3f', 'c3790f9d-4497-4d54-9ad6-f4a9995b7a77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-07 23:20:15.029'),
('ed6ca0c9-b49b-4898-b790-71010c46f821', 'fa9fc867-bb83-4568-8f4a-099680ca1cca', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-08 01:18:11.65'),
('816ffe76-359f-4f0e-8573-624cff2ea168', '449b8319-d723-4c1d-a39e-9497007072e7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.1 Mobile/15E148 Safari/604.1', '2026-09-08 10:43:34.769'),
('1c6ec42d-b02f-4348-aa06-c54f3760b4a7', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-09-09 01:50:27.155'),
('be0eaf29-4e3b-4d46-a139-5bd63f18aebe', '212a7a72-f02f-4909-94af-18ca386b14bd', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '2026-09-09 01:50:47.362'),
('d2cbdee4-8d84-45ac-adcb-8af76dec00b6', 'e5acf53a-28c8-4af8-8663-fb6d319bcde0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', '2026-09-09 07:42:10.688'),
('b11c6755-2dbf-49a1-a5eb-66e8ebe99219', 'b1393b8c-50b6-4dcf-bb25-bcdf1ad6c9ec', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.7922.173 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-09 07:43:30.757'),
('05f3493a-d5f8-457e-a707-62a0f255f7a3', 'dbf55474-c719-47c0-ae75-b21f3951ff90', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-09 09:07:54.144'),
('46a7aeb9-21d7-4322-b3b6-bf4465ba3fcf', '91d01b1a-6837-4cc4-b03e-9fa7ab79eef5', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-09-09 09:13:59.183'),
('dc4665d2-61c6-4059-a92b-46669cbf29cf', '6a6261bc-2e6e-4ae8-8ebe-30c038067de6', 'Mozilla/5.0 (Linux; Android 14; Pixel 8 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', '2026-09-09 13:19:55.214'),
('9fabf175-ca1d-4cce-9e5f-7115a8277da2', 'c03e66e2-7348-4100-85ce-5b7854ed6d96', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 PTST/260802.202201', '2026-09-10 16:27:53.78'),
('e2d9ad9d-7fb2-4c8c-a4e9-d00d76ec5797', '1425ed61-5626-4c53-b661-028c5a2298ec', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML like Gecko) Chrome/153.0.0.0 Safari/537.36 PTST/260802.202201', '2026-09-10 16:29:20.547'),
('223a3a66-989e-4cdf-acbc-a1ae75a8d32d', '85781ed5-8110-44c2-aefa-905fca22b635', 'Mozilla/5.0 (Linux; Android 8.1.0; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36 PTST/260802.202201', '2026-09-11 10:03:50.487'),
('1acfd227-85dc-4cf7-87c2-8b72368a6622', '673581ca-8e02-47ba-9541-9eeb6716ff09', 'Mozilla/5.0 (Linux; Android 8.1.0; Moto G (4)) AppleWebKit/537.36 (KHTML like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36 PTST/260802.202201', '2026-09-11 10:06:32.332'),
('e4aa7b87-3211-44ac-9328-f070bde44349', '41867026-b5f3-4b92-ad7d-2836090e9b5e', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.36 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-11 22:56:08.682'),
('37f6e254-79e3-4610-983d-51cc5f620648', '96f2d13a-5c8d-4d74-a2f3-6082bc8805b1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-12 13:08:29.008'),
('13ad8f5f-46d0-45ed-a442-13c1dfc36630', '4c0d65fe-68ce-4132-9524-feddd45e4756', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-12 20:12:25.977'),
('28b2075b-91a1-4427-b1c5-f39dd410b95f', '3af85923-da43-44a5-ade6-eccd69c76bd1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', '2026-09-12 20:14:17.609'),
('11b59748-8454-4fcd-93a6-0e7f0770c4c6', 'e2c409c0-6582-4a88-92be-4b4437390fc5', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-13 23:29:12.336'),
('135f1489-eb15-4ec7-a757-86f620cd1e3f', '38832c03-6fe3-4f59-bed2-eaa24a478625', 'Mozilla/5.0 (iPad; CPU OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', '2026-09-14 07:09:14.519'),
('bd1e685f-300c-45fd-85d3-6debdeb9007d', '7f6401ef-778b-4c48-9fb7-1f38a2a71094', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.82 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-14 21:52:19.712'),
('49de6e43-ce5d-4bfc-8cdc-977e09699e89', 'dfc6948e-e14e-4222-9cf4-80d343a03a5e', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-15 06:54:56.624'),
('0587a0c9-0369-49aa-8ad0-242c54fac962', '144e7acb-776a-453e-a70a-7acab7ad7d3c', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/152.0.7977.64 Safari/537.36', '2026-09-16 00:54:37.723'),
('5f017bbb-3112-4186-a0f1-992d807e92b7', 'ae35b62a-9e52-4f4a-8400-5d2874b61b4d', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.7977.64 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-16 00:54:38.781'),
('4c69de0b-cb1b-4e06-ad99-b117a7731658', '216e4923-0a3b-4332-8653-68e86b7e2895', 'Mozilla/5.0 (iPad; CPU OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', '2026-09-16 05:04:30.809'),
('f089b707-5fda-4e0a-9413-88e1016ad54c', '4f4bfd81-df48-46f1-ada9-9c1e1ab38904', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-09-16 05:53:16.818'),
('2dc93a9a-4c03-4513-b497-c19c0d2d934f', '054267f3-fd83-44cc-a6f8-7f1405052931', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', '2026-09-16 06:35:44.378'),
('ab533bbb-556c-4257-b79f-671c4c36f6ad', '3f2d4218-4dbf-4695-88e3-e481609992f7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Mobile/15E148 Safari/604.1', '2026-09-17 03:30:52.492'),
('02893056-f072-4a88-b509-dc03eeaf309d', 'fbb826ae-4f12-4d33-87ea-45f1e2b152a2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-09-18 21:52:56.033'),
('dd943516-7bd6-4c04-ba35-a74213b53eb6', 'e80db049-a776-45ba-86e3-6f106b5b41b7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 (compatible; meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler))', '2026-09-19 08:44:41.466'),
('154980b4-7d54-45f4-858c-565e168d6af2', '3888b088-dbfe-42de-a080-5a6d0d0425ef', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.8010.47 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '2026-09-21 07:55:53.297'),
('c0dad9c0-4c86-45d9-9d2a-5af20babdad3', '0e404b63-52d7-4e69-9271-04e0f4fe27b5', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:155.0) Gecko/20100101 Firefox/155.0', '2026-09-22 02:54:58.154'),
('bd1436f2-1a1a-4ee6-befc-e242fc7f089a', 'a2c66a28-012b-410b-8798-5ba0fab23ec9', 'Mozilla/5.0 (compatible; Google-App-Companion)', '2026-09-22 02:56:01.024'),
('756b826a-7d4f-4570-9023-8558d145e567', '0e320dec-88bb-44ff-8203-444199f8c85c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-22 08:36:55.121'),
('8ae8538c-e4c7-4373-a892-97cd13f107be', '76c6ae9d-6977-457e-9535-3a813f88ad59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-22 12:46:13.075'),
('29fd6119-7119-4b3b-bf6e-928d8b8c2483', '636db11a-9f69-4680-9c50-9a1021635686', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', '2026-09-24 00:16:34.029'),
('be3bd796-e94b-4dd7-88be-448ed2942c9b', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-24 01:41:33.559'),
('b90be9ca-ec45-4410-a8c7-a253a29780c7', '305ccb17-e6e0-49be-a5d9-606fe68b8abd', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', '2026-09-25 01:36:06.725'),
('ae3bee54-de27-4027-b80b-992c3d40b2e3', 'd3a0d5e4-47e3-443a-9156-5db68f73718f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-25 16:01:06.128'),
('c8394f48-c7d7-4529-b963-28b39e1a894a', '060d6a84-cfdd-45d6-b671-654b682791e9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-28 02:02:44.457');

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('66c06587-f5e5-4b67-b36f-fc08e3d3b5e6', '312231a17a4c011ffa4ace63a602a076208d12e93888bf238efff616c6716c26', '2026-03-11 07:33:50.256203+00', '20260116142817_init', NULL, NULL, '2026-03-11 07:33:50.101136+00', '1'),
('f39c2dff-6158-42f0-a811-6d734ad94dfd', '40dda655824d09ce5d6487a029b5851e227173416583de4c277763bceb236f00', '2026-03-11 07:33:50.266172+00', '20260302073431_init', NULL, NULL, '2026-03-11 07:33:50.25826+00', '1'),
('cb6a09d9-4c18-4904-bd2c-ded6944731a8', 'cfd20d760b0b98fb04090ee3ffec668d81a922204aeb64be19ad955fd8e77cdb', '2026-03-11 07:33:50.288123+00', '20260305100852_init', NULL, NULL, '2026-03-11 07:33:50.268306+00', '1'),
('3a957543-e8dd-465a-8b99-5777b0ce2507', '1631f0f1814517bc8a49334c981271e8dfc87ce6a780aaf4f680a6170545c848', '2026-03-11 07:33:50.299839+00', '20260305125310_add_unique_to_username', NULL, NULL, '2026-03-11 07:33:50.290206+00', '1'),
('211e730b-e861-4c33-8f61-32385f3e6ace', '964640d0bacb95c96b74eeadd8a8dac47220b81b4ceb764d8d82c8b250c15b49', '2026-03-14 17:41:04.699076+00', '20260305160411_init', NULL, NULL, '2026-03-14 17:41:04.632736+00', '1');

INSERT INTO `desaWisata` (`id`, `namaDesa_id`, `namaDesa_en`, `deskripsi_id`, `deskripsi_en`, `lokasi_id`, `lokasi_en`, `foto`, `longitude`, `latitude`, `jenisDesa`, `link_video`) VALUES
('9', 'Desa Wisata Bone Baru', 'New Bone Tourism Village', '"Desa Wisata Bone Baru merupakan salah satu Desa di Kecamatan Banggai  Utara Kabupaten Banggai Laut yang mempunyai luas wilayah mencapai 8,44 Km2. Dengan jumlah penduduk Desa Bone Baru sebanyak 1.069 Jiwa. Desa Bone Baru merupakan salah satu  Desa dari 6 (Enam) Desa yang ada di kecamatan Banggai Utara Kabupaten Banggai Laut, Desa Bone Baru berada pada ketinggian ± 165 dpl dan curah hujan ± 200 mm, rata-rata suhu udara 28º - 32º celcius.
Desa Wisata Bone Baru menawarkan berbagai Destinasi Wisata menarik khususnya Wisata Under Water. Spot Snorkeling dan Diving yang memiliki beranekaragam jenis karang menjadi ekosistem beragam jenis ikan yang sangat indah. salah satunya Ikan Endemik Laut Banggai yaitu Banggai Cardinal Fish (BCF). selain itu, Desa Bone Baru juga memiliki ekosistem Mangrove."', 'Relying on marine tourism and coastal community activities.  Also included in the category of developing tourist village in Jadesta.', 'Desa Bone Baru, Kab. Banggai Laut', 'New Bone Village, Kab.  Banggai Laut', '/uploads/1774944086313.webp', '123.4800', '-1.6200', 'DESA_WISATA', ''),
('15', 'Desa Wisata  Pokekea', 'Pokekea Tourist Village', 'Desa Wisata Pokekea memiliki keunggulan yang komplet karena menawarkan panorama alam yang menakjubkan dengan keberagaman flora dan fauna yang dilindungi, dan dibalut dengan misteri peradapan masa lampau yang sampai saat ini belum diketahui asal usulnya. Semua terbukti dengan keberadaan situs megalit pokekea dengan tebaran megalitikum terbesar di Asia Tenggara.
Situs megalit pokekea, situs megalit ntowera, situs megalit tundu wanua, situs megalit wineki, situs megalit hadoa, dan situs wanua rano menjadi rekomendasi unggulan di desa wisata pokekea karena menyimpan misteri peradaban masa lampau yang mempesona.', 'Pokekea Tourist Village has complete advantages because it offers a stunning natural panorama with a diversity of protected flora and fauna, and is wrapped in the mystery of past civilizations whose origins are currently unknown.  This is all proven by the existence of the Pokekea megalith site with the largest distribution of megaliths in Southeast Asia.
 "The Pokekea megalith site, the Ntowera megalith site, the Tundu Wanua megalith site, the Wineki megalith site, the Hadoa megalith site and the Wanua Rano site are top recommendations in the Pokekea tourist village because they hold the fascinating mystery of past civilizations."', 'Desa Hanggira, Kec. Lore Tengah, Kab. Poso', 'Hanggira Village, District.  Central Lore, Kab.  Poso', '/uploads/1774988597218.jpg', '120.3500', '-1.4500', 'DESA_WISATA', ''),
('13', 'Desa Wisata Labuan Belanda', 'Dutch Labuan Tourism Village', 'Tojo Una una Labuan Belanda 
Desa labuan adalah salah satu Desa di wilayah kecamatan Ratolindo, Kab.  Tojo Una-Una, sulawesi Tengah dengan jarak tempuh yang cukup dekat dari ibukota Kabupaten yaitu sekitar 7 Km dan dapat di akses dengan menggunakan kenderaan Roda 4. Desa labuan dengan luas 4,3 Km2 dengan jumlah penduduk 2.677 jiwa dari multi etnis diantaranya adalah suku bajo yang memiliki rumah diatas laut. Selain itu desa labuan juga menawarkan tempat menginap berupa Cottage dan Homestay bagi pengunjung yang berwisata ke desa labuan. Desa Labuan Mempunyai banyak Obyek daya tarik Wisata yang wajib dikunjungi oleh wisatawan seperti : Pantai Marina Cottage dapat Menikmati Sunset yang indah, Perumahan Kampung Bajo yang berdiri diatas laut, Tanjung Lawaka yang mempunyai air laut berwarna Hijau Tosca dan Tanjung Api, gas alam yang keluar secara alami dengan menggali sekitar 5 - 10 cm maka akan keluar Gas alam dan api.', 'Beach tourism with nuances of local history and culture, suitable for relaxing tourism and cultural exploration of coastal communities.', 'Desa Labuan, Kec. Ratolindo, Kab. Tojo Una-Una', 'Labuan Village, District.  Ratolindo, Kab.  Tojo Una Una', '/uploads/1774943231628.jpg', '121.6100', '-0.8800', 'DESA_WISATA', ''),
('32', 'KAWASAN KEPULAUAN TOGEAN', 'TOGEAN ISLANDS AREA', '🌊 Kepulauan Togean merupakan gugusan pulau tropis yang terletak di wilayah Kabupaten Tojo Una-Una dan termasuk dalam kawasan konservasi Taman Nasional Kepulauan Togean 🌏 yang dikenal sebagai salah satu surga bahari Indonesia dengan keindahan laut yang masih alami, keanekaragaman hayati laut yang sangat tinggi 🐠 serta ekosistem terumbu karang yang unik karena berada di pertemuan beberapa zona biogeografi penting 🌿; kawasan ini memiliki berbagai destinasi unggulan ✨ seperti Pulau Papan , Pulau Kadidiri, Pulau Malenge , Danau Ubur-Ubur/Mariona Lake di Pulau Una-Una, Pulau Una-Una, Pulau Batudaka, serta berbagai spot diving dan snorkeling kelas dunia ✨ yang menawarkan pengalaman wisata bahari, penelitian, dan edukasi lingkungan 🌊; selain itu, kawasan ini juga dihuni oleh masyarakat lokal seperti suku Bajo yang hidup berdampingan dengan laut 🛶 dan menjaga tradisi serta kearifan lokal, sehingga pengembangan Kepulauan Togean diarahkan pada konsep ekowisata berkelanjutan 🌱 yang mengedepankan pelestarian lingkungan, pemberdayaan masyarakat, serta promosi potensi wisata bahari ke tingkat nasional dan internasional 🌍✨', '🌊 The Togean Islands are a group of tropical islands located in the Tojo Una-Una Regency area and are included in the conservation area of ​​the Togean Islands National Park 🌏 which is known as one of Indonesia\'s maritime paradises with unspoiled sea beauty, very high marine biodiversity 🐠 and a unique coral reef ecosystem because it is located at the confluence of several important biogeographic zones 🌿;  This area has various superior destinations ✨ such as Papan Island, Kadidiri Island, Malenge Island, Jellyfish Lake/Mariona Lake on Una-Una Island, Una-Una Island, Batudaka Island, as well as various world-class diving and snorkeling spots ✨ which offer marine tourism experiences, research and environmental education 🌊;  Apart from that, this area is also inhabited by local communities such as the Bajo tribe who live side by side with the sea 🛶 and maintain local traditions and wisdom, so that the development of the Togean Islands is directed at the concept of sustainable ecotourism 🌱 which prioritizes environmental preservation, community empowerment, and promotion of marine tourism potential to the national and international levels 🌍✨', 'Kabupaten Tojo Una Una', 'Tojo Una Una Regency', '/uploads/1777347000472.jpg', '121.924556', '-0.398157', 'DESA_UNGGULAN', ''),
('28', 'Desa Wisata Bente', 'Bente Tourism Village', 'Desa Wisata Bente merujuk pada Desa Bente di Kecamatan Bungku Tengah, Kabupaten Morowali, Sulawesi Tengah, yang kini mengembangkan destinasi wisata alam yaitu Air Terjun Pofua\'a Bente. Air terjun ini adalah surga tersembunyi yang baru-baru ini diresmikan sebagai destinasi wisata oleh Gubernur Sulawesi Tengah, Anwar Hafid, pada April 2025, dan dianggap sebagai permata wisata alam yang potensial untuk menggerakkan ekonomi lokal. Pengembangan Desa Bente sejalan dengan program Pemerintah Provinsi Sulawesi Tengah yaitu "1.000 Desa Wisata" (1.000 Dewi).', 'Tourist village with natural potential and rural community life.', 'Desa Bente, Kab. Morowali', 'Bente Village, Kab.  Morowali', '/uploads/1775533381198.jpg', '121.6500', '-2.7500', 'DESA_WISATA', ''),
('23', 'Desa Wisata Luk Panenteng', 'Luk Panenteng Tourism Village', 'Banggai Kepulauan Luk Panenteng 
Desa Wisata Luk Panenteng adalah desa yang terletak di Kecamatan Bulagi Utara, Kabupaten Banggai Kepulauan, Provinsi Sulawesi Tengah. Desa yg terletak di wilayah kepulauan membuat desa ini menjadi suatu destinasi favorit untuk pecinta wisata bahari, tidak hanya pantai, dajg pemandangan bawah laut yang indah, tetapi juga danau yang memiliki air yang begitu jernih sehingga dasar danau yg dalamnya belasan meter dapat terlihat dengan begitu jelas.
Begitupun budaya setempat yang masih melekat kuat yang dapat terlihat dari kehidupan sehari hari masyaraktnya, yang masih diterapkan secara tradisional dalam hal, mata lencaharian dan keupacaraan adat lainnya, serta seni musik  dan tari-tarian, yang masih sering di gelar pada kegiatan2 perayaan di desa. Wisatawan pun dapat ikut serta menikmati serta berpengalaman melakukan kegiatan keseharian bersama masyarakat, dalam hal bertani, menangkap ikan, dan lain-lain, yg semuanya itu masih dilakukan secara tradisional. Sehingga membuat pengalaman berwisata di desa lukpanenteng sangat berkesan dan rasa ingin kembali tetap ada.', 'Proud of the Luk Panenteng Islands 
 Luk Panenteng Tourism Village is a village located in North Bulagi District, Banggai Islands Regency, Central Sulawesi Province.  The village is located in an archipelagic area, making this village a favorite destination for marine tourism lovers, not only the beach, and beautiful underwater views, but also the lake which has water so clear that the bottom of the lake which is dozens of meters deep can be seen very clearly.
 Likewise, the local culture is still strongly embedded which can be seen from the daily life of the people, which is still implemented traditionally in terms of livelihoods and other traditional ceremonies, as well as the arts of music and dance, which are still often performed at celebration activities in the village.  Tourists can also enjoy and experience carrying out daily activities with the community, in terms of farming, fishing, etc., all of which are still done traditionally.  This makes the experience of traveling to Lukpanenteng village very memorable and the feeling of wanting to return remains.', 'Desa Luk Panenteng, Kec. Bulagi Utara, Kab. Banggai Kepulauan', 'Luk Panenteng Village, District.  North Bulagi, Kab.  Banggai Islands', '/uploads/1775528789816.jpeg', '123.1200', '-1.2500', 'DESA_WISATA', ''),
('16', 'Desa Wisata Towale', 'Towale Tourism Village', 'Desa Towale atau biasa dikenal dengan Desa Pusat Laut adalah salah satu Desa yang masuk di Kecamatan Banawa Tengah, Kabupaten Donggala, Sulawesi Tengah. Dan Desa ini bisa di tempuh dengan jarak sekitar 45 menit dari Kota Palu, Ibu Kota Provinsi Sulawesi Tengah. Desa ini menawarkan keindahan bawah laut dan keindahan pantai dengan hamparan pasir putih juga menawarkan kearifan lokal masyarakat, dimana mereka hampir sebagian besar bekerja dengan menenun sarung Donggala atau biasa di kenal dengan Buya Sabe atau Batik Bomba. Daya tarik wisatawan mengunjungi Desa Towale adalah keberadaan satu sumur yang di beri nama pusat laut atau dalam bahasa Kaili sebut puse ntasi, sumur ini berdiameter 10 meter dengan kedalaman 7 meter yang merupakan sumur terbesar di dunia. Ini merupakan salah satu keunikan tersendiri dari Desa Towale.', 'Has the potential for beach tourism and coastal community culture.', 'Desa Towale, Kec. Banawa Tengah, Kab. Donggala', 'Towale Village, District.  Central Banawa, Kab.  Donggala', '/uploads/1774988935341.jpg', '119.8000', '-0.9500', 'DESA_WISATA', ''),
('35', 'KAWASAN BANGGAI BERSAUDARA (BANGGAI)', 'BANGGAI BERSAUDARA (BANGGAI) AREA', '🏝️ Pulau Dua merupakan salah satu destinasi wisata bahari unggulan yang terletak di wilayah Kabupaten Banggai 🌏 yang dikenal dengan keindahan alamnya yang masih alami, pasir putih yang bersih 🤍 serta air laut yang jernih berwarna biru toska 🌊 sehingga sangat cocok untuk kegiatan wisata seperti berenang, snorkeling, hingga rekreasi keluarga; secara administratif, Pulau Dua berada di kawasan pesisir Kecamatan Balantak ✨ dan dapat diakses menggunakan perahu dari desa-desa pesisir terdekat dengan waktu tempuh relatif singkat 🚤; daya tarik utama pulau ini terletak pada lanskap dua pulau kecil yang saling berdekatan (sesuai namanya “Pulau Dua”) dengan panorama laut terbuka yang memukau 🌅 serta ekosistem bawah laut yang masih terjaga 🐠, menjadikannya lokasi potensial untuk pengembangan ekowisata bahari 🌿; selain itu, suasana yang tenang dan belum terlalu ramai menjadikan Pulau Dua sebagai pilihan tepat bagi wisatawan yang ingin menikmati keindahan alam secara lebih privat dan alami 🌴 sekaligus mendukung upaya pelestarian lingkungan pesisir di wilayah Kabupaten Banggai 🌍✨', '🏝️ Pulau Dua is one of the leading marine tourism destinations located in the Banggai Regency area 🌏 which is known for its unspoiled natural beauty, clean white sand 🤍 and clear turquoise sea water 🌊 so it is very suitable for tourist activities such as swimming, snorkeling, and family recreation;  Administratively, Pulau Dua is in the coastal area of ​​Balantak District ✨ and can be accessed by boat from the nearest coastal villages with a relatively short travel time 🚤;  The main attraction of this island lies in the landscape of two small islands close to each other (hence the name "Pulau Dua") with a stunning open sea panorama 🌅 and an underwater ecosystem that is still well preserved 🐠, making it a potential location for the development of marine ecotourism 🌿;  Apart from that, the calm atmosphere and not too busy make Pulau Dua the right choice for tourists who want to enjoy natural beauty in a more private and natural way 🌴 while supporting efforts to preserve the coastal environment in the Banggai Regency area 🌍✨', 'Pulo Dua, Kec Balantak, Kab Banggai', 'Pulo Dua, Balantak District, Banggai District', '/uploads/1777808031512.png', '123.2000', '-0.9500', 'DESA_UNGGULAN', ''),
('36', 'KAWASAN BANGGAI BERSAUDARA (BANGGAI KEPULAUAN)', 'BANGGAI BERSAUDARA AREA (BANGGAI ISLANDS)', '🌊 Desa Luk Panenteng merupakan salah satu kawasan wisata unggulan di wilayah Kabupaten Banggai Laut 🌏 yang dikenal dengan kekayaan wisata air dan pesisirnya yang masih alami, menjadikannya sebagai destinasi prioritas pengembangan pariwisata berbasis alam dan ekowisata 🌿; kawasan ini memiliki tiga daya tarik utama ✨ yaitu Paisupok yang menjadi ikon wisata air tawar dengan kolam alami berwarna biru jernih 💧 yang langsung bersumber dari mata air bawah tanah sehingga airnya sejuk, tenang, dan sangat cocok untuk berenang maupun relaksasi, Paisu Batango yang menawarkan pengalaman berbeda melalui aliran air alami yang mengalir di antara pepohonan rindang 🌳 dengan suasana yang lebih sejuk, asri, dan cocok untuk menikmati ketenangan alam serta aktivitas santai, serta Pantai Poganda yang menghadirkan panorama bahari dengan hamparan pasir putih lembut 🤍 dan laut biru yang jernih 🌊, ideal untuk menikmati pemandangan, berenang, hingga aktivitas wisata pantai bersama keluarga 🏝️; ketiga destinasi ini berada dalam satu kawasan yang saling terhubung sehingga memberikan pengalaman wisata yang lengkap mulai dari air tawar hingga laut dalam satu perjalanan, sekaligus memperkuat potensi Desa Luk Panenteng sebagai kawasan wisata berkelanjutan yang mendorong pelestarian lingkungan dan pemberdayaan masyarakat lokal 🌱✨', '🌊 Luk Panenteng Village is one of the leading tourist areas in the Banggai Laut Regency region 🌏 which is known for its wealth of unspoiled water and coastal tourism, making it a priority destination for the development of nature-based tourism and ecotourism 🌿;  This area has three main attractions ✨ namely Paisupok which is an icon of fresh water tourism with a clear blue natural pool 💧 which comes directly from an underground spring so the water is cool, calm, and very suitable for swimming and relaxation, Paisu Batango which offers a different experience through a natural water flow flowing between shady trees 🌳 with a cooler, more beautiful atmosphere, and suitable for enjoying the tranquility of nature and relaxing activities, and Poganda Beach which offers a marine panorama with a stretch of soft white sand  🤍 and clear blue sea 🌊, ideal for enjoying the view, swimming, and beach tourism activities with the family 🏝️;  These three destinations are in one connected area, thus providing a complete tourism experience from fresh water to sea in one trip, while strengthening the potential of Luk Panenteng Village as a sustainable tourism area that encourages environmental preservation and empowerment of local communities 🌱✨', 'Desa Luk Panenteng, Kec Bulagi Utara, Kab Banggai Kepulauan', 'Luk Panenteng Village, North Bulagi District, Banggai Islands District', '/uploads/1777570833803.jpg', '123.2000', '-0.9500', 'DESA_UNGGULAN', ''),
('37', 'KAWASAN BANGGAI BERSAUDARA (BANGGAI LAUT)', 'BANGGAI BERSAUDARA (BANGGAI SEA) AREA', '🏝️ Desa Bone Baru merupakan salah satu kawasan wisata potensial yang terletak di wilayah Kabupaten Banggai Laut 🌏 dengan karakteristik pesisir yang masih alami dan keindahan laut yang memukau 🌊, menjadikannya sebagai destinasi yang mulai berkembang dalam pengembangan pariwisata berbasis alam dan masyarakat 🌿; kawasan ini memiliki beberapa daya tarik unggulan ✨ di antaranya Pantai Pontolan yang dikenal dengan hamparan pasir putih bersih 🤍, air laut yang jernih, serta panorama laut terbuka yang indah sehingga cocok untuk berenang, bersantai, dan menikmati matahari terbenam 🌅, selain itu terdapat pantai-pantai alami lainnya di sekitar Bone Baru yang menawarkan suasana tenang, belum ramai, dan sangat ideal untuk wisatawan yang mencari ketenangan serta keaslian alam 🏝️, serta spot-spot pesisir dan laut dangkal yang berpotensi untuk aktivitas snorkeling 🐠 dengan keindahan bawah laut yang masih terjaga; didukung oleh keramahan masyarakat lokal serta akses yang semakin berkembang 🚤, Desa Bone Baru memiliki potensi besar untuk dikembangkan sebagai destinasi wisata bahari berkelanjutan 🌱 yang tidak hanya menghadirkan pengalaman wisata yang menarik tetapi juga mendorong pelestarian lingkungan dan peningkatan ekonomi masyarakat di wilayah Kabupaten Banggai Laut 🌍✨', '🏝️ Bone Baru Village is one of the potential tourist areas located in the Banggai Laut Regency area 🌏 with unspoiled coastal characteristics and stunning sea beauty 🌊, making it a destination that is starting to develop in the development of nature and community-based tourism 🌿;  This area has several superior attractions ✨ including Pontolan Beach which is known for its stretch of clean white sand 🤍, clear sea water, and a beautiful panorama of the open sea making it suitable for swimming, relaxing and enjoying the sunset 🌅, apart from that there are other natural beaches around Bone Baru which offer a calm atmosphere, not yet crowded, and are ideal for tourists who are looking for tranquility and natural authenticity 🏝️, as well as coastal spots and shallow seas that have the potential for snorkeling activities  🐠 with underwater beauty that is still preserved;  supported by the friendliness of the local community and increasing access 🚤, Bone Baru Village has great potential to be developed as a sustainable marine tourism destination 🌱 which not only provides an interesting tourist experience but also encourages environmental preservation and economic improvement for the community in the Banggai Laut Regency area 🌍✨', 'Bone Baru, Kec Banggai Utara, Kab Banggai Laut', 'Bone Baru, North Banggai District, Banggai Laut District', '/uploads/1777571076761.jpeg', '123.5200', '-1.2300', 'DESA_UNGGULAN', ''),
('43', 'Desa Wisata Karosondaya', 'Karosondaya Tourism Village', 'Desa Wisata Karosondaya di Kabupaten Parigi Moutong yang berfokus pada wisata alam pesisir, pantai, laut, dan hutan mangrove, termasuk spot diving Batu Timbul dan jembatan kayu untuk menjelajahi mangrove. Fokus Wisata: Pesisir, pantai, laut, dan hutan mangrove.
Aktivitas Utama: Menjelajahi hutan mangrove dengan perahu dan ponton, menyelam di spot diving Batu Timbul,Sarana Camping, serta menikmati pemandangan alam. Fasilitas: Jembatan kayu sepanjang 450 meter, gazebo, dan area makan.
Lokasi: Berada di Desa Sausu Tambu, Kabupaten Parigi Moutong.
Karakteristik: Kawasan ini memiliki potensi ekowisata yang dikembangkan sejak 2018 dengan jenis mangrove yang beragam.', 'Karosondaya Tourism Village in Parigi Moutong Regency which focuses on coastal, beach, sea and mangrove forest natural tourism, including the Batu Timbul diving spot and wooden bridges for exploring the mangroves.  Tourism Focus: Coast, beaches, sea and mangrove forests.
 Main Activities: Exploring the mangrove forest by boat and pontoon, diving at the Batu Timbul diving spot, camping facilities, and enjoying the natural scenery.  Facilities: 450 meter long wooden bridge, gazebo and dining area.
 Location: Located in Sausu Tambu Village, Parigi Moutong Regency.
 Characteristics: This area has ecotourism potential which has been developed since 2018 with various types of mangroves.', 'Desa Sausu Tambu, Kec. Sausu, Kab. Parigi Moutong', 'Sausu Tambu Village, District.  Sausu, Kab.  Paris Moutong', '/uploads/1777806845234.PNG', '120.7776', '-0.7063', 'DESA_WISATA', ''),
('40', 'Desa Wisata Bukit Salena', 'Salena Hill Tourism Village', 'Desa Salena adalah titik lepas landas paralayang terbaik di Sulawesi Tengah. Terletak di ketinggian yang menawarkan pemandangan spektakuler Teluk Palu dan perbukitan hijau. Cocok bagi pencinta olahraga ekstrem maupun wisatawan yang ingin menikmati matahari terbenam dari ketinggian.', 'Salena Village is the best paragliding take-off point in Central Sulawesi.  Located at an altitude that offers spectacular views of Palu Bay and green hills.  Suitable for extreme sports lovers and tourists who want to enjoy the sunset from above.', 'Kel. Salena, Kec. Ulujadi, Kota Palu', 'Ex.  Salena, District.  Ulujadi, Palu City', '/uploads/1777806349605.jpeg', '119.8215', '0.9025', 'DESA_WISATA', ''),
('41', 'Desa Wisata Pulo Dua', 'Pulo Dua Tourism Village', 'Desa Wisata Pulo Dua adalah sebuah desa pengembang wisata di Kecamatan Balantak, Kabupaten Banggai, Sulawesi Tengah, yang menawarkan pesona alam berupa gugusan dua pulau dengan keindahan bawah laut yang masih alami dan pantai berpasir putih. Destinasi ini dapat diakses melalui darat dari Luwuk selama beberapa jam, atau melalui laut dan udara, dengan waktu tempuh 15 menit dari desa ke pulau utama menggunakan perahu. Wisata Bahari: Menyelam dan snorkeling untuk menikmati terumbu karang dan biota laut yang belum terjamah.  Pantai Pasir Putih: Menikmati keindahan pantai dengan pasir putih yang memukau.
Pendakian Bukit: Mendaki bukit di Pulau Dua untuk menikmati pemandangan indah desa-desa sekitar dan, jika cuaca cerah, bisa melihat daratan lain.
Budaya Lokal: Berinteraksi dengan masyarakat lokal dan menikmati budaya', 'Pulo Dua Tourism Village is a tourism development village in Balantak District, Banggai Regency, Central Sulawesi, which offers natural charm in the form of a group of two islands with unspoiled underwater beauty and white sandy beaches.  This destination can be accessed by land from Luwuk for several hours, or by sea and air, with a travel time of 15 minutes from the village to the main island by boat.  Marine Tourism: Diving and snorkeling to enjoy coral reefs and unspoiled marine life.   White Sand Beach: Enjoy the beauty of the beach with stunning white sand.
 Hill Climbing: Climb the hill on Pulau Dua to enjoy beautiful views of the surrounding villages and, if the weather is clear, to see other land.
 Local Culture: Interact with local people and enjoy the culture', 'Desa Kampangar, Kec. Balantak Utara, Kab. Banggai', 'Kampangar Village, District.  North Balantak, Kab.  Banggai', '/uploads/1777806526667.jpeg', '123.5083', '-1.6039', 'DESA_WISATA', ''),
('42', 'Desa Wisata Anggrek Karunia', 'Karunia Orchid Tourism Village', 'DESA KARUNIA merupakan salah satu desa yang berbatasan langsung dengan Taman Nasional Lore Lindu (TNLL). Sebagai salah satu kawasan konservasi di Sulawesi tengah, Taman Nasional Lore Lindu (TNLL) memiliki keanekaragaman hayati yang tinggi. Salah satu potensi sumber daya hutan adalah anggrek alam yang diperkirakaan sekitar 50 genus anggrek menyebar pada ketinggian 600-800 mdpl di wilayah TNLL. Beberapa diantaranya termasuk endemik seperti anggrek bulan merah (Phalaenopsis celebencis), anggrek bulan putih (Phalaenopsis amabilis) dan anggrek bulan kuning (Phalaenopsis amboinensis), Coelogyne sp., Bulbophyllum, Dendrobium, Vanda dan berbagai jenis lainnya.
Hal inilah kelompok masyarakat Desa Karunia yang mengembangkan dan membudidayakan tanaman anggrek yang merupakan kekayaan alam Cagar Biosefer Lore Lindu. ini suatu bentuk konservasi yang dilakukan masyarakat di sekitar Cagar Biosfer Lore Lindu.', 'KARUNIA VILLAGE is one of the villages that borders directly on the Lore Lindu National Park (TNLL).  As one of the conservation areas in Central Sulawesi, Lore Lindu National Park (TNLL) has high biodiversity.  One of the potential forest resources is natural orchids, which are estimated to be around 50 orchid genera spread at an altitude of 600-800 meters above sea level in the TNLL area.  Some of them are endemic, such as the red moon orchid (Phalaenopsis celebencis), white moon orchid (Phalaenopsis amabilis) and yellow moon orchid (Phalaenopsis amboinensis), Coelogyne sp., Bulbophyllum, Dendrobium, Vanda and various other types.
 This is the Karunia Village community group that develops and cultivates orchids which are a natural treasure of the Lore Lindu Biosefer Reserve.  This is a form of conservation carried out by the community around the Lore Lindu Biosphere Reserve.', 'Desa Karunia, Kec, Palolo, Kab. Sigi', 'Karunia Village, District, Palolo, Kab.  Sigi', '/uploads/1777806643203.jpeg', '120.0672631', '1.2112872', 'DESA_WISATA', ''),
('39', 'Desa Wisata Taat', 'Taat Tourism Village', 'Desa Taat Adalah Salah Satu Dari Sebelas Desa Yang Berada Di Kecamatan Gadung Yang Terletak Di Kabupaten Buol Provinsi Sulawesi Tengah. Wisata Desa Taat Ditetapkan Sebagai Desa Wisata Melalui Keputusan Bupati Buol NOMOR. 188.04/120.16/Dispora/2022 Pada Tanggal 14 Juni 2022 Sebagai Wisata Alam Mangrove Yang Memiliki Luasan Area Mangrove Kurang Lebih 14 Ha. Aktivitas Yang Tersedia Dan Dapat Dinikmati Oleh Pengunjung di Wisata Alam Mangrove Desa Taat  Mulai Dari Panorama Alam ,Pertanian, Memancing Ikan Di Area Gazebo, Pertunjukan Alat Music Tradisional Kulintang, Rebana,  Kegiatan Adat Masyarakat Seperti  Pertunjukkan Seni Tari Dalam Bahasa Daerah  Yangga, Serta Pengunjung Dapat Menikmati Makanan Khas Tradisional Berupa Jenis Makan Yabuy, Bagea,  ( Dalam Bahasa Indonesia Ambal Dan Kue Sagu Yang Di Olah Dari Bahan Lokal Yaitu Sagu).', 'Taat Village is one of eleven villages in Gadung District, which is located in Buol Regency, Central Sulawesi Province.  Taat Village Tourism was designated as a tourist village through Buol Regent\'s Decree NUMBER.  188.04/120.16/Dispora/2022 On June 14 2022 As a Mangrove Nature Tourism Area which has a Mangrove Area of ​​Approximately 14 Ha.  Activities that are available and can be enjoyed by visitors at the Taat Village Mangrove Nature Tourism range from natural panoramas, agriculture, fishing in the gazebo area, performances of traditional Kulintang musical instruments, tambourines, traditional community activities such as dance performances in the Yangga regional language, and visitors can enjoy traditional specialties in the form of yabuy, bagea, (in Indonesian, Ambal and Sago Cake which are prepared from local ingredients, namely sago).', 'Desa Taat, Kec. Gadung, Kab. Toli-Toli', 'Taat Village, District.  Gadung, Kab.  Toli-Toli', '/uploads/1777806233076.jpeg', '121.6928', '1.0569', 'DESA_WISATA', ''),
('38', 'Desa Wisata Malangga', 'Malangga Tourism Village', 'Desa Wisata Malangga terletak di Kecamatan Galang sekitar 60 menit dari Pusat Kota Tolitoli. Desa ini dapat dijangkau dengan kendaraan roda dua atau empat. Desa Malangga dijadikan desa wisata karena memilik keunikan tersendiri yaitu atap rumah penduduk di desa ini dapat dibuka dan ditutup.
Fungsinya adalah untuk meletakkan hasil bumi di plavon rumah mereka agar cahaya matahari bisa langsung mengeringkan hasil bumi tersebut tanpa harus menjemurnya di halaman rumah. Selain itu, disekitar desa ini juga terdapat pembuatan gula merah dan minyak kelapa kampung yang diolah oleh warga desa secara tradisional. Terdapat juga tradisi upacara adat panen dan tradisi sumpit yang masih terjaga dan dilaksanakan setiap tahun di desa ini.', 'Malangga Tourism Village is located in Galang District, about 60 minutes from Tolitoli City Center.  This village can be reached by two or four wheeled vehicles.  Malangga Village has become a tourist village because it has its own uniqueness, namely that the roofs of the residents\' houses in this village can be opened and closed.
 Its function is to place the produce on the ceiling of their house so that sunlight can directly dry the produce without having to dry it in the yard.  Apart from that, around this village there is also the production of brown sugar and village coconut oil which are processed by village residents traditionally.  There are also traditional harvest ceremony traditions and chopstick traditions which are still maintained and carried out every year in this village.', 'Desa Malangga, Kec. Galang, Kab. Toli-Toli', 'Malangga Village, District.  Galang, Kab.  Toli-Toli', '/uploads/1777807305427.jpeg', '121.6928', '1.0569', 'DESA_WISATA', ''),
('34', 'KAWASAN TAMAN NASIONAL LORE LINDU (KAB. POSO)', 'LORE LINDU NATIONAL PARK (POSO DISTRICT)', '🌿 Taman Nasional Lore Lindu pada wilayah Kabupaten Poso merupakan bagian penting dari kawasan konservasi yang membentang di jantung Pulau Sulawesi 🌏 dengan kekayaan keanekaragaman hayati 🌳 serta bentang alam pegunungan dan lembah yang masih alami, menjadikannya sebagai habitat berbagai flora dan fauna endemik Sulawesi 🐒🦜 sekaligus kawasan penyangga ekosistem yang sangat vital; di dalam kawasan Taman Nasional Lore Lindu wilayah Poso ini tersimpan berbagai potensi unggulan ✨ seperti Lembah Napu, kawasan Megalitikum Lore Utara, situs-situs arca dan kalamba di Desa Wuasa dan sekitarnya, hutan pegunungan yang masih perawan, jalur trekking alam, serta lanskap perbukitan dan sungai alami yang membentuk ekosistem khas Sulawesi ✨ yang tidak hanya memiliki nilai ekologis tinggi tetapi juga nilai sejarah dan budaya yang kuat 🗿; kawasan ini menjadi pusat penelitian dan edukasi lingkungan 🔬 sekaligus dikembangkan sebagai destinasi ekowisata berkelanjutan 🌱 yang memberikan manfaat bagi masyarakat lokal, serta berperan penting dalam upaya pelestarian warisan alam dan budaya untuk generasi mendatang 🌍✨', '🌿 Lore Lindu National Park in the Poso Regency area is an important part of the conservation area that stretches across the heart of Sulawesi Island 🌏 with a wealth of biodiversity 🌳 as well as unspoiled mountain and valley landscapes, making it a habitat for various flora and fauna endemic to Sulawesi 🐒🦜 as well as a very vital ecosystem buffer area;  Within the Lore Lindu National Park area in the Poso region, various superior potentials are stored ✨ such as the Napu Valley, the North Lore Megalithic area, statue and kalamba sites in Wuasa Village and its surroundings, pristine mountain forests, natural trekking trails, as well as natural hilly and river landscapes that form a typical Sulawesi ecosystem ✨ which not only has high ecological value but also strong historical and cultural value 🗿;  This area is a center for environmental research and education 🔬 as well as being developed as a sustainable ecotourism destination 🌱 which provides benefits to local communities, and plays an important role in efforts to preserve natural and cultural heritage for future generations 🌍✨', 'Kabupaten Poso', 'Poso Regency', '/uploads/1777808927263.jpeg', '120.3000', '1.3900', 'DESA_UNGGULAN', ''),
('44', 'KAWASAN TAMAN NASIONAL LORE LINDU (KAB. SIGI)', 'LORE LINDU NATIONAL PARK AREA (SIGI DISTRICT)', '🌿 Taman Nasional Lore Lindu merupakan kawasan konservasi penting yang terletak di wilayah Kabupaten Sigi dan sekitarnya, yang dikenal sebagai salah satu pusat keanekaragaman hayati terbesar di Indonesia 🌏 dengan bentang alam yang memadukan hutan hujan tropis, pegunungan, lembah, hingga danau alami yang memukau; kawasan ini menjadi habitat berbagai flora dan fauna endemik Sulawesi 🐒🦜 serta memiliki nilai ekologis yang sangat tinggi sebagai penyangga kehidupan dan keseimbangan lingkungan 🌳, sekaligus menyimpan kekayaan budaya berupa jejak peradaban megalitikum yang tersebar di beberapa lembah dan menjadi warisan sejarah yang unik 🗿; di dalam kawasan Taman Nasional Lore Lindu ini terdapat berbagai titik penting yang menjadi daya tarik utama ✨ seperti Lembah Bada, Lembah Besoa, Lembah Napu, Danau Lindu, Gunung Nokilalaki, Gunung Rorekatimbu, Sungai Lariang, Air Terjun Paku, Desa Wisata Toro, serta situs-situs megalitik berupa arca dan kalamba yang tersebar di kawasan lembah ✨ yang mencerminkan perpaduan keindahan alam dan nilai sejarah yang tinggi; keberadaan kawasan ini tidak hanya berfungsi sebagai pusat konservasi dan penelitian 🔬 tetapi juga dikembangkan sebagai destinasi ekowisata berkelanjutan 🌱 yang memberikan manfaat bagi masyarakat sekitar, serta menjadi bagian penting dalam menjaga warisan alam dunia dan mendukung upaya pelestarian lingkungan hidup secara berkelanjutan 🌍', '🌿 Lore Lindu National Park is an important conservation area located in Sigi Regency and its surroundings, which is known as one of the largest biodiversity centers in Indonesia 🌏 with a natural landscape that combines tropical rainforests, mountains, valleys and stunning natural lakes;  This area is a habitat for various flora and fauna endemic to Sulawesi 🐒🦜 and has very high ecological value as a support for life and environmental balance 🌳, as well as storing cultural riches in the form of traces of megalithic civilization spread across several valleys and becoming a unique historical heritage 🗿;  Within the Lore Lindu National Park area there are various important points which are the main attraction ✨ such as Bada Valley, Besoa Valley, Napu Valley, Lake Lindu, Mount Nokilalaki, Mount Rorekatimbu, Lariang River, Paku Waterfall, Toro Tourism Village, as well as megalithic sites in the form of statues and kalambas scattered throughout the valley area ✨ which reflect a combination of natural beauty and high historical value;  The existence of this area not only functions as a conservation and research center 🔬 but is also developed as a sustainable ecotourism destination 🌱 which provides benefits to the surrounding community, as well as being an important part in maintaining the world\'s natural heritage and supporting sustainable environmental conservation efforts 🌍', 'Kabupaten Sigi ', 'Sigi Regency', '/uploads/1777870418662.webp', '120.0500', '-1.3200', 'DESA_UNGGULAN', ''),
('45', 'KAWASAN SITUS WARISAN GEOLOGI SULAWESI TENGAH', 'CENTRAL SULAWESI GEOLOGICAL HERITAGE SITE AREA', '🌏 Kawasan Situs Geologi Poso merupakan kawasan pengembangan berbasis warisan geologi yang terintegrasi dengan keanekaragaman hayati 🌿 dan budaya lokal 🏺 yang berada di wilayah Kabupaten Poso, menghadirkan bentang alam yang merekam perjalanan panjang sejarah bumi sekaligus menjadi ruang hidup masyarakat yang kaya akan kearifan lokal; di dalam kawasan ini tersebar 24 situs geologi unggulan 🪨 yang menjadi inti daya tarik geopark dan menggambarkan kekayaan fenomena alam yang unik dan bernilai tinggi, yaitu ✨ Mata Air Panas Pantangolemba, Kecamatan Poso Pesisir Selatan; Hipostratotipe Formasi Puna (Tangkura), Kecamatan Poso Pesisir Selatan; Sinklin Pandiri, Kecamatan Lage; Endapan Breksi Tampemadoro (Formasi Lage), Kecamatan Lage; Sekis Hijau Panjoka, Kecamatan Pamona Utara; Batugamping Gneiss Panjoka, Kecamatan Pamona Utara; Batugamping Malihan Wawondoda (Sawidago), Kecamatan Pamona Utara; Ketidakselarasan Petirodongi, Kecamatan Pamona Utara; Conical Hills Posunga, Kecamatan Pamona Pusalemba; Gua Latea, Kecamatan Pamona Pusalemba; Ceruk Tangkaboba, Kecamatan Pamona Pusalemba; Gua Pamona, Kecamatan Pamona Pusalemba; Air Terjun Saluopa (Travertine), Kecamatan Pamona Pusalemba; Zeolit Pompangeo Taripa, Kecamatan Pamona Timur; Foliasi Taripa, Kecamatan Pamona Timur; Filit Pompangeo Matialemba, Kecamatan Pamona Timur; Gua Korobono, Kecamatan Pamona Tenggara; Air Terjun Kolori, Kecamatan Pamona Tenggara; Triangular Facet Padamarari, Kecamatan Pamona Barat; Hipostratotipe Formasi Latimojong Bomba, Kecamatan Lore Selatan; Intrusi Diorit Bomba, Kecamatan Lore Selatan; Sungai Purba Badangkaia, Kecamatan Lore Selatan; Air Terjun Betaua, Kecamatan Lore Barat; Mata Air Panas Lengkeka, Kecamatan Lore Barat ✨ yang masing-masing menyajikan keunikan geologi mulai dari struktur batuan, fenomena karst, hingga manifestasi panas bumi 💧; kekayaan ini semakin diperkuat dengan keindahan Danau Poso serta kedekatannya dengan kawasan konservasi Taman Nasional Lore Lindu yang menyimpan keanekaragaman hayati penting 🌳, sehingga pengembangan Geopark Poso diarahkan pada upaya pelestarian, edukasi, dan peningkatan kesejahteraan masyarakat melalui pariwisata berkelanjutan 🌱 sekaligus mendorong pengakuan sebagai bagian dari jaringan UNESCO Global Geoparks 🌍✨', '🌏 The Poso Geological Site Area is a geological heritage-based development area that is integrated with biodiversity 🌿 and local culture 🏺 located in the Poso Regency area, presenting a natural landscape that records the long history of the earth as well as being a community living space that is rich in local wisdom;  Within this area, there are 24 superior geological sites 🪨 which are the core attraction of the geopark and illustrate the wealth of unique and highly valuable natural phenomena, namely ✨ Pantangolemba Hot Springs, Poso Pesisir Selatan District;  Hypostratotype of the Puna (Tangkura) Formation, Poso Pesisir Selatan District;  Pandiri Syncline, Lage District;  Tampemadoro Breccia Deposits (Lage Formation), Lage District;  Panjoka Green Schist, North Pamona District;  Panjoka Gneiss Limestone, North Pamona District;  Malihan Wawondoda (Sawidago) Limestone, North Pamona District;  Petirodongi Unconformity, North Pamona District;  Conical Hills Posunga, Pamona Pusalemba District;  Latea Cave, Pamona Pusalemba District;  Tangkaboba Niche, Pamona Pusalemba District;  Pamona Cave, Pamona Pusalemba District;  Saluopa (Travertine) Waterfall, Pamona Pusalemba District;  Pompangeo Taripa Zeolite, East Pamona District;  Taripa Foliasi, East Pamona District;  Filit Pompangeo Matialemba, East Pamona District;  Korobono Cave, Southeast Pamona District;  Kolori Waterfall, Southeast Pamona District;  Triangular Facet Padamarari, West Pamona District;  Hypostratotype of the Latimojong Bomba Formation, South Lore District;  Bomba Diorite Intrusion, South Lore District;  Purba Badangkaia River, South Lore District;  Betaua Waterfall, West Lore District;  Lengkeka Hot Springs, West Lore District ✨ each of which presents unique geology ranging from rock structures, karst phenomena, to geothermal manifestations 💧;  This wealth is further strengthened by the beauty of Lake Poso and its proximity to the Lore Lindu National Park conservation area which holds important biodiversity 🌳, so that the development of the Poso Geopark is directed at efforts to preserve, educate and improve community welfare through sustainable tourism 🌱 while encouraging recognition as part of the UNESCO Global Geoparks network 🌍✨', 'Tentena, Kabupaten Poso, Sulawesi Tengah', 'Tentena, Poso Regency, Central Sulawesi', '/uploads/1777870712898.webp', '120.6500', '-1.5200', 'DESA_UNGGULAN', '');

INSERT INTO `jarakDesa` (`id`, `desaId`, `titikKota`, `jalur_laut`, `jalur_darat`, `jalur_udara`) VALUES
('52', '9', 'PALU', '±2–3 hari
via Pelni Pantoloan–Banggai Laut', '±15–17 jam
~640 km via Trans-Sulawesi + kapal', '±1 j 10 mnt + 1–2 jam
Palu→Luwuk (Wings Air) + darat/kapal'),
('53', '9', 'LUWUK', '±20 menit
Speedboat dari ibu kota Banggai Laut', '±2–3 jam
~80 km dari Luwuk', 'Tidak ada bandara di Banggai Laut'),
('55', '15', 'PALU', 'Tidak ada akses laut', '±6–7 jam
~250–280 km via Palu–Poso–Lore Tengah', 'Tidak ada bandara di Poso'),
('56', '15', 'LUWUK', 'Tidak ada akses laut', '±8–9 jam
~310–330 km via Ampana–Poso–Lore Tengah', 'Tidak ada bandara di Poso/Napu'),
('57', '13', 'PALU', 'Tidak ada rute langsung', '±8–10 jam
~400 km via Parigi–Poso–Ampana', '±45 mnt + 3–4 jam darat
Palu→Ampana (Wings Air) + mobil'),
('58', '13', 'LUWUK', 'Belum ada jalur reguler', '±5–6 jam
~230 km via Ampana', '±1 j 10 mnt + 3–4 jam
Luwuk→Palu→Ampana + mobil'),
('59', '28', 'PALU', '±10–12 jam + kapal
via Ampana → Kepulauan Togean', '±10–12 jam + 5 jam kapal
~400 km darat ke Ampana + kapal ke Togean', '±45 mnt + 5 jam kapal
Palu→Ampana (Wings Air) + kapal Togean'),
('60', '28', 'LUWUK', '±7–9 jam + kapal
via Luwuk→Ampana + kapal Togean', '±7–9 jam + 5 jam kapal
~280 km ke Ampana + kapal', '±1 j 10 mnt + 45 mnt + kapal
Luwuk→Palu→Ampana + kapal'),
('61', '23', 'PALU', '±2–3 hari
via Pelni ke Banggai Kepulauan', '±16–18 jam
~750 km + kapal ke Bangkep', 'Tidak ada bandara di Bangkep'),
('62', '23', 'LUWUK', '±2–5 jam
via kapal Luwuk–Leme-Leme / Salakan', '±2 jam kapal + 1,5 jam darat
Luwuk→Leme-Leme (2 jam) + darat ke Bulagi Utara', 'Tidak ada bandara di Bangkep'),
('63', '16', 'PALU', 'Tidak ada rute laut', '±35–45 menit
~40 km via Kec. Banawa Tengah', 'Tidak ada bandara di Donggala'),
('64', '16', 'LUWUK', 'Tidak ada rute laut', '±14–16 jam
~640 km via Trans-Sulawesi', '±1 j 10 mnt + 45 mnt darat
Luwuk→Palu (Wings Air) + 40 km ke Towale'),
('65', '43', 'PALU', 'Tidak ada rute laut', '±3–4 jam
~130 km via Parigi', 'Tidak ada bandara'),
('66', '43', 'LUWUK', 'Tidak ada rute laut', '±10–11 jam
~470 km via Ampana–Parigi', '±1 j 10 mnt + 3–4 jam
Luwuk→Palu + darat ke Sausu'),
('67', '40', 'PALU', 'Tidak ada akses laut', '±15–20 menit
dalam Kota Palu, Kel. Salena', 'Bandara ada di kota yang sama'),
('68', '40', 'LUWUK', 'Tidak ada akses laut', '±13–15 jam
~600 km via Trans-Sulawesi', '±1 j 10 mnt + 15–20 mnt
Luwuk→Palu + 15 mnt ke Bukit Salena'),
('69', '41', 'PALU', '±2–3 hari
via Pelni + perahu', '±14–16 jam + 15 mnt perahu
~600 km + perahu ke Kampangar', '±1 j 10 mnt + 3–4 jam + perahu
Palu→Luwuk + 185 km + perahu'),
('70', '41', 'LUWUK', '±3–4 jam + perahu
via Pelabuhan Luwuk + darat', '±3–4 jam + 15 mnt perahu
~185 km ke Kampangar + perahu', 'Bandara terdekat: Luwuk (LUW)'),
('71', '42', 'PALU', 'Tidak ada akses laut', '±1,5 jam
~60 km selatan Kota Palu', 'Tidak ada bandara di Sigi'),
('72', '42', 'LUWUK', 'Tidak ada akses laut', '±14–15 jam
~600 km via Trans-Sulawesi', '±1 j 10 mnt + 1,5 jam darat
Luwuk→Palu + 60 km ke Palolo'),
('73', '39', 'PALU', 'Tidak ada rute laut langsung', '±11–12 jam
545 km via Trans-Sulawesi
+ ~1 jam ke Kec. Gadung', 'Tidak ada bandara di Buol'),
('74', '39', 'LUWUK', 'Tidak ada rute laut langsung', '±24–26 jam
Luwuk→Palu (610 km) + 545 km ke Buol
via Trans-Sulawesi ', '±1 j 10 mnt + 11–12 jam
Luwuk→Palu (Wings Air) + 545 km darat ke Buol'),
('85', '37', 'LUWUK', '±20 menit
Speedboat dari Pelabuhan Banggai Laut', '±20 menit speedboat
Speedboat dari ibu kota Kab. Banggai Laut
Kec. Banggai Utara — sangat dekat dari Luwuk', 'Tidak ada bandara di Banggai Laut'),
('75', '38', 'PALU', 'Tidak ada rute laut langsung', '±12 jam + 60 mnt
353,3 km via Trans-Sulawesi ke Tolitoli
Tribunpalu
+ 60 mnt ke Kec. Galang ', '±55 mnt + 60 mnt darat
Palu→Tolitoli (Wings Air, 1x/minggu)
+ 60 mnt ke Kec. Galang'),
('76', '38', 'LUWUK', 'Tidak ada rute laut langsung', '±21–22 jam + 60 mnt
Luwuk→Palu (610 km) + 353 km ke Tolitoli', '±1 j 10 mnt + 12 jam + 60 mnt
Luwuk→Palu (Wings Air) + darat 353 km ke Galang'),
('77', '32', 'PALU', 'Tidak ada rute laut langsung dari Palu', '±10–12 jam + 3 jam kapal
~375 km darat ke Ampana
+ kapal Ampana–Wakai ±3 jam (berangkat jam 10 pagi)', '±45 mnt + 3 jam kapal
Palu → Ampana (Wings Air, Senin & Rabu)
+ kapal Ampana–Wakai ±3 jam (jam 10 pagi)'),
('78', '32', 'LUWUK', 'Tidak ada kapal langsung Luwuk–Togean. Semua harus via Ampana ', '±7 jam darat + 3 jam kapal
Luwuk → Ampana ±7 jam (minivan harian, jam 08.00)
+ kapal Ampana–Wakai ±3 jam', 'Luwuk (LUW) → Palu (PLW) → Ampana → Wakai
±1 j 10 mnt + 45 mnt + 3 jam kapal
Luwuk→Palu (Wings Air) + Palu→Ampana (Wings Air)
+ kapal Ampana–Wakai ±3 jam'),
('79', '35', 'PALU', 'Tidak ada rute laut langsung', '±13 jam + 15 mnt perahu
~600 km via Trans-Sulawesi ke Kampangar
via Poso–Ampana–Luwuk–Balantak Utara', '±1 j 10 mnt + 3–4 jam + perahu
Palu→Luwuk (Wings Air) + ~185 km darat + perahu'),
('80', '35', 'PALU', 'Tidak ada rute laut langsung', '±13 jam + 15 mnt perahu
~600 km via Trans-Sulawesi ke Kampangar
via Poso–Ampana–Luwuk–Balantak Utara', '±1 j 10 mnt + 3–4 jam + perahu
Palu→Luwuk (Wings Air) + ~185 km darat + perahu'),
('81', '35', 'LUWUK', '±3–4 jam + perahu
via darat Luwuk–Kampangar + perahu', '±3–4 jam + 15 mnt perahu
~185 km ke Desa Kampangar, Balantak Utara
+ perahu ±15 mnt ke Pulo Dua', 'Bandara terdekat: Luwuk (LUW)'),
('82', '36', 'PALU', '±2–3 hari
via Pelni Pantoloan–Luwuk–Bangkep', '±13 jam + 2 jam kapal
~610 km darat ke Luwuk + kapal ke Leme-Leme', 'Tidak ada bandara di Bangkep'),
('83', '36', 'LUWUK', '±2–5 jam
Kapal Luwuk–Leme-Leme atau Salakan', '±2 jam kapal + 1,5 jam darat
Luwuk→Leme-Leme (±2 jam kapal) + darat ke Bulagi Utara
Rute tercepat via Pelabuhan Leme-Leme', 'Tidak ada bandara di Bangkep'),
('84', '37', 'PALU', '±2–3 hari
via Pelni Pantoloan–Banggai Laut', '±13 jam + 20 mnt speedboat
~610 km via Trans-Sulawesi ke Luwuk + speedboat
Jarak Palu–Luwuk ~600 km / 13 jam', '±1 j 10 mnt + 20 mnt speedboat
Palu→Luwuk (Wings Air) + speedboat ±20 mnt
Rute paling efisien'),
('86', '37', 'LUWUK', '±20 menit
Speedboat dari Pelabuhan Banggai Laut', '±20 menit speedboat
Speedboat dari ibu kota Kab. Banggai Laut
Kec. Banggai Utara — sangat dekat dari Luwuk', 'Tidak ada bandara di Banggai Laut'),
('87', '45', 'PALU', 'Tidak ada akses laut ke Tentena', '±8 jam
283 km via Trans-Sulawesi', 'Tidak ada bandara di Tentena
Bandara terdekat: Kasiguncu Poso (PSJ) ~58 km dari Tentena'),
('88', '45', 'PALU', 'Tidak ada akses laut ke Tentena', '±8 jam
283 km via Trans-Sulawesi', 'Tidak ada bandara di Tentena
Bandara terdekat: Kasiguncu Poso (PSJ) ~58 km dari Tentena'),
('89', '45', 'PALU', 'Tidak ada akses laut ke Tentena', '±8 jam
283 km via Trans-Sulawesi', 'Tidak ada bandara di Tentena
Bandara terdekat: Kasiguncu Poso (PSJ) ~58 km dari Tentena'),
('90', '45', 'LUWUK', 'Tidak ada akses laut ke Tentena', '±11 jam
Luwuk→Ampana 7 jam + Ampana→Poso 4 jam + Poso→Tentena 1,5 jam', '±1 j 10 mnt + 8 jam darat
Luwuk→Palu (Wings Air) + 283 km ke Tentena'),
('91', '34', 'PALU', 'Tidak ada akses laut (pegunungan)', '±3–4 jam
105 km dari Palu via Lembah Napu', 'Tidak ada bandara di Lore Utara
Bandara terdekat: Palu (PLW) — lanjut darat 105 km'),
('92', '34', 'LUWUK', 'Tidak ada akses laut', '±14–15 jam
610 km Luwuk→Palu + 105 km ke Wuasa', '±1 j 10 mnt + 3–4 jam darat
Luwuk→Palu (Wings Air) + 105 km ke Wuasa
Rute paling efisien dari Luwuk'),
('93', '44', 'PALU', 'Tidak ada akses laut (pegunungan)', '±4–5 jam
140 km dari Palu via Lore Lindu', 'Tidak ada bandara di Lore Peore
Bandara terdekat: Palu (PLW) — lanjut darat 140 km'),
('94', '44', 'LUWUK', 'Tidak ada akses laut', '±15–16 jam
610 km Luwuk→Palu + 140 km ke lore Peore', '±1 j 10 mnt + 4–5 jam darat
Luwuk→Palu (Wings Air) + 140 km ke Watutau
Rute paling efisien dari Luwuk');

INSERT INTO `pageView` (`id`, `page`, `visitorId`, `createdAt`) VALUES
('1', '/', 'test123', '2026-03-13 17:06:46.901'),
('2', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 17:17:51.666'),
('3', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 17:26:24.147'),
('4', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 17:32:21.476'),
('5', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 17:56:11.205'),
('6', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:08:29.638'),
('7', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:08:45.456'),
('8', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:08:49.608'),
('9', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:09:41.928'),
('10', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:09:50.891'),
('11', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:10:02.081'),
('12', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:10:29.007'),
('13', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:19:49.257'),
('14', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:40:23.515'),
('15', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:40:38.713'),
('16', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:40:46.015'),
('17', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:56:00.211'),
('18', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 18:56:36.875'),
('19', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 19:21:47.815'),
('20', 'Home', 'e96e8e78-4d51-4854-af98-eaf3726e6f3d', '2026-03-13 19:48:12.231'),
('21', 'Home', 'b05a2fa2-c493-40ab-b60a-75aa5312811b', '2026-03-13 19:48:14.796'),
('22', 'Home', '2f4eed5b-b7fa-4463-b3f5-f48654bb7bbe', '2026-03-13 19:50:36.1'),
('23', 'Home', 'bf086350-756a-49ae-a071-8df4e805ef12', '2026-03-13 19:50:36.529'),
('24', 'Home', '7af9515e-c6f8-4985-a782-8f5208e0f634', '2026-03-13 19:50:44.881'),
('25', 'Home', '8cd71969-8d24-43b2-81c9-2f3d424c3182', '2026-03-13 19:51:13.298'),
('26', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 19:51:27.698'),
('27', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 20:05:46.267'),
('28', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 20:06:04.276'),
('29', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 20:06:40.528'),
('30', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 20:14:10.83'),
('31', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-13 20:14:46.501'),
('32', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-13 20:17:17.009'),
('33', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-13 20:23:52.187'),
('34', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-13 20:28:30.183'),
('35', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-13 20:28:47.725'),
('36', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 02:32:36.886'),
('37', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 02:32:45.212'),
('38', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 04:48:09.555'),
('39', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 04:58:40.785'),
('40', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:09:24.008'),
('41', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:28:23.969'),
('42', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:28:33.96'),
('43', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:29:28.423'),
('44', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:35:49.657'),
('45', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:36:18.738'),
('46', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:37:10.627'),
('47', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:37:12.34'),
('48', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:37:14.257'),
('49', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 05:37:40.432'),
('50', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:37:54.194'),
('51', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:38:03.948'),
('52', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:38:09.47'),
('53', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:38:39.506'),
('54', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 05:38:49.582'),
('55', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 05:39:01.246'),
('56', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 05:40:18.627'),
('57', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 05:40:23.72'),
('58', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:00:19.866'),
('59', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:00:44.883'),
('60', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:34.083'),
('61', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:43.843'),
('62', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:47.467'),
('63', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:53.725'),
('64', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:57.023'),
('65', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:31:58.549'),
('66', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:32:38.555'),
('67', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:32:43.793'),
('68', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:32:54.26'),
('69', 'Home', 'bd162006-68f8-40f2-8d99-5a491d933b6b', '2026-03-14 06:32:59.551'),
('70', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:34:55.742'),
('71', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:35:01.576'),
('72', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:35:04.257'),
('73', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 06:56:51.268'),
('74', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 06:57:58.925'),
('75', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 06:58:02.783'),
('76', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 06:58:06.137'),
('77', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 07:00:24.454'),
('78', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 07:05:28.202'),
('79', 'Home', '3e54d3dc-6a3a-4331-8176-457a15f5e088', '2026-03-14 07:05:45.11'),
('80', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 07:11:07.383'),
('81', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-03-14 07:14:53.834'),
('82', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-03-14 07:15:28.718'),
('83', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-03-14 07:15:35.495'),
('84', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-03-14 07:17:07.194'),
('85', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-03-14 07:17:35.54'),
('86', 'Home', '46f0f828-d1a6-4979-a3ef-230906aaf674', '2026-03-14 07:22:00.36'),
('87', 'Home', '46f0f828-d1a6-4979-a3ef-230906aaf674', '2026-03-14 07:22:05.654'),
('88', 'Home', '46f0f828-d1a6-4979-a3ef-230906aaf674', '2026-03-14 07:22:08.114'),
('89', 'Home', '46f0f828-d1a6-4979-a3ef-230906aaf674', '2026-03-14 07:22:11.832'),
('90', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 07:24:06.655'),
('91', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 07:24:19.307'),
('92', 'Home', '407e88f1-8e7a-42f2-ab46-734d70776ef0', '2026-03-14 07:24:27.563'),
('93', 'Home', '46f0f828-d1a6-4979-a3ef-230906aaf674', '2026-03-14 07:25:02.542'),
('94', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-14 07:36:14.098'),
('95', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 14:49:49.325'),
('96', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 15:12:04.993'),
('97', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-14 15:12:56.372'),
('98', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 16:12:28.653'),
('99', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 16:16:41.023'),
('100', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 16:22:30.07'),
('101', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 17:11:52.067'),
('102', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 17:50:19.501'),
('103', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 17:50:26.836'),
('104', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 18:06:51.017'),
('105', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 18:12:34.818'),
('106', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-14 18:12:40.086'),
('107', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:24:05.328'),
('108', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:31:59.891'),
('109', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:32:42.108'),
('110', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:33:01.599'),
('111', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:35:52.493'),
('112', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 05:43:14.169'),
('113', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:23:07.357'),
('114', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:28:23.264'),
('115', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:29:48.71'),
('116', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:31:58.564'),
('117', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:32:25.693'),
('118', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:32:40.65'),
('119', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:33:48.333'),
('120', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:33:58.02'),
('121', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:34:29.189'),
('122', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:43:35.755'),
('123', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:43:42.876'),
('124', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:43:48.206'),
('125', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-15 06:44:21.308'),
('126', 'Home', 'c1909a97-6b06-49e4-b6cc-cd254c86de9c', '2026-03-15 08:26:04.938'),
('127', 'Home', 'c1909a97-6b06-49e4-b6cc-cd254c86de9c', '2026-03-15 08:26:13.849'),
('128', 'Home', 'c1909a97-6b06-49e4-b6cc-cd254c86de9c', '2026-03-15 08:26:23.058'),
('129', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-15 16:25:07.426'),
('130', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-15 16:29:27.863'),
('131', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 06:20:52.16'),
('132', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 06:24:00.058'),
('133', 'Home', 'eb133ba6-005c-416a-8809-1f7a240b856d', '2026-03-16 06:47:38.126'),
('134', 'Home', 'eb133ba6-005c-416a-8809-1f7a240b856d', '2026-03-16 06:51:13.174'),
('135', 'Home', 'eb133ba6-005c-416a-8809-1f7a240b856d', '2026-03-16 06:51:36.985'),
('136', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 06:51:52.008'),
('137', 'Home', '4b6f8636-007e-44db-b450-4d9743bdff2c', '2026-03-16 06:52:18.909'),
('138', 'Home', '4b6f8636-007e-44db-b450-4d9743bdff2c', '2026-03-16 07:00:56.588'),
('139', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:03:35.691'),
('140', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:03:41.077'),
('141', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:03:44.428'),
('142', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:03:47.918'),
('143', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:03:54.701'),
('144', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:21:29.039'),
('145', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 17:37:31.466'),
('146', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:36:24.972'),
('147', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:36:51.997'),
('148', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:43:14.789'),
('149', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:43:24.517'),
('150', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:43:30.973'),
('151', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:43:37.747'),
('152', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:44:45.295'),
('153', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:44:49.201'),
('154', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-03-16 18:44:53.399'),
('155', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:49:14.84'),
('156', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:53:43.366'),
('157', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:55:34.648'),
('158', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:55:41.294'),
('159', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:56:16.777'),
('160', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:56:31.691'),
('161', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:56:43.578'),
('162', 'Home', '2eafb623-f85a-4b8c-8592-fae962728922', '2026-03-16 18:57:28.364'),
('163', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-17 02:00:29.493'),
('164', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-17 02:05:56.27'),
('165', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-17 20:01:03.149'),
('166', 'Home', '30c76bb4-8980-4a76-b38d-28571daa2689', '2026-03-18 08:50:19.998'),
('167', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:10:09.786'),
('168', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:10:34.044'),
('169', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:10:37.133'),
('170', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:12:55.833'),
('171', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:13:28.486'),
('172', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:14:39.392'),
('173', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:15:03.033'),
('174', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:15:07.835'),
('175', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 09:15:27.509'),
('176', 'Home', 'c2cbad4e-2d0a-4032-9b3f-d4c8a15997fe', '2026-03-18 11:19:34.392'),
('177', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 12:00:35.507'),
('178', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 12:01:07.052'),
('179', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 12:01:08.155'),
('180', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-03-18 22:40:26.484'),
('181', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-03-18 22:45:53.34'),
('182', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-03-18 22:46:44.084'),
('183', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-03-18 22:48:04.977'),
('184', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-20 07:14:02.563'),
('185', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-20 13:26:39.8'),
('186', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-20 13:26:54.718'),
('187', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-20 13:27:10.766'),
('188', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-20 13:27:27.341'),
('189', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-21 12:08:01.756'),
('190', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-21 12:08:15.876'),
('191', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-21 12:08:34.945'),
('192', 'Home', '00599e7d-4750-490d-84ab-051982fba9e7', '2026-03-21 23:16:00.749'),
('193', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-23 16:18:25.025'),
('194', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-23 16:18:59.105'),
('195', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-23 16:21:42.489'),
('196', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-23 16:21:53.815'),
('197', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-23 18:11:22.789'),
('198', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-23 18:20:48.228'),
('199', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-03-23 18:20:49.148'),
('200', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-23 18:48:03.758'),
('201', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-23 18:48:22.652'),
('202', 'Home', '2ee02eb6-a392-49e9-80c6-d14e9e20610f', '2026-03-24 04:20:07.598'),
('203', 'Home', '2ee02eb6-a392-49e9-80c6-d14e9e20610f', '2026-03-24 04:20:20.654'),
('204', 'Home', '7ae3bd66-4305-498f-8c79-0ecc81c9e20f', '2026-03-24 21:27:24.056'),
('205', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-25 02:15:32.165'),
('206', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-25 04:29:23.401'),
('207', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-25 04:31:03.348'),
('208', 'Home', '710b727f-bb42-47fd-8104-ee4d0c25f31f', '2026-03-25 06:39:58.629'),
('209', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-26 07:50:26.491'),
('210', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-03-29 09:33:45.486'),
('211', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-03-30 05:35:06.236'),
('212', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:00:54.392'),
('213', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:02:53.662'),
('214', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:03:52.955'),
('215', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-03-30 07:05:05.554'),
('216', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:08:41.183'),
('217', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:09:18.65'),
('218', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:14:37.368'),
('219', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:21:03.774'),
('220', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-03-30 07:21:12.862'),
('221', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 14:41:39.662'),
('222', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 14:43:05.142'),
('223', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 14:43:41.059'),
('224', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 16:21:41.276'),
('225', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 16:22:16.68'),
('226', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 16:22:52.19'),
('227', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 16:45:16.845'),
('228', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 16:50:57.263'),
('229', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:02:28.418'),
('230', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:06:13.937'),
('231', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:07:59.486'),
('232', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:08:38.381'),
('233', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:09:08.871'),
('234', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:09:35.578'),
('235', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:10:52.839'),
('236', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:12:10.658'),
('237', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:20:31.331'),
('238', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:20:54.169'),
('239', 'Home', '4ebddd11-9312-46f9-bd16-a2b1f30f4f69', '2026-03-30 17:21:02.247'),
('240', 'Home', '24a0ce90-aff8-4449-9ed9-e7287ac9df5b', '2026-03-30 19:57:00.933'),
('241', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-31 05:40:48.924'),
('242', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-31 05:42:19.282'),
('243', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-03-31 05:54:24.777'),
('244', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:23:07.397'),
('245', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:25:47.866'),
('246', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:25:59.673'),
('247', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:26:09.246'),
('248', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:27:14.193'),
('249', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:28:32.01'),
('250', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:32:49.14'),
('251', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:33:18.957'),
('252', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:33:33.281'),
('253', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:34:24.441'),
('254', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:34:38.286'),
('255', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:36:14.378'),
('256', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:41:28.355'),
('257', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:47:48.427'),
('258', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:54:23.412'),
('259', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 07:58:25.782'),
('260', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 08:01:52.751'),
('261', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 08:04:07.377'),
('262', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 08:14:16.768'),
('263', 'Home', '4be94977-d434-4c24-95c4-821070818c54', '2026-03-31 08:18:15.52'),
('264', 'Home', 'ef5de50b-ae4a-4bd6-ba56-0a2cea2a58ac', '2026-03-31 11:09:15.833'),
('265', 'Home', 'ef5de50b-ae4a-4bd6-ba56-0a2cea2a58ac', '2026-03-31 11:09:48.114'),
('266', 'Home', 'ef5de50b-ae4a-4bd6-ba56-0a2cea2a58ac', '2026-03-31 11:10:42.011'),
('267', 'Home', 'ef5de50b-ae4a-4bd6-ba56-0a2cea2a58ac', '2026-03-31 11:11:15.389'),
('268', 'Home', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', '2026-03-31 20:10:44.185'),
('269', 'Home', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', '2026-03-31 20:24:25.494'),
('270', 'Home', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', '2026-03-31 20:48:05.469'),
('271', 'Home', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', '2026-03-31 20:59:35.506'),
('272', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-03-31 23:56:10.161'),
('273', 'Home', '24a0ce90-aff8-4449-9ed9-e7287ac9df5b', '2026-04-01 13:01:43.692'),
('274', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-02 03:51:40.821'),
('275', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-02 03:52:10.292'),
('276', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-02 03:53:27.155'),
('277', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-02 04:17:24.921'),
('278', 'Home', '79e70e32-ca85-4187-802c-b4928fa56c9e', '2026-04-02 11:01:25.55'),
('279', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 15:43:43.368'),
('280', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 15:56:32.076'),
('281', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:04:07.489'),
('282', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:05:02.116'),
('283', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:13:00.053'),
('284', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:18:04.205'),
('285', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:42:17.515'),
('286', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:42:40.465'),
('287', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:43:04.212'),
('288', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:43:05.97'),
('289', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:43:07.827'),
('290', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:43:10.399'),
('291', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:43:23.045'),
('292', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:51:02.669'),
('293', 'Home', '978bf32b-f1d8-408a-a590-ca64b4670618', '2026-04-02 16:51:08.516'),
('294', 'Home', '4f2ad68e-935e-4c28-85f7-55ad926cc54b', '2026-04-02 18:57:29.077'),
('295', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-04-06 00:48:47.739'),
('296', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-04-06 00:50:04.563'),
('297', 'Home', 'c30cc8af-a5e5-4eb7-b62c-a0597dd6c273', '2026-04-06 03:11:53.015'),
('298', 'Home', 'c30cc8af-a5e5-4eb7-b62c-a0597dd6c273', '2026-04-06 03:12:00.977'),
('299', 'Home', 'c30cc8af-a5e5-4eb7-b62c-a0597dd6c273', '2026-04-06 03:19:10.065'),
('300', 'Home', 'c30cc8af-a5e5-4eb7-b62c-a0597dd6c273', '2026-04-06 03:20:23.261'),
('301', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 04:53:54.765'),
('302', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 05:10:55.065'),
('303', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 05:12:12.497'),
('304', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 05:18:10.556'),
('305', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 05:34:54.127'),
('306', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-06 06:15:34.94'),
('307', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-06 06:17:49.257'),
('308', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-06 06:20:55.888'),
('309', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-06 06:23:33.01'),
('310', 'Home', '00b0d407-b570-4cf3-9ec0-c9e2f8c676bb', '2026-04-06 06:56:47.136'),
('311', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:02:15.914'),
('312', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:02:40.158'),
('313', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:02:49.157'),
('314', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:11:02.788'),
('315', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:12:08.047'),
('316', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:12:28.032'),
('317', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:13:11.629'),
('318', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:13:23.851'),
('319', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:17:22.736'),
('320', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-06 07:17:35.123'),
('321', 'Home', '4cef30a1-3218-4d15-8df8-47e811549011', '2026-04-06 07:55:02.636'),
('322', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 02:22:57.692'),
('323', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 03:29:53.546'),
('324', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 03:30:23.128'),
('325', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 03:31:18.086'),
('326', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 03:32:27.406'),
('327', 'Home', '3b3a7d80-3576-4326-8f91-81c5f68f73cb', '2026-04-07 03:49:05.453'),
('328', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:20:53.272'),
('329', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:22:34.096'),
('330', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:23:26.333'),
('331', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:26:08.006'),
('332', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:26:14.619'),
('333', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:29:55.502'),
('334', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:31:02.257'),
('335', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-07 07:55:41.956'),
('336', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-04-07 08:07:02.092'),
('337', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-04-07 08:07:22.827'),
('338', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-07 11:48:49.866'),
('339', 'Home', '2fee9e51-9285-419e-a75b-cb473ce206cb', '2026-04-07 16:51:05.592'),
('340', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-04-08 00:59:43.327'),
('341', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-08 01:37:40.521'),
('342', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-08 01:38:50.653'),
('343', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-08 01:41:50.924'),
('344', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-08 01:47:03.319'),
('345', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-08 04:06:00.267'),
('346', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-04-09 01:33:18.494'),
('347', 'Home', '2424cb40-0224-40bf-9ffc-90f107cf5837', '2026-04-09 02:09:02.533'),
('348', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-09 07:12:25.702'),
('349', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-09 07:13:49.694'),
('350', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-09 07:18:32.708'),
('351', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-09 08:14:50.338'),
('352', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-04-09 08:35:17.994'),
('353', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-04-10 16:56:50.896'),
('354', 'Home', '0ce3d572-34cb-429c-b0ce-096cc08a90fe', '2026-04-11 11:46:52.472'),
('355', 'Home', '0ce3d572-34cb-429c-b0ce-096cc08a90fe', '2026-04-11 16:00:09.417'),
('356', 'Home', '0ce3d572-34cb-429c-b0ce-096cc08a90fe', '2026-04-11 16:00:22.544'),
('357', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-12 08:29:17.32'),
('358', 'Home', '3ef96255-59c8-4d19-a6c2-39e430413c04', '2026-04-12 13:25:48.954'),
('359', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-14 00:41:31.86'),
('360', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-15 00:46:27.44'),
('361', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-15 02:38:09.693'),
('362', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:04:39.525'),
('363', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:05:14.038'),
('364', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:05:20.004'),
('365', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:06:05.283'),
('366', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:06:43.147'),
('367', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:07:04.291'),
('368', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-15 06:21:32.972'),
('369', 'Home', 'e7b9d07a-d419-4b08-aa3d-be3fa8448176', '2026-04-18 02:50:50.939'),
('370', 'Home', '48ebe759-bc9b-4da7-8ae9-75c327f5079a', '2026-04-18 02:51:43.24'),
('371', 'Home', '641280aa-4ebc-4ca6-84a8-5c14ac51bf6c', '2026-04-18 17:52:31.955'),
('372', 'Home', '5230bf6a-dff7-458b-ab9f-14aa083e6e9a', '2026-04-19 14:39:27.855'),
('373', 'Home', 'f45b385f-4a48-4579-9413-8c3fa4812dcb', '2026-04-19 14:39:54.642'),
('374', 'Home', '4112a135-a046-42d8-8974-50fb7c6be5b5', '2026-04-19 14:39:55.222'),
('375', 'Home', 'ac2f1584-3bd3-4085-8af7-45b7b0a0f230', '2026-04-19 19:41:42.613'),
('376', 'Home', 'c2f3bb02-dee6-477f-a7f2-8248ca635986', '2026-04-20 01:23:23.9'),
('377', 'Home', 'a7255e66-8dae-4f08-a0e8-0c7a2c14eb08', '2026-04-20 02:13:24.791'),
('378', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-21 01:58:23.466'),
('379', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-21 01:58:58.167'),
('380', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-21 01:59:08.728'),
('381', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-21 01:59:17.294'),
('382', 'Home', '5dcbe090-a39c-4489-8791-e911e18316eb', '2026-04-21 12:47:39.989'),
('383', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-22 04:50:52.173'),
('384', 'Home', '4a276ff6-d65f-4df6-a64f-9f235254111b', '2026-04-22 15:28:44.529'),
('385', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-23 01:15:21.173'),
('386', 'Home', '7cbc2620-7d58-4edb-a2f5-54eb32a4d006', '2026-04-24 10:04:34.274'),
('387', 'Home', '7cbc2620-7d58-4edb-a2f5-54eb32a4d006', '2026-04-24 10:05:29.071'),
('388', 'Home', '7cbc2620-7d58-4edb-a2f5-54eb32a4d006', '2026-04-24 10:08:07.456'),
('389', 'Home', '02f8a0b6-c6c9-49ed-9e7a-e84115ea2031', '2026-04-25 05:21:15.403'),
('390', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-04-27 02:44:39.557'),
('391', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-27 07:48:49.241'),
('392', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-27 07:49:51.885'),
('393', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-27 07:51:43.989'),
('394', 'Home', '493c6ba9-ef61-4c18-b9fb-3179b7a226d7', '2026-04-27 07:52:44.914'),
('395', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-28 01:04:24.697'),
('396', 'Home', '65178772-7b79-491f-9e4a-f7463b0c9064', '2026-04-28 01:46:59.431'),
('397', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-28 01:53:19.49'),
('398', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-04-28 01:53:47.562'),
('399', 'Home', '65178772-7b79-491f-9e4a-f7463b0c9064', '2026-04-28 01:54:01.099'),
('400', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-28 01:54:13.929'),
('401', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-04-28 01:54:16.327'),
('402', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-04-28 01:55:26.858'),
('403', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-04-28 01:55:45.572'),
('404', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-04-28 01:57:31.206'),
('405', 'Home', 'fe31c17e-8df0-49d1-a589-31a08cba9e56', '2026-04-28 01:58:01.82'),
('406', 'Home', 'fe31c17e-8df0-49d1-a589-31a08cba9e56', '2026-04-28 01:59:46.439'),
('407', 'Home', '65178772-7b79-491f-9e4a-f7463b0c9064', '2026-04-28 02:05:55.284'),
('408', 'Home', '65178772-7b79-491f-9e4a-f7463b0c9064', '2026-04-28 02:11:20.431'),
('409', 'Home', '4173f63f-c03c-4186-88a6-2f6a477b76a7', '2026-04-28 02:11:33.525'),
('410', 'Home', '65178772-7b79-491f-9e4a-f7463b0c9064', '2026-04-28 02:16:10.035'),
('411', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-28 02:23:18.755'),
('412', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 02:43:52.657'),
('413', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:02:16.726'),
('414', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:18:44.815'),
('415', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:20:19.513'),
('416', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:26:50.97'),
('417', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:30:11.21'),
('418', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:31:46.14'),
('419', 'Home', 'ee3ac370-f8e1-462b-a28f-dbdd9393c42b', '2026-04-28 03:51:17.486'),
('420', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 03:58:50.554'),
('421', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-04-28 04:12:58.888'),
('422', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 05:11:28.66'),
('423', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-28 05:14:05.521'),
('424', 'Home', '052c82bf-f52a-4dfe-8bd3-5cbbcf4e9332', '2026-04-28 05:23:43.461'),
('425', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-29 05:06:56.596'),
('426', 'Home', '5239ef4f-0997-4731-bce6-617e8c6b01f0', '2026-04-29 05:07:40.602'),
('427', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-29 05:07:54.575'),
('428', 'Home', '5239ef4f-0997-4731-bce6-617e8c6b01f0', '2026-04-29 05:08:15.241'),
('429', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-29 06:35:41.925'),
('430', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-04-29 06:46:24.236'),
('431', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-04-29 07:45:42.814'),
('432', 'Home', 'e5660ee1-6ace-4434-995a-398d3c453b40', '2026-04-30 03:03:52.78'),
('433', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-04-30 04:17:40.474'),
('434', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-04-30 05:28:17.949'),
('435', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-04-30 05:32:12.768'),
('436', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:34:21.445'),
('437', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:36:04.638'),
('438', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:36:17.882'),
('439', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:36:26.465'),
('440', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:41:26.809'),
('441', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:41:56.798'),
('442', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:42:02.244'),
('443', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-04-30 06:42:32.43'),
('444', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-04-30 06:53:15.449'),
('445', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-04-30 06:54:08.55'),
('446', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-04-30 06:54:31.607'),
('447', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-04-30 06:54:52.144'),
('448', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:34:11.087'),
('449', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:34:43.557'),
('450', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:35:11.435'),
('451', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:35:37.844'),
('452', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:35:46.035'),
('453', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:35:59.345'),
('454', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:36:10.704'),
('455', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 08:36:23.167'),
('456', 'Home', 'f333199a-9063-49d3-9e9f-da32ab26b173', '2026-04-30 12:34:49.275'),
('457', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:11:35.955'),
('458', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:15:19.293'),
('459', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:15:24.138'),
('460', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:36:30.068'),
('461', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:38:56.615'),
('462', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:40:53.024'),
('463', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:41:41.482'),
('464', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:43:06.419'),
('465', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 16:46:17.243'),
('466', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:18:31.438'),
('467', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:23:19.143'),
('468', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:37:36.996'),
('469', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:37:57.123'),
('470', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:40:38.326'),
('471', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-04-30 17:44:43.335'),
('472', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-04-30 19:43:40.703'),
('473', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-04-30 19:44:26'),
('474', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-04-30 19:45:17.587'),
('475', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-04-30 19:45:27.206'),
('476', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-04-30 19:45:46.254'),
('477', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-05-01 06:00:37.136'),
('478', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-05-01 06:03:41.594'),
('479', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-05-03 09:15:37.964'),
('480', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-05-03 09:22:57.774'),
('481', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-05-03 09:28:27.061'),
('482', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-05-03 09:29:16.412'),
('483', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 10:03:51.305'),
('484', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 10:22:41.321'),
('485', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 10:59:46.216'),
('486', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:10:48.932'),
('487', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:21:50.666'),
('488', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:23:23.169'),
('489', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:24:02.992'),
('490', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:24:14.271'),
('491', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:24:40.883'),
('492', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:29:01.375'),
('493', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:29:50.013'),
('494', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:30:26.284'),
('495', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-03 11:33:59.439'),
('496', 'Home', '1a5b022e-4e9b-4ee4-abd1-8f86ed720604', '2026-05-03 11:52:20.717'),
('497', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:12:43.165'),
('498', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:13:00.185'),
('499', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:13:21.451'),
('500', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:13:39.875'),
('501', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:14:16.52'),
('502', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:14:30.241'),
('503', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:14:39.564'),
('504', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:15:05.005'),
('505', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:16:04.514'),
('506', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:16:37.217'),
('507', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:16:59.214'),
('508', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:17:09.219'),
('509', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:17:45.844'),
('510', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:17:52.464'),
('511', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:18:22.459'),
('512', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:18:38.987'),
('513', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:18:50.953'),
('514', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:18:54.312'),
('515', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:19:22.246'),
('516', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:20:48.239'),
('517', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:22:36.141'),
('518', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:23:22.279'),
('519', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:23:31.006'),
('520', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:24:19.656'),
('521', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:24:36.647'),
('522', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-04 01:25:08.359'),
('523', 'Home', '745ebef7-c41b-43aa-bb58-2a34988618e4', '2026-05-04 01:32:46.449'),
('524', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-05-04 01:32:50.493'),
('525', 'Home', '82889493-df2e-4219-8b77-fd0a8627dcf5', '2026-05-04 01:34:59.816'),
('526', 'Home', '0b799dfd-f7e8-4465-b707-034b90ab2d2d', '2026-05-04 01:35:29.902'),
('527', 'Home', '1b8b01ae-06c2-470c-bbf8-dcfc9fe6a313', '2026-05-04 01:36:43.228'),
('528', 'Home', '82889493-df2e-4219-8b77-fd0a8627dcf5', '2026-05-04 01:38:00.96'),
('529', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-05-04 01:39:35.298'),
('530', 'Home', '29ea4d08-3fca-4ccc-b97a-b68974eea7b6', '2026-05-04 01:40:27.834'),
('531', 'Home', '1d186eba-f3cf-4610-bfb0-e88a2b33ecc0', '2026-05-04 01:40:54.679'),
('532', 'Home', '1545f18d-e76c-4ce4-a72a-f268fb9df2a3', '2026-05-04 01:42:38.189'),
('533', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-05-04 01:43:07.798'),
('534', 'Home', '1545f18d-e76c-4ce4-a72a-f268fb9df2a3', '2026-05-04 01:43:41.066'),
('535', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-04 01:48:35.935'),
('536', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-05-04 01:57:54.404'),
('537', 'Home', 'b70cb78e-ba1c-4460-bc6c-183d343e2e67', '2026-05-04 02:06:18.164'),
('538', 'Home', 'e8b71ecb-20eb-4a16-8f76-8525bc6092d5', '2026-05-04 02:11:20.248'),
('539', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 02:18:23.844'),
('540', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 02:18:48.748'),
('541', 'Home', 'd6e3fe69-fea1-456a-8e48-bad34599b0cf', '2026-05-04 02:20:45.013'),
('542', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 02:34:59.195'),
('543', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-05-04 02:36:59.811'),
('544', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 02:38:34.146'),
('545', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:39:58.794'),
('546', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:42:26.326'),
('547', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:43:21.636'),
('548', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:45:45.259'),
('549', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 02:47:08.443'),
('550', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:48:16.393'),
('551', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:48:48.655'),
('552', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:49:29.99'),
('553', 'Home', '0f87d95d-c2c2-430a-b641-9c6419090758', '2026-05-04 02:49:54.95'),
('554', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 03:25:26.454'),
('555', 'Home', 'd6e3fe69-fea1-456a-8e48-bad34599b0cf', '2026-05-04 03:34:31.118'),
('556', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:44:33.775'),
('557', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:46:35.494'),
('558', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:47:48.78'),
('559', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:49:12.626'),
('560', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:50:50.599'),
('561', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 04:52:14.271'),
('562', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:52:21.987'),
('563', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 04:53:00.644'),
('564', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 04:54:15.786'),
('565', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 04:55:24.667'),
('566', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 04:57:23.559'),
('567', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 05:01:21.542'),
('568', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 05:02:30.258'),
('569', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:02:49.217'),
('570', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:04:06.499'),
('571', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:04:08.103'),
('572', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-04 05:05:16.087'),
('573', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:05:36.739'),
('574', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:10:30.713'),
('575', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:10:55.229'),
('576', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-04 05:11:47.355'),
('577', 'Home', '496561b9-b9d2-414f-8cdd-8a9585bdb94e', '2026-05-04 05:31:19.96'),
('578', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 07:18:07.245'),
('579', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 07:18:35.245'),
('580', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-04 07:19:06.315'),
('581', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:32:35.847'),
('582', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:33:00.495'),
('583', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:33:08.576'),
('584', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:33:28.5'),
('585', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 02:42:16.597'),
('586', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:42:26.901'),
('587', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 02:44:52.668'),
('588', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 02:45:00.478'),
('589', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 02:47:50.122'),
('590', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:50:28.332'),
('591', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 02:50:28.334'),
('592', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 02:52:23.146'),
('593', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:01:14.703'),
('594', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:01:37.128'),
('595', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:01:52.025'),
('596', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:02:28.617'),
('597', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:02:55.892'),
('598', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:05:04.513'),
('599', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-05 03:05:12.72'),
('600', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 03:05:21.453'),
('601', 'Home', '4b6f8636-007e-44db-b450-4d9743bdff2c', '2026-05-05 03:06:21.336'),
('602', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-05-05 03:06:50.551'),
('603', 'Home', '2309ae55-19e9-4bc1-8e33-0ccbc955aebd', '2026-05-05 03:06:52.669'),
('604', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 03:13:03.808'),
('605', 'Home', '845b8855-ca54-430e-a7d6-6f5948c1e5eb', '2026-05-05 03:26:55.87'),
('606', 'Home', '845b8855-ca54-430e-a7d6-6f5948c1e5eb', '2026-05-05 03:28:19.112'),
('607', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-05 03:45:26.391'),
('608', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-05-05 03:57:35.57'),
('609', 'Home', '845b8855-ca54-430e-a7d6-6f5948c1e5eb', '2026-05-05 03:57:45.18'),
('610', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 05:21:23.136'),
('611', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 07:12:57.488'),
('612', 'Home', '4e3ba45b-ef44-47c3-bc5d-ca1d83ca7c42', '2026-05-05 08:05:29.752'),
('613', 'Home', '309403aa-c248-44ff-aa18-f82f8fac2357', '2026-05-05 08:05:30.745'),
('614', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-05 09:47:56.573'),
('615', 'Home', '5590cc7c-d9cf-470a-87cc-fe9f6c9896dc', '2026-05-05 11:22:34.989'),
('616', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 14:55:25.295'),
('617', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 14:57:39.866'),
('618', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 15:04:09.68'),
('619', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 15:04:10.628'),
('620', 'Home', 'bbc83d38-90a9-42e5-abaf-71a79c78a4eb', '2026-05-05 16:41:28.111'),
('621', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-05 17:07:01.732'),
('622', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-06 01:45:22.709'),
('623', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-06 10:55:26.899'),
('624', 'Home', 'e815459c-2910-4634-ba20-9c5feaad92db', '2026-05-06 12:28:07.021'),
('625', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 03:30:30.572'),
('626', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 03:31:08.67'),
('627', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 03:34:27.198'),
('628', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:10:48.584'),
('629', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:04.531'),
('630', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:15.465'),
('631', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:22.831'),
('632', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:37.023'),
('633', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:42.693'),
('634', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:11:52.102'),
('635', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:12:03.882'),
('636', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-07 08:12:17.152'),
('637', 'Home', '598b9352-2233-42ff-92e3-8db69aa15b24', '2026-05-08 21:29:11.664'),
('638', 'Home', '798c60ed-f64d-4858-9b2c-e7a2182914c3', '2026-05-10 01:39:46.421'),
('639', 'Home', 'a278e8dc-6125-4558-9e7d-ae17ef65f975', '2026-05-10 01:40:11.767'),
('640', 'Home', '29a1f95c-fd71-460e-b4f4-d5e9342ec1ff', '2026-05-10 01:40:13.454'),
('641', 'Home', '76e1ba66-32b9-495f-b972-7f17f972ac02', '2026-05-10 14:29:51.091'),
('642', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-10 15:40:09.767'),
('643', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-10 16:32:39.569'),
('644', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-11 02:17:39.32'),
('645', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-11 02:18:43.026'),
('646', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-11 02:18:59.883'),
('647', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-11 02:19:19.507'),
('648', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-05-11 04:20:09.522'),
('649', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-05-11 04:44:29.125'),
('650', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-05-12 03:57:38.613'),
('651', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:21:57.317'),
('652', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:22:29.215'),
('653', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:23:13.677'),
('654', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:24:21.994'),
('655', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:24:27.416'),
('656', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:24:32.248'),
('657', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:24:41.327'),
('658', 'Home', '66faed17-d2bf-4f26-a187-9acb600b1970', '2026-05-12 10:24:49.41'),
('659', 'Home', 'a738d75e-5106-44a8-8269-342898b93acd', '2026-05-12 11:28:06.349'),
('660', 'Home', 'a738d75e-5106-44a8-8269-342898b93acd', '2026-05-12 11:28:27.338'),
('661', 'Home', 'b0a8f147-1e06-4c9d-9893-65c015f3eed8', '2026-05-12 11:28:36.153'),
('662', 'Home', 'a738d75e-5106-44a8-8269-342898b93acd', '2026-05-12 11:28:59.02'),
('663', 'Home', '5ca276c9-58a7-401b-875f-0d6d81c9b737', '2026-05-12 11:30:35.637'),
('664', 'Home', 'f7d49ce5-f007-433d-a8de-de005cca1504', '2026-05-12 14:33:13.956'),
('665', 'Home', 'fe3f231a-0f61-4b27-9b49-bb469ce7407f', '2026-05-13 07:07:21.528'),
('666', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-17 09:11:59.778'),
('667', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-05-17 09:12:19.999'),
('668', 'Home', '9583ca06-3b34-4742-b7a5-6ad4aadb6f45', '2026-05-18 03:16:47.758'),
('669', 'Home', '137834ab-f0f0-4b76-ad4b-630b3afcf13f', '2026-05-18 18:47:10.33'),
('670', 'Home', '431ce852-1b87-4fce-a246-f4bfc23afd15', '2026-05-19 16:38:59.109'),
('671', 'Home', '18d15e32-92ea-447d-b636-7ea52bfa118b', '2026-05-20 13:10:51'),
('672', 'Home', 'c6824ce3-ba80-4e7f-8088-7f2999a6c3bd', '2026-05-21 02:42:35.953'),
('673', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-05-21 02:42:40.221'),
('674', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:45:04.07'),
('675', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:45:18.178'),
('676', 'Home', 'ce07da6d-d51c-4e13-be1f-0785a45173fb', '2026-05-21 02:45:51.798'),
('677', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:46:16.824'),
('678', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-05-21 02:46:37.759'),
('679', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:46:47.802'),
('680', 'Home', 'ce07da6d-d51c-4e13-be1f-0785a45173fb', '2026-05-21 02:47:01.39'),
('681', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:47:07.145'),
('682', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-05-21 02:48:01.459'),
('683', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:49:26.664'),
('684', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 02:56:17.249'),
('685', 'Home', 'ee3ac370-f8e1-462b-a28f-dbdd9393c42b', '2026-05-21 03:17:26.883'),
('686', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:28:11.903'),
('687', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:34:31.107'),
('688', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:34:45.158'),
('689', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:39:35.263'),
('690', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:41:32.679'),
('691', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:42:16.309'),
('692', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:43:55.425'),
('693', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:48:54.678'),
('694', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:49:00.117'),
('695', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:53:18.918'),
('696', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:57:58.676'),
('697', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 04:59:38.12'),
('698', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 05:10:16.344'),
('699', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 05:13:59.864'),
('700', 'Home', '38066954-48c8-44b8-a7fc-f211b7fbf42d', '2026-05-21 05:14:59.343'),
('701', 'Home', '38066954-48c8-44b8-a7fc-f211b7fbf42d', '2026-05-21 05:15:36.537'),
('702', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 05:20:57.299'),
('703', 'Home', '8ac6a5c8-556a-46d2-8f9e-35095dac94e8', '2026-05-21 05:27:30.46'),
('704', 'Home', '38066954-48c8-44b8-a7fc-f211b7fbf42d', '2026-05-21 05:28:33.703'),
('705', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-05-21 05:43:45.645'),
('706', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-05-21 05:45:32.105'),
('707', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-05-21 05:47:56.293'),
('708', 'Home', '4a6af6ba-775f-4e7f-b159-f119a92ed29b', '2026-05-21 05:48:10.179'),
('709', 'Home', '45232e0a-f38b-43f3-90cd-d004531c3725', '2026-05-21 06:17:05.085'),
('710', 'Home', '9949a544-8816-48bd-a89b-fb58ed1ab9e7', '2026-05-21 06:17:06.036'),
('711', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-21 22:31:30.414'),
('712', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-22 01:17:43.431'),
('713', 'Home', '9b3504eb-80d1-4968-b2b2-5c4593058203', '2026-05-22 02:18:31.009'),
('714', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-05-22 04:02:02.163'),
('715', 'Home', 'edb006f3-f96f-4e67-8287-26bab8d045c8', '2026-05-22 04:58:33.49'),
('716', 'Home', 'edb006f3-f96f-4e67-8287-26bab8d045c8', '2026-05-22 04:58:33.491'),
('717', 'Home', '71be093a-a805-4a42-bbef-c88ad371bb9d', '2026-05-23 03:39:02.036'),
('718', 'Home', '6764c273-b7b4-44f6-a096-84000a981131', '2026-05-23 03:46:54.72'),
('719', 'Home', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', '2026-05-23 07:48:38.313'),
('720', 'Home', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', '2026-05-23 07:49:29.774'),
('721', 'Home', '0c2d29a7-5953-4577-857f-4809ee520583', '2026-05-23 09:49:14.782'),
('722', 'Home', '7988e75f-9249-4ea1-a669-ea3cf88db2e2', '2026-05-23 20:15:02.293'),
('723', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-05-24 12:37:42.6'),
('724', 'Home', '14c8cf99-d07a-432d-806d-dbb79c506a69', '2026-05-24 20:06:23.955'),
('725', 'Home', '5761d08c-b51e-46c2-8948-9991b86c1e48', '2026-05-24 20:07:14.169'),
('726', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 01:13:16.217'),
('727', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 01:13:18.821'),
('728', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 01:29:09.881'),
('729', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 01:29:28.375'),
('730', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 02:13:28.649'),
('731', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 02:14:55.081'),
('732', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-25 02:51:53.819'),
('733', 'Home', '873fa615-179d-4bf6-8752-ed4533bd55f4', '2026-05-25 02:57:19.401'),
('734', 'Home', 'd5863f91-92e4-4102-bd0d-a49cbf60fbd3', '2026-05-25 03:35:38.374'),
('735', 'Home', '3f7ec401-7d47-49db-a007-ca79c7bf8448', '2026-05-25 03:53:47.99'),
('736', 'Home', 'd5863f91-92e4-4102-bd0d-a49cbf60fbd3', '2026-05-25 06:17:18.322'),
('737', 'Home', 'd5863f91-92e4-4102-bd0d-a49cbf60fbd3', '2026-05-26 05:26:33.003'),
('738', 'Home', '69ee3959-1681-4fca-8641-1c7981635bef', '2026-05-27 14:41:52.991'),
('739', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-30 08:10:21.034'),
('740', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-30 08:12:45.805'),
('741', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-05-30 08:14:04.82'),
('742', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-05-31 13:34:18.746'),
('743', 'Home', '5e6f9238-f99b-4b01-8dc1-ee9a7331ffd9', '2026-05-31 16:02:52.871'),
('744', 'Home', 'd4dc9d71-b3fb-4878-9f04-047a2a65510d', '2026-05-31 16:02:54.012'),
('745', 'Home', '49cf0080-358f-4409-80c2-13dc51ae62e5', '2026-06-01 15:30:57.238'),
('746', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-06-01 23:53:57.379'),
('747', 'Home', '0b535c4b-ec3e-46d3-9c0c-1ffebe20d9cf', '2026-06-03 03:35:19.528'),
('748', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-06-03 09:02:53.183'),
('749', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-06-03 09:04:14.795'),
('750', 'Home', '46ac6e49-63fb-4f64-b891-d19ea1d05dd3', '2026-06-03 18:24:42.188'),
('751', 'Home', 'fa38da91-55d0-401e-911e-947f8e090cc5', '2026-06-04 02:29:42.592'),
('752', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-04 02:54:01.119'),
('753', 'Home', 'c9d53cd1-7c92-4de7-97bc-7f3be41f282d', '2026-06-04 12:40:22.098'),
('754', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-05 07:10:12.755'),
('755', 'Home', '7825a28a-2a07-46c6-8cfe-34ecb6b6bfcd', '2026-06-06 09:14:53.843'),
('756', 'Home', '39f41327-4ce8-4d07-9f2c-efc1b73c88c2', '2026-06-06 09:14:53.855'),
('757', 'Home', '0b535c4b-ec3e-46d3-9c0c-1ffebe20d9cf', '2026-06-08 02:05:11.41'),
('758', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-08 03:42:42.952'),
('759', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-08 04:19:44.169'),
('760', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-08 06:19:08.753'),
('761', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-08 06:31:19.59'),
('762', 'Home', '76959704-30ab-4085-b279-624adb04a87f', '2026-06-08 07:14:46.653'),
('763', 'Home', '897ef352-2b13-4aed-9395-0a61cd940bdf', '2026-06-08 07:47:13.156'),
('764', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-09 02:55:49.863'),
('765', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:03:38.482'),
('766', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:07:42.475'),
('767', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:16:41.608'),
('768', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:17:22.774'),
('769', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:18:02.296'),
('770', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:18:37.316'),
('771', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:23:23.921'),
('772', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:27:49.675'),
('773', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 04:29:44.16'),
('774', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 05:22:50.806'),
('775', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 05:24:16.505'),
('776', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 05:27:47.421'),
('777', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-06-09 05:40:32.706'),
('778', 'Home', '2fa89ffe-df22-4471-98e9-7e08fa9dafdb', '2026-06-10 01:25:23.455'),
('779', 'Home', '0b535c4b-ec3e-46d3-9c0c-1ffebe20d9cf', '2026-06-10 01:44:35.841'),
('780', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-10 01:54:42.129'),
('781', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-06-10 02:00:40.536'),
('782', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-06-10 04:16:09.641'),
('783', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-10 05:04:45.601'),
('784', 'Home', 'a9cdd67b-ba1c-4af5-add9-a10364c22726', '2026-06-10 06:17:57.052'),
('785', 'Home', 'a9cdd67b-ba1c-4af5-add9-a10364c22726', '2026-06-10 06:18:17.006'),
('786', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-06-10 06:55:39.658'),
('787', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-06-10 06:58:54.075'),
('788', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-06-11 02:58:36.047'),
('789', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-06-11 02:58:56.096'),
('790', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-06-11 04:53:10.577'),
('791', 'Home', '85e19924-d61a-4713-ad60-16a05b687ef6', '2026-06-13 02:04:21.963'),
('792', 'Home', '321d4eb0-e56f-49d7-81ea-e7a303aca59a', '2026-06-14 11:43:35.561'),
('793', 'Home', '717e6b36-15ed-4c5f-b0af-94ffc1c63d0f', '2026-06-14 11:44:10.202'),
('794', 'Home', 'effd2fd5-7d42-44e0-9ec4-0c3be62a0d6b', '2026-06-14 11:44:10.795'),
('795', 'Home', '58404b13-ff4b-45c7-9458-dcb3da54cb07', '2026-06-14 23:46:56.072'),
('796', 'Home', '46c9f744-1ebd-4840-925b-488294a00c84', '2026-06-15 08:23:28.555'),
('797', 'Home', '1568f140-e9a9-4d38-8e40-f465e4368b08', '2026-06-17 16:12:06.751'),
('798', 'Home', '1568f140-e9a9-4d38-8e40-f465e4368b08', '2026-06-17 16:12:29.503'),
('799', 'Home', '1568f140-e9a9-4d38-8e40-f465e4368b08', '2026-06-17 16:12:45.666'),
('800', 'Home', 'd6e3fe69-fea1-456a-8e48-bad34599b0cf', '2026-06-19 08:54:18.768'),
('801', 'Home', 'dc92f326-c6b3-47d4-8ef6-0687342f0c4e', '2026-06-20 21:41:44.168'),
('802', 'Home', 'ef667b87-c15a-41fa-9b77-528f383e5dc7', '2026-06-21 15:42:04.159'),
('803', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-23 07:05:11.382'),
('804', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-23 07:06:08.598'),
('805', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-23 07:07:29.094'),
('806', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-23 07:07:54.865'),
('807', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-23 08:34:52.572'),
('808', 'Home', '632408d3-1e81-4a7e-981a-82f32ada1071', '2026-06-25 13:57:11.208'),
('809', 'Home', '9244a351-ee79-4131-96dd-5a98bce7b3a4', '2026-06-26 03:50:32.92'),
('810', 'Home', '8aa0e8e9-ca22-45fb-a1a9-59fd8026811c', '2026-06-26 03:50:33.988'),
('811', 'Home', 'da0e0bca-6669-4a84-8e33-cf88b8ac037b', '2026-06-26 14:25:18.967'),
('812', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-06-29 02:43:12.49'),
('813', 'Home', '8cb50e0a-bf92-41be-8a37-5528d082aed4', '2026-06-30 09:29:41.618'),
('814', 'Home', '1fd2120e-2fac-483c-bb71-107637bf45de', '2026-07-01 08:24:42.945'),
('815', 'Home', 'ea2df3cf-9aeb-4009-8274-5c0456533b46', '2026-07-02 00:58:43.685'),
('816', 'Home', '213d268a-2942-4089-b7dc-cda1f78a7374', '2026-07-03 03:16:35.051'),
('817', 'Home', '48f894dd-8cd2-48bc-94a7-04c3ea402749', '2026-07-03 07:11:09.665'),
('818', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-03 18:24:14.214'),
('819', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-03 18:26:03.945'),
('820', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-03 18:27:44.496'),
('821', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-03 18:28:40.772'),
('822', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-03 20:04:21.606'),
('823', 'Home', '5a2190cb-ace7-43aa-adba-133ca180588f', '2026-07-04 01:04:08.478'),
('824', 'Home', '1d70bb42-dda8-42ad-bb74-6768cf258b59', '2026-07-05 23:37:31.726'),
('825', 'Home', 'a15d86ad-5cfd-4673-91bc-0c3b9b7aa936', '2026-07-06 09:11:28.986'),
('826', 'Home', 'c199d2cd-abfb-4ced-82f8-75300fb87cfb', '2026-07-07 12:24:58.086'),
('827', 'Home', 'e4afcb95-30d4-4bf2-bf52-15ba2b6b9554', '2026-07-08 15:57:40.885'),
('828', 'Home', 'e4afcb95-30d4-4bf2-bf52-15ba2b6b9554', '2026-07-08 16:00:57.263'),
('829', 'Home', 'e4afcb95-30d4-4bf2-bf52-15ba2b6b9554', '2026-07-08 16:01:10.616'),
('830', 'Home', '63cc34b9-446d-4004-938b-b2f28fd86cd0', '2026-07-09 02:11:29.217'),
('831', 'Home', '8bfc6aab-2093-49c5-b060-a92af795545f', '2026-07-09 04:13:07.655'),
('832', 'Home', '8bfc6aab-2093-49c5-b060-a92af795545f', '2026-07-09 04:13:52.312'),
('833', 'Home', 'e4afcb95-30d4-4bf2-bf52-15ba2b6b9554', '2026-07-09 04:16:29.529'),
('834', 'Home', '63cc34b9-446d-4004-938b-b2f28fd86cd0', '2026-07-09 04:21:28.355'),
('835', 'Home', '63cc34b9-446d-4004-938b-b2f28fd86cd0', '2026-07-09 04:28:23.065'),
('836', 'Home', '8bfc6aab-2093-49c5-b060-a92af795545f', '2026-07-09 04:32:41.313'),
('837', 'Home', '8bfc6aab-2093-49c5-b060-a92af795545f', '2026-07-09 04:49:57.479'),
('838', 'Home', '3301f03b-85e7-4d29-964e-cf7e5493b87f', '2026-07-12 04:10:56.251'),
('839', 'Home', 'ada3309c-6540-4594-a4f9-391badde524e', '2026-07-12 04:10:57.035'),
('840', 'Home', '4ba8a81b-8426-484e-b9b5-2bf543fa2bd8', '2026-07-12 05:50:35.686'),
('841', 'Home', '4ba8a81b-8426-484e-b9b5-2bf543fa2bd8', '2026-07-12 05:51:44.95'),
('842', 'Home', '4ba8a81b-8426-484e-b9b5-2bf543fa2bd8', '2026-07-12 05:52:40.725'),
('843', 'Home', '4ba8a81b-8426-484e-b9b5-2bf543fa2bd8', '2026-07-12 05:52:50.04'),
('844', 'Home', '2fc888ad-4b95-44af-afcb-479f7b46eb56', '2026-07-12 07:22:20.775'),
('845', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-07-12 12:46:21.271'),
('846', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-07-12 12:47:29.341'),
('847', 'Home', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', '2026-07-13 03:11:18.151'),
('848', 'Home', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', '2026-07-13 03:44:16.655'),
('849', 'Home', '9c4aa737-5487-4f9b-b56a-b796e3a64540', '2026-07-13 05:33:23.656'),
('850', 'Home', '9e4e7ca8-eaec-4e42-87a6-d7321459b312', '2026-07-13 07:13:38.447'),
('851', 'Home', 'fb6c95ee-43bd-4c60-9a68-490af64d574b', '2026-07-14 03:29:02.774'),
('852', 'Home', 'd014913e-196d-4f81-81ca-e89a6dc7bf2f', '2026-07-15 03:08:56.975'),
('853', 'Home', 'f9100d3a-e310-49c8-8800-1a4b511e2dca', '2026-07-16 11:35:05.3'),
('854', 'Home', 'a6ec5421-895b-4721-9e6f-a0713dc5be99', '2026-07-17 01:32:41.081'),
('855', 'Home', 'bb8aecb4-f438-4e4b-9f51-6e1139873f06', '2026-07-18 11:39:14.024'),
('856', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:22:18.295'),
('857', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:22:33.397'),
('858', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:22:59.19'),
('859', 'Home', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', '2026-07-19 04:23:22.058'),
('860', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:23:44.866'),
('861', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:24:22.925'),
('862', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-19 04:24:56.2'),
('863', 'Home', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', '2026-07-19 04:26:27.101'),
('864', 'Home', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', '2026-07-19 06:47:25.888'),
('865', 'Home', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', '2026-07-19 06:48:06.244'),
('866', 'Home', '1ed53115-f1ab-4e66-a141-a6392b18aa8e', '2026-07-19 06:48:20.676'),
('867', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-20 08:01:07.846'),
('868', 'Home', 'd23e2218-aaa1-4f45-b75a-5a0ea6837fd8', '2026-07-20 09:00:40.08'),
('869', 'Home', 'd23e2218-aaa1-4f45-b75a-5a0ea6837fd8', '2026-07-20 09:04:18.102'),
('870', 'Home', 'd23e2218-aaa1-4f45-b75a-5a0ea6837fd8', '2026-07-20 09:04:22.21'),
('871', 'Home', '5fc6aff7-d4e7-49cb-9b84-ca14e992f71d', '2026-07-20 23:28:21.276'),
('872', 'Home', 'c690fa40-5988-4550-bb1c-31c525b64150', '2026-07-21 03:26:45.007'),
('873', 'Home', 'fa91aed1-60d9-4e4c-8c62-9ffd67778de6', '2026-07-21 03:36:11.527'),
('874', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-21 11:31:37.734'),
('875', 'Home', 'a96b0e96-96c7-4541-91a1-98e4608f19a4', '2026-07-21 11:31:46.322'),
('876', 'Home', 'a96b0e96-96c7-4541-91a1-98e4608f19a4', '2026-07-21 11:32:10.447'),
('877', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-21 11:32:23.961'),
('878', 'Home', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', '2026-07-21 11:32:39.431'),
('879', 'Home', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', '2026-07-21 11:33:14.093'),
('880', 'Home', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', '2026-07-21 11:34:07.357'),
('881', 'Home', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', '2026-07-21 11:34:26.05'),
('882', 'Home', 'ab6050b4-8e1f-488b-b745-3ce4a640ac0f', '2026-07-21 11:35:31.724'),
('883', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-21 11:35:49.633'),
('884', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-21 11:35:54.749'),
('885', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-21 11:36:25.458'),
('886', 'Home', '8aee794c-2eba-4896-9536-29c2da2fb4ee', '2026-07-22 02:59:11.021'),
('887', 'Home', '23f085d3-9fe9-42be-b66b-90eece1b06f3', '2026-07-22 03:02:45.085'),
('888', 'Home', '23f085d3-9fe9-42be-b66b-90eece1b06f3', '2026-07-22 03:36:03.859'),
('889', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-07-22 08:43:03.665'),
('890', 'Home', '71be093a-a805-4a42-bbef-c88ad371bb9d', '2026-07-22 20:48:22.533'),
('891', 'Home', '5a0af7e8-e9be-46ad-8beb-835a8dfaf7ba', '2026-07-22 23:49:46.673'),
('892', 'Home', '6caa1eb3-8e25-4b3a-85bf-ebd97fb12266', '2026-07-24 01:26:20.443'),
('893', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-24 04:50:55.077'),
('894', 'Home', '680c9d2c-bb8e-422d-9d99-bc7195236681', '2026-07-24 14:32:40.607'),
('895', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-25 05:56:21.325'),
('896', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-25 06:02:42.256'),
('897', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-07-25 09:40:47.739'),
('898', 'Home', '79f1d32c-1ae1-4b1d-be17-3e659647945d', '2026-07-25 18:21:07.458'),
('899', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-26 01:47:01.59'),
('900', 'Home', '8a63e3b1-50a3-4563-8604-323677581478', '2026-07-26 02:55:49.688'),
('901', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-26 11:34:55.441'),
('902', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-26 14:41:52.945'),
('903', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-26 14:44:01.19'),
('904', 'Home', '47fdec5e-c978-45d3-928e-3bf486b4ffe0', '2026-07-26 15:29:47.378'),
('905', 'Home', 'ac7e4334-6930-40f5-9a23-8469558521fa', '2026-07-27 04:15:01.581'),
('906', 'Home', 'ac7e4334-6930-40f5-9a23-8469558521fa', '2026-07-27 04:15:36.263'),
('907', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-07-27 04:53:01.781'),
('908', 'Home', 'e89187cb-0513-4a0a-82d1-546f9c7da943', '2026-07-27 05:40:03.584'),
('909', 'Home', 'e89187cb-0513-4a0a-82d1-546f9c7da943', '2026-07-27 05:41:00.759'),
('910', 'Home', 'ac7e4334-6930-40f5-9a23-8469558521fa', '2026-07-27 05:44:42.771'),
('911', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-07-27 06:11:48.543'),
('912', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-07-27 06:13:10.906'),
('913', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-07-27 06:13:18.611'),
('914', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-07-27 06:43:08.129'),
('915', 'Home', 'ec4b1e96-a580-4cbe-bceb-98d3c73fa564', '2026-07-27 15:30:23.3'),
('916', 'Home', 'aac1f164-08a5-435b-97ca-16b3d0ae71fd', '2026-07-28 03:42:33.818'),
('917', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-28 09:35:33.64'),
('918', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-07-28 09:35:49.108'),
('919', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-07-29 02:13:01.362'),
('920', 'Home', '4ba02842-b8bd-4e79-a1bc-9453de45ee92', '2026-07-29 02:54:15.696'),
('921', 'Home', 'c8d3d4b3-9a43-4640-ab4d-be3f82f85669', '2026-07-29 11:06:50.517'),
('922', 'Home', 'c8d3d4b3-9a43-4640-ab4d-be3f82f85669', '2026-07-29 11:07:40.548'),
('923', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-07-31 10:04:45.823'),
('924', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-07-31 10:05:04.708'),
('925', 'Home', '4fa8d911-b9d8-4527-8443-b7041c34c7f0', '2026-07-31 10:58:30.568'),
('926', 'Home', '3a5375ef-a133-41b3-8afb-57b5f13f122a', '2026-07-31 14:08:28.857'),
('927', 'Home', '335e41e4-90c6-4d21-9891-c7ffce566e73', '2026-07-31 14:08:29.648'),
('928', 'Home', '90627271-7714-43a2-b052-402229b9de1c', '2026-08-02 22:39:29.897'),
('929', 'Home', '614e4ef9-200c-41ca-9112-96f68496b0fb', '2026-08-03 00:32:34.768'),
('930', 'Home', 'dbb40839-e4b9-434b-a082-1ad6f1e2bdbc', '2026-08-03 00:32:42.154'),
('931', 'Home', 'c164ee57-1f8c-477c-a343-e3a4b873df1f', '2026-08-03 00:33:10.522'),
('932', 'Home', '614e4ef9-200c-41ca-9112-96f68496b0fb', '2026-08-03 00:33:38.207'),
('933', 'Home', '614e4ef9-200c-41ca-9112-96f68496b0fb', '2026-08-03 00:35:19.892'),
('934', 'Home', '35ed3d9d-8d51-46ed-a601-30a48dac1a33', '2026-08-03 00:45:04.565'),
('935', 'Home', '35ed3d9d-8d51-46ed-a601-30a48dac1a33', '2026-08-03 00:47:15.111'),
('936', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-03 01:11:03.171'),
('937', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-08-03 03:45:15.203'),
('938', 'Home', '12cdedbe-672b-4dd6-ade3-3907c1819039', '2026-08-03 03:46:33.495'),
('939', 'Home', 'f3a469bc-ebd6-4e1e-9706-ec236c1fb3b5', '2026-08-04 04:42:50.901'),
('940', 'Home', '1997b8c4-0e46-4323-b3fe-420dc299118f', '2026-08-04 16:43:53.742'),
('941', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-05 02:51:56.493'),
('942', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-08-05 02:52:30.451'),
('943', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-08-05 02:53:09.642'),
('944', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-05 02:53:28.498'),
('945', 'Home', 'd02af506-cb81-4904-b877-2cf996988364', '2026-08-05 02:53:54.331'),
('946', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-05 03:00:00.28'),
('947', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-08-05 05:13:42.858'),
('948', 'Home', '00c55c0d-737c-42d6-b79d-a5e12a6825ff', '2026-08-05 05:18:34.597'),
('949', 'Home', '00c55c0d-737c-42d6-b79d-a5e12a6825ff', '2026-08-05 05:22:28.012'),
('950', 'Home', '938eb48c-9725-4387-a8bb-def662110de8', '2026-08-05 05:23:05.42'),
('951', 'Home', '00c55c0d-737c-42d6-b79d-a5e12a6825ff', '2026-08-05 05:25:12.343'),
('952', 'Home', '00c55c0d-737c-42d6-b79d-a5e12a6825ff', '2026-08-05 05:26:28.823'),
('953', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-08-05 05:30:14.597'),
('954', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-08-05 05:30:29.881'),
('955', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-08-05 05:30:46.766'),
('956', 'Home', '89972c5f-7903-4a12-91da-caac900f9db5', '2026-08-05 12:54:55.001'),
('957', 'Home', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', '2026-08-05 15:29:49.296'),
('958', 'Home', '35a86bbb-9af1-4c5f-bb61-68653bd3353c', '2026-08-06 00:14:59.342'),
('959', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 00:16:13.036'),
('960', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 00:16:50.806'),
('961', 'Home', 'bbfb8289-4569-4d33-a7e1-264e8aadd01b', '2026-08-06 02:22:21.795'),
('962', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 03:28:08.659'),
('963', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 03:33:15.364'),
('964', 'Home', '67efdc58-1abb-40a9-8136-d73f19cfc9bc', '2026-08-06 04:00:10.341'),
('965', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-06 04:12:24.709'),
('966', 'Home', '4c54ca7d-2ffd-466c-83f0-dd0a363b447d', '2026-08-06 04:12:26.95'),
('967', 'Home', '67efdc58-1abb-40a9-8136-d73f19cfc9bc', '2026-08-06 04:13:10.802'),
('968', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-06 04:13:51.135'),
('969', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-06 04:14:27.28'),
('970', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-08-06 04:30:28.399'),
('971', 'Home', 'ac7e4334-6930-40f5-9a23-8469558521fa', '2026-08-06 04:54:21.12'),
('972', 'Home', 'ac7e4334-6930-40f5-9a23-8469558521fa', '2026-08-06 04:59:36.259'),
('973', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-06 05:02:24.228'),
('974', 'Home', '67efdc58-1abb-40a9-8136-d73f19cfc9bc', '2026-08-06 05:42:12.871'),
('975', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-06 06:09:01.232'),
('976', 'Home', '7b3c6b19-0bc6-4802-ade4-a2fe6f888e72', '2026-08-06 06:11:06.626'),
('977', 'Home', '7b3c6b19-0bc6-4802-ade4-a2fe6f888e72', '2026-08-06 06:11:46.668'),
('978', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:14:08.882'),
('979', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:16:19.944'),
('980', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:16:27.695'),
('981', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 06:16:56.554'),
('982', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:17:21.214'),
('983', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:17:23.901'),
('984', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:17:27.194'),
('985', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 06:18:02.697'),
('986', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-06 07:30:30.994'),
('987', 'Home', '1e2ea5b0-9916-4e04-96a3-4fe00f188381', '2026-08-06 08:03:00.789'),
('988', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-06 08:09:14.437'),
('989', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-06 08:54:09.795'),
('990', 'Home', '35ed3d9d-8d51-46ed-a601-30a48dac1a33', '2026-08-06 09:03:29.383'),
('991', 'Home', '99dd6433-3325-4d19-8a64-a5fc0bae6dc4', '2026-08-06 09:04:32.9'),
('992', 'Home', '6a3810e5-1974-47ba-a202-e06dfe9641d8', '2026-08-06 09:52:17.935'),
('993', 'Home', 'bbfb8289-4569-4d33-a7e1-264e8aadd01b', '2026-08-06 10:38:50.83'),
('994', 'Home', '79a5fe24-e146-4319-9f67-aab5fd70b081', '2026-08-06 13:30:57.6'),
('995', 'Home', '6a3810e5-1974-47ba-a202-e06dfe9641d8', '2026-08-06 13:48:32.076'),
('996', 'Home', '89972c5f-7903-4a12-91da-caac900f9db5', '2026-08-06 16:21:24.762'),
('997', 'Home', '0819bcf2-da3e-4b59-a1c3-d83d2c427dab', '2026-08-06 22:09:56.603'),
('998', 'Home', 'b04c4a01-fe59-43be-9f83-9cf9bdfbb092', '2026-08-07 00:39:00.893'),
('999', 'Home', 'b04c4a01-fe59-43be-9f83-9cf9bdfbb092', '2026-08-07 00:39:07.798'),
('1000', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-07 02:18:32.876'),
('1001', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-07 02:21:11.016'),
('1002', 'Home', '213d268a-2942-4089-b7dc-cda1f78a7374', '2026-08-07 06:46:31.388'),
('1003', 'Home', '5bf71bf4-1cc7-4c52-8454-5c8349b538db', '2026-08-07 07:01:31.756'),
('1004', 'Home', '213d268a-2942-4089-b7dc-cda1f78a7374', '2026-08-07 07:04:26.883'),
('1005', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-08-08 02:09:05.745'),
('1006', 'Home', '0819bcf2-da3e-4b59-a1c3-d83d2c427dab', '2026-08-08 03:14:44.313'),
('1007', 'Home', '614e4ef9-200c-41ca-9112-96f68496b0fb', '2026-08-08 06:08:58.246'),
('1008', 'Home', 'cabfad5d-bf03-4df1-8715-e11829679799', '2026-08-08 08:28:27.062'),
('1009', 'Home', 'dc13c2d6-2e8d-4a56-8f12-74c47745a550', '2026-08-08 09:39:44.572'),
('1010', 'Home', 'e61cd19e-3e60-4ed3-91ff-13cc8079fa95', '2026-08-08 15:32:40.759'),
('1011', 'Home', '7a0b6759-01d4-4807-91d9-146036d1cc54', '2026-08-09 07:08:34.288'),
('1012', 'Home', '72c57eea-b6d8-4ead-9374-6ed3d3ac53dd', '2026-08-11 00:54:41.175'),
('1013', 'Home', '26023b92-50df-47cc-bcc2-aaeb0292a3ea', '2026-08-11 05:39:01.754'),
('1014', 'Home', '95711971-abf8-4546-ac6d-745af4e67d2e', '2026-08-11 10:19:46.725'),
('1015', 'Home', '2ef6cead-44a0-49e2-9294-3b7855c95eac', '2026-08-11 13:13:10.232'),
('1016', 'Home', 'fc8a7b88-68db-4fa9-966b-437ac4e0c30e', '2026-08-11 14:59:42.688'),
('1017', 'Home', 'cae7da7f-d2b1-4078-9c60-5cf172424dbb', '2026-08-11 15:03:30.06'),
('1018', 'Home', '05eb77d4-7772-4d63-967a-614b5221898c', '2026-08-12 01:33:43.605'),
('1019', 'Home', '31825993-6fa9-46f6-9bc7-3d9d316fa995', '2026-08-12 09:07:28.782'),
('1020', 'Home', '01ab0122-5c1b-4267-8aff-bc46776faa99', '2026-08-15 05:00:29.268'),
('1021', 'Home', '01ab0122-5c1b-4267-8aff-bc46776faa99', '2026-08-15 05:01:23.452'),
('1022', 'Home', '30a530d6-fd53-414b-82df-75ce95c3362e', '2026-08-17 09:51:15.405'),
('1023', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-18 09:11:57.998'),
('1024', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-18 09:12:43.291'),
('1025', 'Home', 'c58c5919-73d3-4060-968d-84a5f3b45670', '2026-08-18 09:13:22.936'),
('1026', 'Home', '89972c5f-7903-4a12-91da-caac900f9db5', '2026-08-18 12:56:19.888'),
('1027', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 18:59:59.36'),
('1028', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 19:00:58.53'),
('1029', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 19:01:23.003'),
('1030', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 19:01:36.804'),
('1031', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 19:03:29.381'),
('1032', 'Home', '8396e71e-098f-4876-8237-06b3a10dfc7b', '2026-08-18 19:03:43.843'),
('1033', 'Home', 'a0c0c069-52e6-4ec2-941d-da4fb28b6d6a', '2026-08-18 21:15:37.802'),
('1034', 'Home', 'a0c0c069-52e6-4ec2-941d-da4fb28b6d6a', '2026-08-18 21:16:42.71'),
('1035', 'Home', 'a0c0c069-52e6-4ec2-941d-da4fb28b6d6a', '2026-08-18 21:18:53.027'),
('1036', 'Home', 'a0c0c069-52e6-4ec2-941d-da4fb28b6d6a', '2026-08-18 21:19:17.967'),
('1037', 'Home', '0e404fd3-9a72-40a1-877b-97efae74db2f', '2026-08-19 02:11:34.779'),
('1038', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 02:19:29.618'),
('1039', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 02:21:18.817'),
('1040', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 02:21:48.979'),
('1041', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 02:22:08.34'),
('1042', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-08-19 05:39:27.977'),
('1043', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-08-19 05:40:39.929'),
('1044', 'Home', '87e3b2c8-0acd-476d-ad42-d4da2cbbcc5a', '2026-08-19 05:42:40.183'),
('1045', 'Home', '8c48757f-d520-4546-a3c6-4cc01832bfb3', '2026-08-19 12:51:02.966'),
('1046', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:45:16.928'),
('1047', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:45:49.135'),
('1048', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:46:51.045'),
('1049', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:47:06.616'),
('1050', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:47:38.973'),
('1051', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:48:55.557'),
('1052', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:48:57.154'),
('1053', 'Home', 'fcaabba8-4368-44b2-87e5-95e5b0b220c2', '2026-08-19 19:48:58.329'),
('1054', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 22:57:28.249'),
('1055', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 23:06:21.722'),
('1056', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 23:07:38.855'),
('1057', 'Home', 'b5ba8873-05c1-4bcb-a2dc-db472140fa17', '2026-08-19 23:09:25.504'),
('1058', 'Home', 'b5ba8873-05c1-4bcb-a2dc-db472140fa17', '2026-08-19 23:13:26.675'),
('1059', 'Home', '7d5070e8-90f6-4bf2-a393-67c148feec2e', '2026-08-19 23:13:35.153'),
('1060', 'Home', '8aa98fcb-9d3e-48d1-a39a-13e760c5cb3d', '2026-08-19 23:15:05.334'),
('1061', 'Home', '7d5070e8-90f6-4bf2-a393-67c148feec2e', '2026-08-19 23:15:38.398'),
('1062', 'Home', 'c77974b5-289d-4481-a7f7-8b95d70586dd', '2026-08-19 23:17:01.251'),
('1063', 'Home', 'beaeef52-b1e9-46e6-b9f6-e8dd1b0df570', '2026-08-19 23:19:04.265'),
('1064', 'Home', 'e3b8b79e-b4b5-4540-808c-96fd75e547a1', '2026-08-19 23:19:54.04'),
('1065', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-19 23:27:41.649'),
('1066', 'Home', '08a1b9d3-9bb2-48fe-a9cf-60a17921d8d9', '2026-08-19 23:33:17.365'),
('1067', 'Home', '08a1b9d3-9bb2-48fe-a9cf-60a17921d8d9', '2026-08-19 23:35:23.254'),
('1068', 'Home', '08a1b9d3-9bb2-48fe-a9cf-60a17921d8d9', '2026-08-19 23:35:23.706'),
('1069', 'Home', '08a1b9d3-9bb2-48fe-a9cf-60a17921d8d9', '2026-08-19 23:36:43.894'),
('1070', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-19 23:47:21.623'),
('1071', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-19 23:48:22.029'),
('1072', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-19 23:48:49.608'),
('1073', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-19 23:49:17.304'),
('1074', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-19 23:49:48.357'),
('1075', 'Home', '47f4c2bd-2f46-407f-b431-1a0b20d9fa0d', '2026-08-20 00:04:40.964'),
('1076', 'Home', '4fad2e72-4073-43a3-9aa2-a2dab8561382', '2026-08-20 00:10:34.007'),
('1077', 'Home', '146ca0a5-befb-483a-8522-daa8a61209db', '2026-08-20 00:11:27.928'),
('1078', 'Home', '1899f0f7-0bc9-4b18-ab99-b7465aa75aec', '2026-08-20 01:34:45.258'),
('1079', 'Home', '467c688b-22e1-46ba-990a-011c16aa91a9', '2026-08-21 12:08:05.761'),
('1080', 'Home', 'cc611959-2b5c-4625-9308-c1df0a488430', '2026-08-22 09:24:41.346'),
('1081', 'Home', 'ac5f98a1-ee95-412c-9013-844e098ebbf3', '2026-08-22 19:05:05.492'),
('1082', 'Home', '3107d7fd-784b-40d3-9d29-fc2e795caacf', '2026-08-22 19:05:06.036'),
('1083', 'Home', '95003ce1-37d7-4886-8929-386657f3c5f3', '2026-08-24 06:35:17.319'),
('1084', 'Home', '4ade0100-a6a2-4035-89a6-4f9aaf219f9b', '2026-08-24 09:50:48.536'),
('1085', 'Home', '03224d60-6f5a-4eff-b161-a3d91d026677', '2026-08-25 15:45:03.934'),
('1086', 'Home', '5e49c99a-4090-4e10-b09c-030317775d05', '2026-08-26 02:08:12.616'),
('1087', 'Home', 'aa7ca2ca-388d-4758-8b4e-0b548f82a382', '2026-08-26 06:09:39.474'),
('1088', 'Home', '8afd0116-7a41-4c73-820b-129cafcc3a73', '2026-08-26 09:35:04.593'),
('1089', 'Home', '8afd0116-7a41-4c73-820b-129cafcc3a73', '2026-08-26 09:36:22.052'),
('1090', 'Home', '8afd0116-7a41-4c73-820b-129cafcc3a73', '2026-08-26 09:37:55.067'),
('1091', 'Home', '8afd0116-7a41-4c73-820b-129cafcc3a73', '2026-08-26 09:38:07.115'),
('1092', 'Home', 'e74e1f84-d766-4d3b-9d05-60138547040a', '2026-08-26 14:31:30.53'),
('1093', 'Home', 'b5fa8ca5-e18a-4e46-bdbc-23b2d54b1461', '2026-08-26 18:26:43.441'),
('1094', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:00:46.353'),
('1095', 'Home', '1f77e496-1fa2-44e0-84f8-fe2b409cbe73', '2026-08-27 03:01:23.815'),
('1096', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:02:16.439'),
('1097', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:03:50.982'),
('1098', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:04:51.956'),
('1099', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:05:41.543'),
('1100', 'Home', '621ff57d-435d-46f1-9e64-a23ecb6bdcc1', '2026-08-27 03:05:46.204'),
('1101', 'Home', 'beb6e649-61f4-4983-ab92-bfc49f5b299f', '2026-08-27 03:05:51.242'),
('1102', 'Home', 'd736fb46-40b4-4802-8b7e-b5cdffbc073e', '2026-08-27 12:09:15.575'),
('1103', 'Home', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', '2026-08-30 09:55:31.847'),
('1104', 'Home', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', '2026-08-30 09:58:09.464'),
('1105', 'Home', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', '2026-08-30 09:58:30.862'),
('1106', 'Home', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', '2026-08-30 10:00:33.697'),
('1107', 'Home', 'f34d37ae-b8a8-40c6-823a-2749d16c6620', '2026-08-30 10:01:13.598'),
('1108', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 01:19:47.129'),
('1109', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 01:20:23.771'),
('1110', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 01:21:00.536'),
('1111', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 01:21:22.909'),
('1112', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:46:42.515'),
('1113', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:52:11.752'),
('1114', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:53:23.881'),
('1115', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 01:54:10.289'),
('1116', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 01:54:31.544'),
('1117', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:55:13.064'),
('1118', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:56:03.921'),
('1119', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 01:59:07.772'),
('1120', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:00:55.401'),
('1121', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:01:00.354'),
('1122', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:02:05.949'),
('1123', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:02:20.78'),
('1124', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:03:03.958'),
('1125', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:04:56.769'),
('1126', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-31 02:05:51.697'),
('1127', 'Home', '24c2d018-ac5c-47ea-a97b-2c6f4246c980', '2026-08-31 02:06:17.584'),
('1128', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:06:20.396'),
('1129', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 02:06:28.696'),
('1130', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:06:31.385'),
('1131', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:06:36.371'),
('1132', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:07:34.188'),
('1133', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:07:34.929'),
('1134', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:07:40.279'),
('1135', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:08:00.932'),
('1136', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:08:02.845'),
('1137', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-31 02:08:12.73'),
('1138', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-08-31 02:08:45.544'),
('1139', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:08:53.317'),
('1140', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:10:03.246'),
('1141', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-08-31 02:11:44.352'),
('1142', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-08-31 02:14:36.816'),
('1143', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-08-31 02:15:33.407'),
('1144', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:25:56.873'),
('1145', 'Home', '4ce63151-2bb3-4e1b-b5d2-07ab124ec05a', '2026-08-31 02:29:11.236'),
('1146', 'Home', '7bf9ac75-9b35-4e32-bb08-97c88d4d82b6', '2026-08-31 02:31:10.457'),
('1147', 'Home', '7bf9ac75-9b35-4e32-bb08-97c88d4d82b6', '2026-08-31 02:31:39.485'),
('1148', 'Home', '7bf9ac75-9b35-4e32-bb08-97c88d4d82b6', '2026-08-31 02:32:24.336'),
('1149', 'Home', '7bf9ac75-9b35-4e32-bb08-97c88d4d82b6', '2026-08-31 02:34:46.277'),
('1150', 'Home', '8d74051c-f117-4b09-bbfa-02ddc340eb3f', '2026-08-31 02:56:07.253'),
('1151', 'Home', '34d1deec-fed3-46ec-80f6-bbeeddb71ff4', '2026-08-31 07:23:55.948'),
('1152', 'Home', '00f4dae0-9765-41fa-a5ea-68b6b6c358a7', '2026-09-01 00:32:27.286'),
('1153', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 04:16:55.985'),
('1154', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 05:45:15.865'),
('1155', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 05:45:36.318'),
('1156', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 05:46:04.873'),
('1157', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 05:47:25.257'),
('1158', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-01 05:49:41.295'),
('1159', 'Home', '511de449-f3ae-4f3e-935a-7dbe9fc678e0', '2026-09-01 11:54:36.582'),
('1160', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-02 03:29:12.9'),
('1161', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-02 04:07:28.871'),
('1162', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-09-03 00:55:41.71'),
('1163', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-09-03 01:03:16.326'),
('1164', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-03 01:09:17.373'),
('1165', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-09-03 01:11:16.591'),
('1166', 'Home', 'ba76689a-4adb-4795-be1d-e71d0c118c08', '2026-09-03 01:22:24.458'),
('1167', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-03 07:24:20.538'),
('1168', 'Home', '212c3397-bf8d-43e0-8926-451e5cc39f91', '2026-09-03 13:17:32.947'),
('1169', 'Home', '88217ff2-45b6-43d2-b2c2-a6735b3572f5', '2026-09-03 13:17:33.094'),
('1170', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-03 14:27:00.697'),
('1171', 'Home', '44fc2ce5-4f89-4362-ab22-53416285dca6', '2026-09-03 19:21:35.287'),
('1172', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-04 02:28:47.247'),
('1173', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-04 02:39:03.529'),
('1174', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-04 06:14:01.787'),
('1175', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-04 06:40:55.792'),
('1176', 'Home', 'f33c2f38-9fda-4873-a61d-7c81b46d3306', '2026-09-04 13:34:15.364'),
('1177', 'Home', 'ac4a2b56-2ac3-4d15-b2c7-1332d6be10ad', '2026-09-04 13:35:55.917'),
('1178', 'Home', '9e5623a4-197e-4ec7-8381-9d7530aafb93', '2026-09-04 13:35:56.717'),
('1179', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-07 01:45:08.649'),
('1180', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-07 01:51:07.044'),
('1181', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-07 01:52:37.247'),
('1182', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-07 01:53:28.858'),
('1183', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-07 01:54:33.892'),
('1184', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-07 03:04:43.126'),
('1185', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-07 03:07:16.117'),
('1186', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-07 03:07:36.642'),
('1187', 'Home', 'ba76689a-4adb-4795-be1d-e71d0c118c08', '2026-09-07 03:35:56.442'),
('1188', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-07 03:38:47.099'),
('1189', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-07 03:45:21.256'),
('1190', 'Home', '92ecce48-bad9-4a19-9d04-b83ea77a470b', '2026-09-07 04:16:04.63'),
('1191', 'Home', '8e025f8a-1d80-4d59-81d9-78da5a8dbcb3', '2026-09-07 07:45:46.63'),
('1192', 'Home', '1336a300-7acb-4d26-844c-b1bd983cc257', '2026-09-07 12:22:04.877'),
('1193', 'Home', 'c3790f9d-4497-4d54-9ad6-f4a9995b7a77', '2026-09-07 23:20:15.507'),
('1194', 'Home', 'c3790f9d-4497-4d54-9ad6-f4a9995b7a77', '2026-09-07 23:20:32.209'),
('1195', 'Home', 'fa9fc867-bb83-4568-8f4a-099680ca1cca', '2026-09-08 01:18:11.951'),
('1196', 'Home', 'ba76689a-4adb-4795-be1d-e71d0c118c08', '2026-09-08 01:20:38.869'),
('1197', 'Home', 'fa9fc867-bb83-4568-8f4a-099680ca1cca', '2026-09-08 01:22:07.058'),
('1198', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-09-08 02:39:07.251'),
('1199', 'Home', '449b8319-d723-4c1d-a39e-9497007072e7', '2026-09-08 10:43:35.099'),
('1200', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-08 23:54:20.794'),
('1201', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-08 23:56:18.18'),
('1202', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:02:20.038'),
('1203', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:18:47.588'),
('1204', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:20:51.782'),
('1205', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:24:44.342'),
('1206', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:25:05.628'),
('1207', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:29:35.835'),
('1208', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:31:11.18'),
('1209', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:41:26.996'),
('1210', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:46:28.321'),
('1211', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:52:14.85'),
('1212', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:53:33.628'),
('1213', 'Home', '296e8cb0-bcdd-40bf-8833-50ee8bf958fe', '2026-09-09 00:54:40.819'),
('1214', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-09-09 01:47:07.587'),
('1215', 'Home', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', '2026-09-09 01:50:28.157'),
('1216', 'Home', '212a7a72-f02f-4909-94af-18ca386b14bd', '2026-09-09 01:50:48.017'),
('1217', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-09-09 01:51:14.778'),
('1218', 'Home', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', '2026-09-09 01:58:19.672'),
('1219', 'Home', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', '2026-09-09 02:02:15.87'),
('1220', 'Home', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', '2026-09-09 02:04:02.51'),
('1221', 'Home', 'a7113a70-8e32-4fe7-b7a6-2a96eb27b89c', '2026-09-09 02:05:54.667'),
('1222', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-09-09 02:08:01.326'),
('1223', 'Home', 'e5acf53a-28c8-4af8-8663-fb6d319bcde0', '2026-09-09 07:42:11.221'),
('1224', 'Home', 'b1393b8c-50b6-4dcf-bb25-bcdf1ad6c9ec', '2026-09-09 07:43:34.797'),
('1225', 'Home', 'dbf55474-c719-47c0-ae75-b21f3951ff90', '2026-09-09 09:07:55.216'),
('1226', 'Home', '91d01b1a-6837-4cc4-b03e-9fa7ab79eef5', '2026-09-09 09:14:00.489'),
('1227', 'Home', '6a6261bc-2e6e-4ae8-8ebe-30c038067de6', '2026-09-09 13:19:57.183'),
('1228', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-09-10 01:26:28.765'),
('1229', 'Home', '1bb984db-c32a-432a-9106-1e88f09a2bb5', '2026-09-10 01:27:01.986'),
('1230', 'Home', 'c03e66e2-7348-4100-85ce-5b7854ed6d96', '2026-09-10 16:27:55.245'),
('1231', 'Home', '1425ed61-5626-4c53-b661-028c5a2298ec', '2026-09-10 16:29:21.666'),
('1232', 'Home', '85781ed5-8110-44c2-aefa-905fca22b635', '2026-09-11 10:03:52.057'),
('1233', 'Home', '673581ca-8e02-47ba-9541-9eeb6716ff09', '2026-09-11 10:06:33.811'),
('1234', 'Home', '41867026-b5f3-4b92-ad7d-2836090e9b5e', '2026-09-11 22:56:11.489'),
('1235', 'Home', '212a7a72-f02f-4909-94af-18ca386b14bd', '2026-09-12 04:24:25.535'),
('1236', 'Home', '96f2d13a-5c8d-4d74-a2f3-6082bc8805b1', '2026-09-12 13:08:29.857'),
('1237', 'Home', '3af85923-da43-44a5-ade6-eccd69c76bd1', '2026-09-12 20:14:18.411'),
('1238', 'Home', 'e2c409c0-6582-4a88-92be-4b4437390fc5', '2026-09-13 23:29:13.589'),
('1239', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-09-14 06:49:56.794'),
('1240', 'Home', '9c5f23f5-483d-41aa-9baa-640065c748d5', '2026-09-14 06:52:50.213'),
('1241', 'Home', '38832c03-6fe3-4f59-bed2-eaa24a478625', '2026-09-14 07:09:15.076'),
('1242', 'Home', '35a86bbb-9af1-4c5f-bb61-68653bd3353c', '2026-09-14 13:16:06.835'),
('1243', 'Home', '35a86bbb-9af1-4c5f-bb61-68653bd3353c', '2026-09-14 13:17:02.06'),
('1244', 'Home', '7f6401ef-778b-4c48-9fb7-1f38a2a71094', '2026-09-14 21:52:21.968'),
('1245', 'Home', 'dfc6948e-e14e-4222-9cf4-80d343a03a5e', '2026-09-15 06:54:57.196'),
('1246', 'Home', 'dfc6948e-e14e-4222-9cf4-80d343a03a5e', '2026-09-15 06:55:13.28'),
('1247', 'Home', 'dfc6948e-e14e-4222-9cf4-80d343a03a5e', '2026-09-15 06:55:40.195'),
('1248', 'Home', 'ae35b62a-9e52-4f4a-8400-5d2874b61b4d', '2026-09-16 00:54:41.971'),
('1249', 'Home', '216e4923-0a3b-4332-8653-68e86b7e2895', '2026-09-16 05:04:31.636'),
('1250', 'Home', '4f4bfd81-df48-46f1-ada9-9c1e1ab38904', '2026-09-16 05:53:17.829'),
('1251', 'Home', '054267f3-fd83-44cc-a6f8-7f1405052931', '2026-09-16 06:35:46.504'),
('1252', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-16 06:38:52.024'),
('1253', 'Home', '054267f3-fd83-44cc-a6f8-7f1405052931', '2026-09-16 06:39:38.524'),
('1254', 'Home', '054267f3-fd83-44cc-a6f8-7f1405052931', '2026-09-16 06:47:09.597'),
('1255', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-17 01:28:35.076'),
('1256', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-17 03:19:49.52'),
('1257', 'Home', '24c2d018-ac5c-47ea-a97b-2c6f4246c980', '2026-09-17 03:21:18.311'),
('1258', 'Home', '24c2d018-ac5c-47ea-a97b-2c6f4246c980', '2026-09-17 03:21:58.66'),
('1259', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-17 03:25:09.407'),
('1260', 'Home', '652a10cc-cd53-4e3e-acd0-50d7e02d7968', '2026-09-17 03:30:26.506'),
('1261', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:30:52.889'),
('1262', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:32:31.946'),
('1263', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:33:06.944'),
('1264', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:33:38.255'),
('1265', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:34:03.217'),
('1266', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:34:08.009'),
('1267', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:35:17.52'),
('1268', 'Home', '3f2d4218-4dbf-4695-88e3-e481609992f7', '2026-09-17 03:35:27.102'),
('1269', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-09-17 03:43:13.72'),
('1270', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-09-17 03:52:17.801'),
('1271', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-09-17 03:53:26.833'),
('1272', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-09-17 03:56:56.019'),
('1273', 'Home', 'e29818ef-215b-4a5e-9aa5-c024678c5c55', '2026-09-17 03:58:28.525'),
('1274', 'Home', '24c2d018-ac5c-47ea-a97b-2c6f4246c980', '2026-09-17 04:57:06.082'),
('1275', 'Home', '71be093a-a805-4a42-bbef-c88ad371bb9d', '2026-09-17 08:17:29.991'),
('1276', 'Home', '71be093a-a805-4a42-bbef-c88ad371bb9d', '2026-09-17 08:17:44.655'),
('1277', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-17 08:48:35.901'),
('1278', 'Home', '212a7a72-f02f-4909-94af-18ca386b14bd', '2026-09-17 22:02:09.488'),
('1279', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-18 05:16:05.47'),
('1280', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-18 13:24:21.752'),
('1281', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-18 13:25:43.697'),
('1282', 'Home', 'fbb826ae-4f12-4d33-87ea-45f1e2b152a2', '2026-09-18 21:52:58.929'),
('1283', 'Home', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', '2026-09-19 06:05:44.953'),
('1284', 'Home', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', '2026-09-19 07:22:23.577'),
('1285', 'Home', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', '2026-09-19 07:25:33.536'),
('1286', 'Home', 'e80db049-a776-45ba-86e3-6f106b5b41b7', '2026-09-19 08:44:43.946'),
('1287', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-20 09:13:17.783'),
('1288', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 03:40:31.712'),
('1289', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 04:14:16.909'),
('1290', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 04:27:10.094'),
('1291', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 04:50:44.716'),
('1292', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 05:54:58.459'),
('1293', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:00:11.44'),
('1294', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:00:51.193'),
('1295', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:01:09.03'),
('1296', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:01:35.048'),
('1297', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:01:47.283'),
('1298', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:18:34.409'),
('1299', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 06:55:56.215'),
('1300', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 07:07:52.926'),
('1301', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 07:28:01.3'),
('1302', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 07:45:41.957'),
('1303', 'Home', '3888b088-dbfe-42de-a080-5a6d0d0425ef', '2026-09-21 07:55:54.946'),
('1304', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-21 17:23:21.775'),
('1305', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 00:10:40.249'),
('1306', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 01:31:59.788'),
('1307', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 01:32:06.282'),
('1308', 'Home', 'f4ab4d1d-f8b1-4a63-b26f-66c0bd996e83', '2026-09-22 02:25:46.088'),
('1309', 'Home', '0e404b63-52d7-4e69-9271-04e0f4fe27b5', '2026-09-22 02:55:04.74'),
('1310', 'Home', 'a2c66a28-012b-410b-8798-5ba0fab23ec9', '2026-09-22 02:56:02.737'),
('1311', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 05:40:16.186'),
('1312', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 05:40:30.802'),
('1313', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 05:40:42.47'),
('1314', 'Home', '35a86bbb-9af1-4c5f-bb61-68653bd3353c', '2026-09-22 06:20:17.713'),
('1315', 'Home', '0e404b63-52d7-4e69-9271-04e0f4fe27b5', '2026-09-22 06:28:53.605'),
('1316', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 06:36:12.632'),
('1317', 'Home', '0e404b63-52d7-4e69-9271-04e0f4fe27b5', '2026-09-22 07:36:45.348'),
('1318', 'Home', '16ed285c-3ded-4400-9f49-d4de12973903', '2026-09-22 07:40:57.729'),
('1319', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-22 08:23:57.251'),
('1320', 'Home', 'c77b243e-b6f9-4b25-b833-43ed9876e0b9', '2026-09-22 08:25:59.745'),
('1321', 'Home', 'b7b8a6ad-7f1f-4143-a614-7ae06e0b54f3', '2026-09-22 08:26:26.797'),
('1322', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:26:56.293'),
('1323', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:28:31.659'),
('1324', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:29:26.104'),
('1325', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:30:15.529'),
('1326', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:30:16.297'),
('1327', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:30:24.537'),
('1328', 'Home', '0e404b63-52d7-4e69-9271-04e0f4fe27b5', '2026-09-22 08:30:58.136'),
('1329', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:31:42.392'),
('1330', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:31:53.207'),
('1331', 'Home', '77f4f9e1-21f8-4b55-b396-f741a04d731c', '2026-09-22 08:31:56.148'),
('1332', 'Home', '0e320dec-88bb-44ff-8203-444199f8c85c', '2026-09-22 08:36:55.887'),
('1333', 'Home', '0e320dec-88bb-44ff-8203-444199f8c85c', '2026-09-22 08:37:56.2'),
('1334', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-22 10:04:04.046'),
('1335', 'Home', '76c6ae9d-6977-457e-9535-3a813f88ad59', '2026-09-22 12:46:13.505'),
('1336', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-23 01:26:08.025'),
('1337', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-23 03:15:38.977'),
('1338', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-23 05:02:03.577'),
('1339', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-23 05:12:34.46'),
('1340', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-23 06:04:06.352'),
('1341', 'Home', '636db11a-9f69-4680-9c50-9a1021635686', '2026-09-24 00:16:35.088'),
('1342', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-24 00:19:19.993'),
('1343', 'Home', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', '2026-09-24 01:41:35.28'),
('1344', 'Home', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', '2026-09-24 03:35:28.681'),
('1345', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-24 03:39:54.677'),
('1346', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-24 04:36:26.074'),
('1347', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-24 04:37:18.921'),
('1348', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-24 04:38:03.972'),
('1349', 'Home', '305ccb17-e6e0-49be-a5d9-606fe68b8abd', '2026-09-25 01:36:09.59'),
('1350', 'Home', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', '2026-09-25 07:27:28.388'),
('1351', 'Home', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', '2026-09-25 07:30:35.649'),
('1352', 'Home', 'c70501b4-6037-4406-8dde-c15daf2b4dcc', '2026-09-25 07:32:09.539'),
('1353', 'Home', 'd3a0d5e4-47e3-443a-9156-5db68f73718f', '2026-09-25 16:01:06.842'),
('1354', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-27 13:45:04.28'),
('1355', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-27 13:45:22.735'),
('1356', 'Home', '4e0a98ad-071a-4a5d-ab57-d0059eb22449', '2026-09-28 01:50:27.719'),
('1357', 'Home', '060d6a84-cfdd-45d6-b671-654b682791e9', '2026-09-28 02:02:44.742');

ALTER TABLE `RumahMakan` ADD CONSTRAINT `RumahMakan_kulinerId_fkey` FOREIGN KEY (`kulinerId`) REFERENCES `Kuliner` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `jarakDesa` ADD CONSTRAINT `jarakDesa_desaId_fkey` FOREIGN KEY (`desaId`) REFERENCES `desaWisata` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `pageView` ADD CONSTRAINT `pageView_visitorId_fkey` FOREIGN KEY (`visitorId`) REFERENCES `Visitor` (`uid`) ON UPDATE CASCADE ON DELETE RESTRICT;
SET FOREIGN_KEY_CHECKS=1;
