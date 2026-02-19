# ARENA — Görsel Üretim Kılavuzu

> Placeholder ile başlıyoruz, ama gerçek görseller hazır olunca kolayca değiştirilebilir.

---

## 📋 GEREKLI GÖRSELLER LİSTESİ

### 1. KARAKTER GÖRSELLERİ (6 adet)

#### Hero (Kahraman) — 3 poz:
- `hero_idle.png` — Normal duruş
- `hero_victory.png` — Zafer pozu
- `hero_defeat.png` — Yenilgi pozu

#### Villain (Rakip) — 3 poz:
- `villain_idle.png` — Normal duruş
- `villain_victory.png` — Zafer pozu
- `villain_defeat.png` — Yenilgi pozu

**Özellikler:**
- Boyut: 512x512px
- Format: PNG transparent background
- Stil: Cartoon/stylized, Clash Royale benzeri
- Karakter ekranın %20-25'ini kaplayacak, çok detaylı olmamalı

---

### 2. HAMLE İKONLARI (3 adet)

- `rock_icon.png` — Taş
- `paper_icon.png` — Kağıt
- `scissors_icon.png` — Makas

**Özellikler:**
- Boyut: 256x256px
- Format: PNG transparent
- Stil: Bold, 3D-ish, glow efektli
- Renk: Taş=mor, Kağıt=cyan, Makas=pembe

---

## 🎨 GÖRSEL ÜRETIM — TOOL SEÇİMİ

### Önerilen Tool'lar (Kolay → Zor):

#### 1. **Bing Image Creator** (ÜCRETSİZ, ÖNERİLİR)
- DALL-E 3 kullanır
- Günlük limit: 100 üretim
- Link: bing.com/create
- Kalite: Çok iyi
- **İlk tercih bu olsun**

#### 2. **Leonardo.AI** (ÜCRETSİZ)
- Günlük 150 üretim
- Link: leonardo.ai
- Kalite: İyi
- Model: Leonardo Phoenix veya Kino XL

#### 3. **Midjourney** (ÜCRETLI - $10/ay)
- En iyi kalite
- Discord üzerinden
- Sadece Bing yetmezse

---

## 🎯 PROMPT'LAR (Kullanıma Hazır)

### KARAKTER GÖRSELLERİ

#### Hero - Idle (Normal Duruş)
```
2D game character for mobile arena fighting game,
young heroic warrior, confident stance,
cartoon stylized art style similar to Clash Royale,
blue and purple armor with subtle glow effects,
friendly determined expression,
full body front view, standing ready pose,
clean simple background,
vibrant colors but not too saturated,
PNG transparent background,
mobile game character asset,
high quality digital art
```

#### Hero - Victory (Zafer Pozu)
```
Same character as before: young heroic warrior with blue-purple armor,
victory celebration pose, arms raised triumphantly,
big smile, confident body language,
cartoon stylized art style,
golden glow effect around character,
full body front view,
PNG transparent background,
mobile game victory animation frame,
high quality digital art
```

#### Hero - Defeat (Yenilgi Pozu)
```
Same character as before: young heroic warrior with blue-purple armor,
defeated pose, kneeling or sitting exhausted,
disappointed but not too sad expression,
cartoon stylized art style,
slightly dimmed colors,
full body front view,
PNG transparent background,
mobile game defeat animation frame,
high quality digital art
```

---

#### Villain - Idle (Normal Duruş)
```
2D game character for mobile arena fighting game,
intimidating opponent fighter, menacing stance,
cartoon stylized art style similar to Clash Royale,
dark red and black armor with ominous glow,
masked or shadowed face, mysterious but not scary,
full body front view, aggressive ready pose,
clean simple background,
vibrant colors with dark theme,
PNG transparent background,
mobile game character asset,
high quality digital art
```

#### Villain - Victory (Zafer Pozu)
```
Same character as before: dark fighter with red-black armor,
victory intimidation pose, arms crossed or pointing,
confident menacing body language,
cartoon stylized art style,
red glow effect around character,
full body front view,
PNG transparent background,
mobile game victory animation frame,
high quality digital art
```

#### Villain - Defeat (Yenilgi Pozu)
```
Same character as before: dark fighter with red-black armor,
defeated pose, on one knee with head down,
frustrated body language,
cartoon stylized art style,
dimmed colors,
full body front view,
PNG transparent background,
mobile game defeat animation frame,
high quality digital art
```

---

### HAMLE İKONLARI

#### Taş (Rock)
```
Rock stone icon for mobile fighting game,
bold 3D design with smooth surface,
purple-violet gradient color,
subtle glow effect,
game asset style, clean and simple,
PNG transparent background,
256x256 resolution,
icon suitable for dark background,
vibrant but professional
```

#### Kağıt (Paper)
```
Paper scroll icon for mobile fighting game,
bold 3D design with slight curl,
cyan-teal gradient color,
subtle glow effect,
game asset style, clean and simple,
PNG transparent background,
256x256 resolution,
icon suitable for dark background,
vibrant but professional
```

#### Makas (Scissors)
```
Scissors icon for mobile fighting game,
bold 3D design, sharp and sleek,
pink-magenta gradient color,
subtle glow effect,
game asset style, clean and simple,
PNG transparent background,
256x256 resolution,
icon suitable for dark background,
vibrant but professional
```

---

## 🔧 ÜRETIM SÜRECI (Adım Adım)

### Adım 1: Bing Image Creator'a Git
1. https://bing.com/create
2. Microsoft hesabı ile giriş yap
3. "Create" butonuna tık

### Adım 2: Hero Idle Üret
1. Yukarıdaki "Hero - Idle" prompt'unu kopyala
2. Yapıştır
3. "Create" tıkla
4. 30-60 saniye bekle
5. 4 varyasyon gelir
6. En iyisini seç
7. İndir (sağ tık → Save image)

### Adım 3: Diğer Pozlar
- "Same character as before" kullanarak devam et
- Aynı style devam etsin diye önemli
- Her poz için 2-3 deneme yap
- En tutarlı olanları seç

### Adım 4: Background Temizleme
Eğer arka plan tam transparent değilse:
1. https://remove.bg
2. Görseli yükle
3. Background otomatik temizlenir
4. İndir

### Adım 5: Boyutlandırma
1. Photopea.com (ücretsiz Photoshop)
2. Görseli aç
3. Image → Image Size → 512x512
4. Export → PNG
5. Kaydet

---

## 📁 DOSYA YAPILANDIRMASI

Üretilen görseller projeye şöyle eklenecek:

```
assets/
  images/
    characters/
      hero_idle.png
      hero_victory.png
      hero_defeat.png
      villain_idle.png
      villain_victory.png
      villain_defeat.png
    icons/
      rock_icon.png
      paper_icon.png
      scissors_icon.png
```

`pubspec.yaml` zaten `assets/images/` klasörünü include ediyor, ek değişiklik gerekmez.

---

## 🎨 PLACEHOLDER GÖRSELLER (Şimdilik)

Görseller hazır olana kadar kodda şunu kullanacağız:

```dart
// Karakter placeholder
Container(
  width: 120,
  height: 150,
  decoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.3),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.white24),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.person, size: 60, color: Colors.white70),
      SizedBox(height: 8),
      Text('HERO', style: TextStyle(color: Colors.white70)),
    ],
  ),
)

// İkon placeholder
Container(
  width: 80,
  height: 80,
  decoration: BoxDecoration(
    color: Colors.purple.withOpacity(0.3),
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white24),
  ),
  child: Icon(Icons.diamond, size: 40, color: Colors.white70),
)
```

Gerçek görseller gelince sadece:
```dart
Image.asset('assets/images/characters/hero_idle.png')
```

Tek satır değişir, tüm kod aynı kalır.

---

## ✅ KALİTE KONTROL

Görseller gelince kontrol et:

### Karakter Görselleri:
- [ ] Arka plan transparent mı?
- [ ] 3 poz tutarlı mı (aynı karakter gibi görünüyor mu)?
- [ ] Boyutlar 512x512 mi?
- [ ] Dosya boyutu < 200KB mı?
- [ ] Karakter net görülüyor mu (küçülünce)?

### İkonlar:
- [ ] Arka plan transparent mı?
- [ ] Renkler doğru mu (mor/cyan/pembe)?
- [ ] 256x256 boyutunda mı?
- [ ] Üçü tutarlı stil mi?
- [ ] Dark background üzerinde iyi görünüyor mu?

---

## 🚀 ÖNCELİK SIRASI

**Şimdi kodla (placeholder):**
1. Renk sistemini güncelle
2. Arena layout yaz
3. Character panel widget yaz
4. Test et, çalıştığından emin ol

**Paralel (görseller):**
1. Hero 3 poz üret (30 dk)
2. Villain 3 poz üret (30 dk)
3. 3 ikon üret (15 dk)
4. Background temizle/boyutlandır (30 dk)
5. Projeye ekle (5 dk)

**Toplam görsel işi:** ~2 saat

Görseller bitince tek satır kod değişikliği ile entegre olur!

---

## 💡 İPUÇLARI

### Prompt Ayarlama:
- Eğer karakter çok detaylı çıkarsa: "simple clean design" ekle
- Eğer stil uyumsuzsa: "consistent art style" vurgula
- Eğer arka plan sorunluysa: "pure white background, remove bg" de

### Style Tutarlılığı:
- Tüm karakterler için aynı gün üret
- Aynı tool kullan (Bing'den başladıysan Bing'le devam et)
- "Same character as before" kelimelerini atla

### Yedekleme:
- Her üretimi kaydet (4 varyasyon gelir)
- İleride başka poz lazım olursa aynı style devam edebilirsin

---

## 📞 YARDIM

Eğer görseller istediğin gibi olmazsa:
1. Prompt'u biraz değiştir
2. Farklı tool dene (Bing → Leonardo)
3. 3-4 deneme yap, en iyiyi seç
4. Background temizleme unutma

Görseller için ayrı yardım istersen prompt'ları birlikte ayarlayabiliriz!

---

Şimdi kod yazalım, görselleri sen paralel hazırla. Deal? 🚀
