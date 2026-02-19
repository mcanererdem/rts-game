# MVP — Yol Haritası ve Hızlı Uygulama Planı

## 🎯 Hedef
- Çalışır, akıcı ve görsel olarak çekici bir “Arena” deneyimi
- Sword and Sandals hissi: portre, iki karakter, tur bazlı akış

## 📐 Öncelikli İşler (Şimdi)
- Renk sistemini Neon Arena paletine taşı
- Arena layout’u: karakter panelleri + sonuç alanı
- Hamle butonlarını neon palete uyumlu yap
- Maç sonu ekranını ayrı sayfa olarak ekle
- Ses ve haptikleri tur akışına bağla

## 🛠 Dosya Düzeyi İşler
- [app_theme.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/theme/app_theme.dart) → Neon palet ve AppColors merkezi yapı
- [game_screen.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/screens/game/game_screen.dart) → arena yerleşimi, dramatik sonuç gösterimi
- [choice_button.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/screens/game/widgets/choice_button.dart) → mor/cyan/pembe glow ve glassmorphism
- Yeni: [character_panel.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/screens/game/widgets/character_panel.dart) → skor, isim, progress
- Yeni: [match_result_screen.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/screens/match_result/match_result_screen.dart)

## ✅ Hızlı Kazanımlar
- Ayarlar “Verileri Sıfırla” işleminden sonra tema ve toggles anında yenilenir
- Gizlilik/Koşullar/E-posta bağlantıları merkezi sabitlerden yönetilir
  - [app_constants.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/core/constants/app_constants.dart)
- Background ve ikonlar mevcut asset yapısıyla uyumlu
  - [pubspec.yaml](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/pubspec.yaml)

## 🔊 Ses ve Haptik
- Sesler: countdown/win/lose/draw/click
- Haptik: success/error/light
- Bağlandığı yerler:
  - [game_screen.dart](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/lib/presentation/screens/game/game_screen.dart#L56-L113)

## 🎨 Görsel Üretim
- Karakterler ve hamle ikonları için kılavuz:
  - [GORSEL_URETIM_KILAVUZU.md](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/GORSEL_URETIM_KILAVUZU.md)
  - Detay prompt’lar GÖRSEL_URETIM_KILAVUZU içinde özetlenmiştir
- Entegrasyon hedef klasörler:
  - assets/images/characters/
  - assets/images/icons/

## 🚀 Sıralı Uygulama
1. choice_button renk paletlerini Neon Arena ile güncelle
2. character_panel widget’ını ekle ve game_screen’e yerleştir
3. result gösterimini yuvarlak kart + glow ile güçlendir
4. match_result_screen oluştur ve AlertDialog yerine kullan
5. Ses/haptik yoğunluklarını ayarla, 60 FPS test et

## 💰 Monetizasyon Hazırlıkları
- Reklam yerleşimi: Splash/Home/GameResult
- IAP: skin/efekt paketleri (Aşama 3+)
- Yerleşim ve metrikler dokümana eklenecek

## 🧭 İzleme
- Vizyon ve aşamalar: [VIZYON_FINAL.md](file:///c:/src/GWorks/RockPaperScissor/rock_paper_scissors/VIZYON_FINAL.md)
- Arena layout ilerleme notları bu dosyada konsolide edildi

## 🎨 Renk Sistemi — Neon Arena Özeti
- Arka plan: #0F0F23 (dark) → #1A1A2E (surface)
- Primary gradient: #6366F1 → #8B5CF6 (indigo → purple)
- Hamle renkleri:
  - Rock: #7C3AED (purple) — glow: #A78BFA
  - Paper: #0891B2 (cyan) — glow: #22D3EE
  - Scissors: #BE185D (pink) — glow: #F472B6
- Sonuç renkleri:
  - Win: #059669 (emerald) — glow: #34D399
  - Lose: #DC2626 (red) — glow: #F87171
  - Draw: #2563EB (blue) — glow: #60A5FA
  
## 🧱 Arena Layout Checklist
- Üst bilgi: ROUND X / Y
- Sol/sağ CharacterPanel: isim, skor, progress dots, glow
- Orta alan: countdown / VS / sonuç kartı (glow)
- Alt alan: 3 seçim butonu (mor/cyan/pembe)
- 60 FPS performans, animasyonlar: scale/fade/shake

## 🎯 Prompt Özetleri
- Hero idle/victory/defeat: cartoon stylized, blue-purple armor, PNG transparent, 512x512
- Villain idle/victory/defeat: red-black armor, menacing but not scary, PNG transparent, 512x512
- İkonlar: rock/paper/scissors 256x256, transparent, neon glow, dark arka plan uyumlu

## ❓ Kalan Kararlar
- Karakter animasyonu: Statik PNG (şimdi) / Rive (sonra)
- Görseller: Placeholder ile başla, AI üretim hazır olunca entegre et
