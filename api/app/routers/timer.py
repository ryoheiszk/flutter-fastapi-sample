from fastapi import APIRouter, HTTPException
from app.models.timer_record import TimerRecord, TimerRecordCreate
from app.services.timer_service import TimerService

router = APIRouter()
timer_service = TimerService()

@router.post("/timer", response_model=TimerRecord)
async def create_timer_record(record: TimerRecordCreate):
    return timer_service.create_record(record)

@router.get("/timer", response_model=list[TimerRecord])
async def get_all_timer_records():
    return timer_service.get_all_records()

@router.get("/timer/{record_id}", response_model=TimerRecord)
async def get_timer_record(record_id: str):
    record = timer_service.get_record(record_id)
    if record is None:
        raise HTTPException(status_code=404, detail="Record not found")
    return record

@router.delete("/timer/{record_id}", response_model=bool)
async def delete_timer_record(record_id: str):
    success = timer_service.delete_record(record_id)
    if not success:
        raise HTTPException(status_code=404, detail="Record not found")
    return success
