import datetime as _dt
from typing import Optional

import pydantic as _pydantic


class _UserBase(_pydantic.BaseModel):
    email: str


class UserCreate(_UserBase):
    password: str

    class Config:
        orm_mode = True


class User(_UserBase):
    id: int
    date_created: _dt.datetime

    class Config:
        orm_mode = True

# ================================================================


class _PostBase(_pydantic.BaseModel):
    post_text: str


class PostCreate(_PostBase):
    pass


class Post(_PostBase):
    id: int
    owner_id: int
    date_created: _dt.datetime

    class Config:
        orm_mode = True

# ================================================================


class UserDetailBase(_pydantic.BaseModel):
    FirstName: str
    LastName: str


class UserDetailCreate(UserDetailBase):
    pass


class UserDetail(UserDetailBase):
    id: int
    owner_id: int
    date_created: _dt.datetime

    class Config:
        orm_mode = True

# ===================================================================


class medicineBase(_pydantic.BaseModel):
    medicineName: str
    time: str
    days: str


class medicinecreate(medicineBase):
    pass


class medicine(medicineBase):
    id: int
    owner_id: int
    date_created: _dt.datetime

    class Config:
        orm_mode = True

# ======================================================================


class userInfoBase(_pydantic.BaseModel):
    DOB: str
    height: str
    weight: str
    bloodtype: str
    organdonor: str
    pmc: str
    medication: str
    allergies: str


class userInfoCreate(userInfoBase):
    pass


class userInfo(userInfoBase):
    id: int
    owner_id: int
    date_created: _dt.datetime

    class Config:
        orm_mode = True


class userInfoUpdate(_pydantic.BaseModel):
    DOB: Optional[str]
    height: Optional[float]
    weight: Optional[float]
    bloodtype: Optional[str]
    organdonor: Optional[bool]
    pmc: Optional[str]
    medication: Optional[str]
    allergies: Optional[str]
