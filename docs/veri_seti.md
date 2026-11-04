# Veri Seti ve Etiketleme

## 1. Kapsam

Düz renkli yuvarlak ve kare/dikdörtgen tığ işi parçalar (bkz. kapsam.md).
Stitch seti: ch, sc, hdc, dc, tr, inc, dec.

## 2. Klasör yapısı

data/images/ fotoğraflar
data/labels/ her fotoğrafın JSON etiketi (aynı ad: circle01_a.jpg -> circle01_a.json)

Dosya adı: <şekil><no>\_<harf>. Örnek: circle01_a, circle01_b, square03_c.

## 3. Etiket formatı

Etiket, schemas/pattern.py içindeki Pattern şemasıdır. Ek alanlar:

- image: fotoğraf dosya adı
- piece_id: parça kimliği (aynı parçanın tüm fotoğraflarında aynı)
- photo_quality: good / medium / poor
- source: kaynak ve lisans (örn. "kendi örgüm, kendi çektiğim fotoğraf")

## 4. Etiketleme kuralları

1. Pattern, parçanın gerçekte nasıl örüldüğüne göre yazılır, fotoğraftan tahmin edilmez.
2. Her sıranın total değeri stitch tüketim/üretim kurallarıyla tutmalıdır (stitches.md).
3. Aynı parçanın fotoğraflarında pattern kısmı aynıdır; sadece image ve photo_quality değişir.
4. photo_quality: good = tepeden, düz arka plan, iyi ışık; medium = hafif açılı veya gölgeli;
   poor = bulanık, loş veya karışık arka plan.
5. Her etiket kaydetmeden önce `python -m src.validate data/labels` ile kontrol edilir.

## 5. Veri bölünmesi

Bölme fotoğrafa değil piece_id'ye göre yapılır; aynı parçanın tüm fotoğrafları aynı kümede kalır.
Başlangıç hedefi: 10 parça x 3 fotoğraf, yaklaşık 6 eğitim / 2 doğrulama / 2 test parçası.
Test kümesi eğitimde kullanılmaz. Genişletilmiş veri seti 15-16. haftalarda hazırlanır.

## 6. Lisans

Veri; kendi örüp fotoğrafladığım parçalardan veya lisansı kullanıma uygun, pattern'i bilinen
örneklerden oluşur. Dış kaynak kullanılırsa kullanım koşulları önceden incelenir ve source
alanına yazılır.
