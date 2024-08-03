import json
from typing import List, Optional, Union
from uuid import uuid4
from datetime import datetime
from app.models.timer_record import TimerRecord, TimerRecordCreate

class TimerService:
    def __init__(self, file_path: str = "app/data/timer_records.json"):
        self.file_path = file_path

    def _read_records(self) -> List[TimerRecord]:
        try:
            with open(self.file_path, "r") as file:
                data = json.load(file)
                return [TimerRecord(**record) for record in data]
        except FileNotFoundError:
            return []
        except json.JSONDecodeError:
            print(f"Error decoding JSON from {self.file_path}")
            return []

    def _write_records(self, records: List[TimerRecord]):
        with open(self.file_path, "w") as file:
            json.dump([record.dict() for record in records], file, default=str, indent=2)

    def create_record(self, record: TimerRecordCreate) -> TimerRecord:
        records = self._read_records()
        new_record = TimerRecord(
            id=str(uuid4()),
            start_time=record.start_time,
            end_time=record.end_time,
            duration=(record.end_time - record.start_time).total_seconds()
        )
        records.append(new_record)
        self._write_records(records)
        return new_record

    def get_all_records(self) -> List[TimerRecord]:
        return self._read_records()

    def get_record(self, record_id: str) -> Optional[TimerRecord]:
        records = self._read_records()
        for record in records:
            if record.id == record_id:
                return record
        return None

    def delete_record(self, record_id: str) -> bool:
        records = self._read_records()
        initial_length = len(records)
        records = [record for record in records if record.id != record_id]
        if len(records) < initial_length:
            self._write_records(records)
            return True
        return False
