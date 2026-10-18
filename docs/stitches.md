# Stitch Kütüphanesi

| Kod | Ad (TR)             | Ad (US)                         | Tüketir | Üretir | Chart sembolü |
| --- | ------------------- | ------------------------------- | ------- | ------ | ------------- |
| ch  | zincir              | chain                           | 0       | 1      | O             |
| sc  | tek tığ             | single crochet                  | 1       | 1      | +             |
| hdc | yarım direk         | half double crochet             | 1       | 1      | T             |
| dc  | direk               | double crochet                  | 1       | 1      | ┼             |
| tr  | çift dolamalı direk | treble crochet                  | 1       | 1      | ╪             |
| inc | artış               | increase (aynı ilmeğe 2 stitch) | 1       | 2      | V             |
| dec | azaltma             | decrease (2 ilmeği birleştir)   | 2       | 1      | Λ             |

"Tüketir": önceki sıradan kaç stitch kullanır. "Üretir": bu sıraya kaç stitch ekler.
Kural motoru bu iki sütunu kullanarak sıra tutarlılığını kontrol eder.

## Modelleme kararları

1. **Magic ring:** Pattern'de `"start": "magic_ring"` alanı ile gösterilir.
   Sıra 1 önceki sıradan stitch tüketmediği için tüketim kontrolünden muaf tutulur.
2. **Sıra sonu zincirleri (turning chain):** Şimdilik modellenmez, kapsam basitleştirme
   için sıra sayısına dahil edilmez.
3. **Repeat:** Bir sıradaki stitch grubu `repeat` kadar tekrarlanır.
   Örnek: `[1 sc, 1 inc] x 6` = 6 sc + 6 inc, toplam 18 stitch üretir.
4. **Kontrol kuralı:** Bir sıranın tükettiği stitch sayısı, önceki sıranın ürettiğine
   eşit olmalıdır.
