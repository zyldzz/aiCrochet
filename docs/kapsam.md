# Kapsam ve Başarı Metrikleri

## 1. Kapsam

Sistem, düz renkli yuvarlak ve düz (kare/dikdörtgen) tığ işi parçaların fotoğrafından
sc, hdc, dc, inc ve dec stitch'lerinden oluşan yazılı pattern ve görsel chart üretir.

## 2. Kapsam dışı (gelecek çalışma)

- Giysiler (kazak, yelek, hırka vb.): çok parçalı, 3 boyutlu ve şekillendirmeli
  yapıları nedeniyle ayrı bir pattern modeli gerektirir
- 3D / amigurumi ürünler
- Dantel ve açık işlemeli örgüler
- Çok renkli (jacquard, tapestry) örgüler
- Puff, popcorn, bobble gibi karmaşık stitch'ler

## 3. Varsayımlar

- Fotoğraf tepeden çekilmiş, düz arka planlı ve yeterince aydınlık
- Tek motif/ürün görünür
- Tek bir fotoğraftan her stitch'in kesin tespit edileceği varsayılmaz; belirsiz
  sonuçlar güven skoru veya kullanıcı onayı ile işaretlenir

## 4. Başarı metrikleri

| Metrik                | Tanım                                                             |
| --------------------- | ----------------------------------------------------------------- |
| Geçerli JSON oranı    | Modelin ürettiği çıktının şemadan geçen oranı                     |
| Şekil doğruluğu       | Doğru tespit edilen şekil / toplam test örneği                    |
| Sıra sayısı doğruluğu | Sıra sayısı doğru tahmin edilen örnek oranı                       |
| Stitch tam eşleşme    | Sıra başına stitch sayısı doğru olan sıra oranı                   |
| Hata yakalama oranı   | Kural motorunun yakaladığı hatalı pattern / toplam hatalı pattern |
| Kullanıcı puanı       | Anketle anlaşılabilirlik ve kullanılabilirlik (1-5)               |

## 5. Karşılaştırma yöntemi

Her metrik dört durumda ölçülür:
(a) Baseline: fine-tuning yapılmamış VLM (few-shot prompt)
(b) Ön işlemli girdi ile baseline
(c) LoRA/QLoRA ile fine-tune edilmiş model
(d) Kural motoru ve kullanıcı düzeltmesi sonrası nihai çıktı
