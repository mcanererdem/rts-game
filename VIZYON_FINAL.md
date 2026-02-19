# ARENA — Final Vizyon ve Karar Belgesi

> Referans: Swords and Sandals (basitleştirilmiş)
> Portre mod, 2 karakter savaşır, hamle bazlı, turnuva/hikaye modları gelecekte

---

## 🎯 TEMEL VİZYON

### Oyun Döngüsü (Core Loop):
```
1. İki karakter sahneye girer (sol/sağ)
2. Hamle seçimi (3 seçenek: Taş/Kağıt/Makas)
3. İkisi de seçti → Hamle animasyonu
4. Round sonucu → Kazanan / kaybeden reaksiyonu
5. Skor güncellenir
6. Yeni round veya maç biter
7. Maç sonu ekranı (skor, XP, ödül)
```

Basit ama tatmin edici. Her round micro-tatmin, her maç macro-tatmin.

---

## 📐 EKRAN YÖNELİMİ: Portre (Kesin)

**Neden:**
- Tek elle oynanabilir
- Mobil kullanıcı portreye alışkın
- Karakterler üstte, seçim altta — doğal akış
- Mevcut kod zaten portre

**Layout:**
```
Dikey dağılım:
%10 — Üst bilgi (round, süre)
%30 — Karakterler (sol/sağ)
%10 — Son hamle gösterimi
%10 — Round sonucu (dinamik)
%30 — Hamle seçim alanı
%10 — Alt bilgi (vazgeç, vs)
```

---

## 🃏 HAMLE SEÇİMİ: İkon + Minimal Çerçeve

**Seçenek:** Büyük ikon, altında isim, yuvarlak/hafif glassmorphism arka plan.

```
  ╭────────╮
  │   🗿   │  ← Büyük ikon (64x64)
  │  TAŞ   │  ← Küçük text (12px)
  ╰────────╯
   yuvarlak,
   glassmorphism,
   glow (seçilince)
```

3 buton yan yana, eşit aralıklı, ekranın alt %30'unda.

---

## 🎨 GÖRSEL STİL

### Karakter Görselleri:
- **Stil:** Cartoon/stylized (Clash Royale gibi)
- **Boyut:** Orta boy (ekranın %25'i kadar)
- **Poz:** Her karakter 3 poz
  - Normal (idle/ready)
  - Zafer (kazanınca)
  - Yenilgi (kaybedince)
- **Başlangıç:** 2 karakter (Kahraman, Rakip)

### AI ile Üretim:
```
Midjourney/DALL-E/Leonardo.AI

Prompt şablonu:
"2D game character for mobile fighting game,
arena gladiator style,
cartoon stylized art,
[specific character description],
3 poses: idle/victory/defeat,
clean background,
vibrant colors,
mobile game asset quality"
```

Örnek:
```
Hero character: Young warrior, confident stance,
blue-purple armor with glow effects,
friendly but determined expression

Villain character: Dark gladiator, intimidating,
red-black armor, masked face,
menacing but not too scary
```

### Hamle İkonları:
- Custom ikonlar (emoji değil!)
- AI ile üret veya commissioned art
- Tutarlı stil (hepsi aynı artist'ten gibi)
- Taş: Purple-violet glow
- Kağıt: Cyan-blue glow
- Makas: Pink-magenta glow

---

## 📊 ÖZELLİKLER — AŞAMALAR

### AŞAMA 1 — Core Game (4 hafta) ← ŞU AN
**Hedef:** Temel arena oyunu çalışsın, havalı görünsün.

- [ ] Yeni renk sistemi (Neon Gaming)
- [ ] Arena ekranı — Sol/sağ karakter layout
- [ ] 2 karakter görseli (AI ile)
- [ ] Hamle ikonları yenilenmiş
- [ ] Round akışı smooth (geri sayım, reveal, sonuç)
- [ ] Maç sonu ekranı (gerçek ekran, AlertDialog değil)
- [ ] Ana menü yenilenmiş (Arena kapısı hissi)
- [ ] Basit animasyonlar (scale, fade)
- [ ] **Ses dosyaları eklendi** ← Kritik

**Bitti kriteri:**
- Oyun oynandığında "bu farklı" hissettiriyor
- Kullanıcı arkadaşına göstermek istiyor
- 5 kişi test etti, rating ortalama 4+

---

### AŞAMA 2 — Polish & Launch (2 hafta)
**Hedef:** Launch'a hazır kalite.

- [ ] Karakter hamle animasyonları (eğilme, sallanma)
- [ ] Round sonucu efekti (flash, shake)
- [ ] Maç sonu kutlama (confetti, poz değişimi)
- [ ] Ses efektleri çalışıyor (6 ses)
- [ ] Haptik feedback
- [ ] Performance 60 FPS
- [ ] Google Play metadata (screenshots, description)

**Launch sonrası:** İlk feedback topla, bug fix.

---

### AŞAMA 3 — Depth (1-2 ay sonra)
**Hedef:** Tekrar oynatacak sistemler.

- [ ] **Level & XP sistemi**
  - Her maç XP verir
  - Level atlaması özel animasyon
  - Karakter panelinde level badge
  
- [ ] **Avatar/Skin sistemi**
  - 4-5 alternatif karakter görseli
  - Level ile açılır (5, 10, 20...)
  - IAP ile satılır (gelecekte)
  
- [ ] **Özel Güçler (Passive)**
  - Level 10: "%10 daha fazla XP"
  - Level 15: "Berabere kalırsa 1 puan al"
  - Level 20: "İlk round kazanırsa +1 bonus"
  - Açılır ama kullanıcı seçmez, otomatik aktif
  
- [ ] **Günlük Görevler**
  - Her gün 3 görev
  - Örnek: "5 maç kazan", "10 kez taş kullan"
  - Tamamlanınca bonus XP

---

### AŞAMA 4 — Genişleme (3-6 ay sonra)
**Hedef:** Çeşitlilik ve sosyal.

- [ ] **Farklı Maç Modları:**
  - Hızlı Oyun (3 round)
  - Uzun Maç (7 round)
  - Survival (bitene kadar)
  
- [ ] **Turnuva Modu (Offline):**
  - 8 AI rakip
  - Çeyrek final, yarı final, final
  - Turnuva kazanınca özel ödül
  
- [ ] **Hikaye Modu (Tek oyunculu kampanya):**
  - 10-15 seviye
  - Her seviye farklı rakip + hikaye text
  - Zorluk artar
  - Son boss
  
- [ ] **Günlük/Haftalık Liderlik Tablosu:**
  - Offline başlangıçta (sadece cihaz)
  - Online gelince global
  
- [ ] **Multiplayer (Online):**
  - Firebase Realtime
  - Matchmaking
  - Arkadaş ile oyna
  - Bu en büyük iş

---

## 🎮 EKRANLAR (Final Liste)

### Mevcut + Değişecek:
1. **Splash Screen** ✅ (var, güncelleme gerekebilir)
2. **Home Screen** 🔄 (var ama yenilenecek — arena teması)
3. **Game Screen** 🔄 (var ama layout değişecek — karakterler)
4. **Match Result Screen** ❌ (yok, yapılacak — AlertDialog yerine)
5. **Settings Screen** ✅ (var, küçük düzeltme)
6. **Statistics Screen** ✅ (var, ekstra bilgi eklenebilir)
7. **Achievements Screen** ✅ (var, gerçek data bağlanacak)

### Gelecek Ekranlar (Aşama 3-4):
8. **Profile Screen** (avatar, level, stats, achievements özet)
9. **Shop Screen** (skin, avatar, efekt satın alma)
10. **Tournament Screen** (offline turnuva bracket)
11. **Story Mode Screen** (kampanya level select)
12. **Leaderboard Screen** (sıralama tablosu)
13. **Multiplayer Lobby** (online eşleşme)

---

## 🖼️ GÖRSEL ASSET LİSTESİ

### Şu An Lazım (Aşama 1):
1. **Karakterler (2 set × 3 poz = 6 görsel):**
   - Hero: idle, victory, defeat
   - Villain: idle, victory, defeat
   - Format: PNG, transparent, 512x512

2. **Hamle İkonları (3 adet):**
   - Taş, Kağıt, Makas
   - Format: PNG, transparent, 256x256
   - Tutarlı stil

3. **Ses Dosyaları (6 adet):**
   - countdown.mp3 (tick sesi)
   - reveal.mp3 (whoosh)
   - win.mp3 (zafer)
   - lose.mp3 (hüsran)
   - draw.mp3 (berabere)
   - click.mp3 (buton)
   - Her biri < 50KB

4. **Arka Plan (opsiyonel):**
   - Arena sahne görseli (bulanık, arka planda)
   - Veya gradient yeterli (kod ile)

### Sonra Gelecek:
- Ek karakter skinleri
- Özel efekt sprite'ları
- Turnuva cup/badge ikonları
- Achievement ikonları (şu an emoji yeterli)
- Pet görselleri (ejderha, kedi — çok sonra)

---

## 💾 TEKNİK MİMARİ (Değişiklikler)

### Kalacak Dosyalar (Dokunma):
```
lib/
├── core/
│   ├── constants/app_constants.dart ✅
│   └── utils/ ✅
├── data/
│   ├── models/ ✅ (hepsi)
│   └── local/preferences_service.dart ✅
├── domain/
│   ├── game_engine/ ✅ (hepsi)
```

### Değişecek Dosyalar:
```
lib/presentation/
├── theme/app_theme.dart 🔄 (yeni renk sistemi)
├── screens/
│   ├── home/home_screen.dart 🔄 (arena teması)
│   ├── game/game_screen.dart 🔄 (layout değişikliği)
│   ├── game/widgets/
│   │   ├── choice_button.dart 🔄 (ikon güncellemesi)
│   │   ├── character_panel.dart ❌ (yeni)
│   │   └── round_result.dart ❌ (yeni)
│   └── match_result/ ❌ (yeni klasör)
│       └── match_result_screen.dart ❌ (yeni)
```

### Yeni Eklenecekler (Aşama 3+):
```
├── profile/ (yeni)
├── shop/ (yeni)
├── tournament/ (yeni)
├── story/ (yeni)
└── leaderboard/ (yeni)
```

---

## 🎨 RENK SİSTEMİ (Final)

**Ana Tema: Neon Arena**
```dart
// Arka plan
background: #0F0F23 (koyu mor-siyah)
surface: #1A1A2E (biraz açık)

// Primary gradient
primary: #6366F1 → #8B5CF6 (indigo to purple)

// Hamle renkleri
Rock: #7C3AED (purple) — glow: #A78BFA
Paper: #0891B2 (cyan) — glow: #22D3EE
Scissors: #BE185D (pink) — glow: #F472B6

// Sonuç renkleri
Win: #059669 (emerald) — glow: #34D399
Lose: #DC2626 (red) — glow: #F87171
Draw: #2563EB (blue) — glow: #60A5FA

// Text
Primary: #F9FAFB (beyaz)
Secondary: #9CA3AF (gri)
```

Tüm renkler `AppColors` class'ından gelir. Hard-coded renk yok.

---

## 🚀 İLK 4 HAFTALIK PLAN (Detaylı)

### Hafta 1: Temel + Görseller
**Gün 1-2:** Renk sistemi değiştir (`app_theme.dart`)
**Gün 3-4:** AI ile karakter görselleri üret (6 poz)
**Gün 4-5:** AI ile hamle ikonları üret (3 ikon)
**Gün 6-7:** Ses dosyalarını bul/indir (6 ses)

### Hafta 2: Arena Layout
**Gün 8-10:** `game_screen.dart` yenile — karakter layout
**Gün 11:** `character_panel.dart` widget oluştur
**Gün 12:** `round_result.dart` widget oluştur
**Gün 13-14:** Round akışı test, düzelt

### Hafta 3: Maç Sonu & Ana Menü
**Gün 15-17:** `match_result_screen.dart` oluştur
**Gün 18-19:** `home_screen.dart` yenile — arena teması
**Gün 20-21:** Karakter poz değişimi (zafer/yenilgi)

### Hafta 4: Polish & Test
**Gün 22-23:** Animasyonları ekle (scale, fade, shake)
**Gün 24-25:** Ses entegre et (tüm aksiyonlara)
**Gün 26:** Haptik feedback ekle
**Gün 27-28:** Test, bug fix, performance

**Sonuç:** Launch ready! 🎉

---

## 📝 KARAR ÖZETİ

**1. Mevcut kod silinmez ✅**
Altyapı sağlam. Sadece presentation layer güncellenir.

**2. Portre mod ✅**
Tek elle oynanabilir, mobil için doğru.

**3. Hamle seçimi: İkon + minimal çerçeve ✅**
Büyük ikon, altında isim, glassmorphism.

**4. Karakterler: 2D cartoon style ✅**
AI ile üretilebilir, 3 poz her biri.

**5. İlk hedef: Aşama 1 (4 hafta) ✅**
Temel oyun havalı görünsün, launch ready.

**6. Sonraki özellikler: Level/Skin/Turnuva/Hikaye ✅**
Aşamalı, kullanıcı feedback'ine göre.

---

## ❓ KALAN SORULAR

Vizyon net ama 2 teknik karar lazım:

1. **Karakter animasyonu nasıl?**
   - A: Statik PNG'ler, poz değişimi (kolay, şimdi)
   - B: Rive ile hafif animasyon (orta, öğrenilir)
   - C: Spine/DragonBones (zor, gelecekte)

2. **İlk karakterler nasıl olsun?**
   - Hemen AI ile üretelim mi?
   - Yoksa placeholder ile başlayıp sonra mı?

Cevap ver, başlayalım! 🚀
