from pydantic import BaseModel
from datetime import datetime

class TimerRecordBase(BaseModel):
    start_time: datetime
    end_time: datetime

class TimerRecordCreate(TimerRecordBase):
    pass

class TimerRecord(TimerRecordBase):
    id: str
    duration: float

    class Config:
        from_attributes = True  # Changed from orm_mode = True
