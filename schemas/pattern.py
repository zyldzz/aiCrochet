from pydantic import BaseModel, Field
from typing import Literal, Optional

StitchType = Literal["ch", "sc", "hdc", "dc", "tr", "inc", "dec"]
ShapeType = Literal["circle", "square", "rectangle", "other"]
Quality = Literal["good", "medium", "poor"]


class StitchGroup(BaseModel):
    type: StitchType
    count: int = Field(ge=1)


class Row(BaseModel):
    no: int = Field(ge=1)
    stitches: list[StitchGroup]
    repeat: int = Field(default=1, ge=1)
    total: Optional[int] = Field(default=None, ge=0)
    confidence: Optional[float] = Field(default=None, ge=0, le=1)


class Pattern(BaseModel):
    shape: ShapeType
    colors: list[str]
    start: Optional[str] = None          # örn. "magic_ring"
    rows: list[Row]
    notes: Optional[str] = None
    photo_quality: Optional[Quality] = None
    source: Optional[str] = None