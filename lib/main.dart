import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'contact_page.dart';

void main() {
  runApp(const FluxyWeb());
}

class FluxyWeb extends StatelessWidget {
  const FluxyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluxy AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050505),
        primaryColor: Colors.amber,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.purpleAccent,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  // Linkler
  final String _appStoreUrl = "https://apple.com/...";
  final String _playStoreUrl = "https://play.google.com/...";
  final String _privacyUrl = "https://seninsiten.com/privacy";
  final String _termsUrl = "https://seninsiten.com/terms";
  final String _mailUrl = "mailto:destek@fluxyai.com";

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Link açılamadı: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile ? null : _buildWebNavbar(),
      drawer: isMobile ? _buildMobileDrawer() : null,
      body: Stack(
        children: [
          // Arka Plan Deseni
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.network(
                "https://t3.ftcdn.net/jpg/03/53/83/92/360_F_353839266_8yihGle8jV21x4f2Q4f2Q4f2Q4f2Q4f2.jpg",
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                if (isMobile) const SizedBox(height: 60),
                _buildHeroSection(isMobile),
                _buildFeaturesSection(isMobile),
                _buildPerfectGrid(isMobile), // ✨ YENİ DÜZELTİLMİŞ GALERİ
                _buildFooter(isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. HERO SECTION ---
  Widget _buildHeroSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 120,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F0F0F), Colors.transparent],
        ),
      ),
      child: isMobile
          ? Column(children: _heroContent(isMobile))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _heroContent(isMobile),
            ),
    );
  }

  List<Widget> _heroContent(bool isMobile) {
    return [
      Expanded(
        flex: isMobile ? 0 : 3,
        child: FadeInUp(
          duration: const Duration(milliseconds: 800),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: const Text(
                  "✨ Hayal gücünün sınırlarını zorla",
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Kelimelerin\nSanata Dönüşsün",
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  color: Colors.white,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Fluxy AI ile saniyeler içinde benzersiz duvar kağıtları oluştur. İster Cyberpunk, ister Anime, ister 3D Render.",
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 15,
                children: [
                  _storeButton(
                    FontAwesomeIcons.apple,
                    "App Store",
                    "Download on the",
                    _appStoreUrl,
                  ),
                  _storeButton(
                    FontAwesomeIcons.googlePlay,
                    "Google Play",
                    "Get it on",
                    _playStoreUrl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if (!isMobile) const SizedBox(width: 50),
      if (isMobile) const SizedBox(height: 60),

      Expanded(
        flex: isMobile ? 0 : 2,
        child: FadeInRight(
          duration: const Duration(milliseconds: 1000),
          child: Center(
            child: Transform.rotate(
              angle: -0.05,
              child: Container(
                height: isMobile ? 450 : 700,
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.15),
                      blurRadius: 60,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                // MOCKUP GÖRSELİ
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    "assets/app_mockup.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  // --- 2. ÖZELLİKLER ---
  Widget _buildFeaturesSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Neden Fluxy AI?",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Sınırları zorlayan özelliklerle tanışın.",
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _featureCard(
                Icons.play_circle_fill,
                "Reklam İzle & Kazan",
                "Kredin mi bitti? Kısa reklamlar izleyerek anında üretim hakkı kazan.",
              ),
              _featureCard(
                Icons.auto_awesome,
                "Gelişmiş AI Modelleri",
                "Gemini ve Imagen destekli motoruyla hayalindekini tam olarak anlar.",
              ),
              _featureCard(
                Icons.hd,
                "4K Ultra HD",
                "Telefonuna tam uyumlu, kristal netliğinde yüksek çözünürlüklü sonuçlar.",
              ),
              _featureCard(
                Icons.explore,
                "Keşfet & İlham Al",
                "Diğer kullanıcıların oluşturduğu en iyi eserleri incele ve beğen.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc) {
    return HoverCard(
      child: Container(
        width: 280,
        height: 220,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.amber, size: 28),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. GALERİ (DÜZELTİLMİŞ GRID YAPISI) ---
  Widget _buildPerfectGrid(bool isMobile) {
    // 🔥 Buraya 6 adet görselin yolunu yaz
    final List<String> images = [
      "assets/gen_1.png",
      "assets/gen_2.png",
      "assets/gen_3.png",
      "assets/gen_4.png",
      "assets/gen_5.png",
      "assets/gen_6.png",
    ];

    // Masaüstünde 3 sütun (3x2), Mobilde 2 sütun (2x3)
    int crossAxisCount = isMobile ? 2 : 3;

    // Kenar boşlukları (Web'de daha geniş, mobilde dar)
    double horizontalPadding = isMobile ? 20 : 150;
    double spacing = 20;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: horizontalPadding,
      ),
      child: Column(
        children: [
          const Text(
            "Topluluk Eserleri",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Fluxy AI ile oluşturulan bazı şaheserler.",
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true, // Scroll içinde çalışması için
            physics:
                const NeverScrollableScrollPhysics(), // Kendi scroll'unu kapat
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio:
                  9 / 16, // 🔥 DİKEY DUVAR KAĞIDI ORANI (Sabit Boyut)
            ),
            itemBuilder: (context, index) {
              return HoverCard(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover, // 🔥 Görseli kutuya tam doldurur
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- 4. FOOTER ---
  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF050505), // Tam siyah zemin
        border: Border(top: BorderSide(color: Colors.white10)), // İnce üst çizgi
      ),
      child: Column(
        children: [
          // 1. LOGO (Büyütüldü)
          Image.asset('assets/logo.png', height: 80), 
          
          const SizedBox(height: 20),
          
          // 2. MARKA ADI
          const Text(
            "Fluxy AI", 
            style: TextStyle(
              fontSize: 32, 
              fontWeight: FontWeight.bold, 
              letterSpacing: 1.5,
              color: Colors.white
            )
          ),
          const SizedBox(height: 40),

          // 3. LİNKLER (Artık hepsi farklı)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40, // Linkler arası boşluk
            runSpacing: 20, // Alt satıra geçerse boşluk
            children: [
              // Gizlilik Politikası
              _footerLink("Gizlilik Politikası", () => _launch(_privacyUrl)),
              
              // Kullanım Koşulları
              _footerLink("Kullanım Koşulları", () => _launch(_termsUrl)),
              
              // İletişim (Sayfa Yönlendirmesi)
              _footerLink("İletişim", () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ContactPage())
                );
              }),
            ],
          ),
          
          const SizedBox(height: 60),
          
          // 4. TELİF HAKKI
          Text(
            "© 2024 Fluxy AI Team. Tüm hakları saklıdır.", 
            style: TextStyle(color: Colors.grey[600], fontSize: 13)
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  // --- COMPONENTS ---

  PreferredSizeWidget _buildWebNavbar() {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.6),
      elevation: 0,
      title: Row(
        children: [
          const SizedBox(width: 40),
          Image.asset('assets/logo.png', height: 32),
          const SizedBox(width: 12),
          const Text("Fluxy AI", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Özellikler",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {},
          child: const Text("Galeri", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () => _launch(_playStoreUrl),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Hemen İndir",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 60),
      ],
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF101010),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 40),
                  const SizedBox(height: 10),
                  const Text(
                    "Fluxy AI",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.white54),
            title: const Text(
              "Özellikler",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.image, color: Colors.white54),
            title: const Text("Galeri", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.mail, color: Colors.white54),
            title: const Text(
              "İletişim",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context); // Menüyü kapat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _storeButton(
    IconData icon,
    String storeName,
    String subtitle,
    String url,
  ) {
    return InkWell(
      onTap: () => _launch(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 32),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black87, fontSize: 11),
                ),
                Text(
                  storeName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Basit bir Hover Efekti
class HoverCard extends StatefulWidget {
  final Widget child;
  const HoverCard({super.key, required this.child});
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0),
        child: widget.child,
      ),
    );
  }
}
