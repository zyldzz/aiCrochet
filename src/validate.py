import sys
from pathlib import Path

from schemas.pattern import Pattern


def validate_dir(folder):
    ok, bad = 0, 0
    for f in sorted(Path(folder).glob("*.json")):
        try:
            p = Pattern.model_validate_json(f.read_text(encoding="utf-8"))
            if p.image:
                if not p.piece_id or not p.photo_quality:
                    raise ValueError("image varsa piece_id ve photo_quality zorunlu")
                if not (Path(folder).parent / "images" / p.image).exists():
                    raise ValueError(f"fotoğraf bulunamadı: {p.image}")
            ok += 1
        except Exception as e:
            bad += 1
            print(f"HATA {f.name}: {e}")
    print(f"{ok} geçerli, {bad} hatalı")


if __name__ == "__main__":
    validate_dir(sys.argv[1] if len(sys.argv) > 1 else "examples")