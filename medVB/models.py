import datetime as _dt

import sqlalchemy as _sql
import sqlalchemy.orm as _orm
import passlib.hash as _hash

import database as _database


class User(_database.Base):
    __tablename__ = "users"
    __table_args__ = {'extend_existing': True}
    id = _sql.Column(_sql.Integer, primary_key=True, index=True)
    email = _sql.Column(_sql.String, unique=True, index=True)
    hashed_password = _sql.Column(_sql.String)
    date_created = _sql.Column(_sql.DateTime, default=_dt.datetime.utcnow)

    posts = _orm.relationship("Post", back_populates="owner")

    def verify_password(self, password: str):
        return _hash.bcrypt.verify(password, self.hashed_password)

# ==================================================================================


class Post(_database.Base):
    __tablename__ = "posts"
    __table_args__ = {'extend_existing': True}
    id = _sql.Column(_sql.Integer, primary_key=True, index=True)
    owner_id = _sql.Column(_sql.Integer, _sql.ForeignKey("users.id"))
    post_text = _sql.Column(_sql.String, index=True)
    date_created = _sql.Column(_sql.DateTime, default=_dt.datetime.utcnow)

    owner = _orm.relationship("User", back_populates="posts")

# ===================================================================================


class UserDetail(_database.Base):
    __tablename__ = "UserDetails"
    __table_args__ = {'extend_existing': True}
    id = _sql.Column(_sql.Integer, primary_key=True, index=True)
    owner_id = _sql.Column(_sql.Integer, _sql.ForeignKey("users.id"))
    FirstName = _sql.Column(_sql.String, index=True)
    LastName = _sql.Column(_sql.String, index=True)
    date_created = _sql.Column(_sql.DateTime, default=_dt.datetime.utcnow)

    owner = _orm.relationship("User")


class medicine(_database.Base):
    __tablename__ = "medicine"
    __table_args__ = {'extend_existing': True}
    id = _sql.Column(_sql.Integer, primary_key=True, index=True)
    owner_id = _sql.Column(_sql.Integer, _sql.ForeignKey("users.id"))
    medicineName = _sql.Column(_sql.String, index=True)
    time = _sql.Column(_sql.String, index=True)
    days = _sql.Column(_sql.String, index=True)
    date_created = _sql.Column(_sql.DateTime, default=_dt.datetime.utcnow)

    owner = _orm.relationship("User")


class userInfo(_database.Base):
    __tablename__ = "userInfo"
    __table_args__ = {'extend_existing': True}
    id = _sql.Column(_sql.Integer, primary_key=True, index=True)
    owner_id = _sql.Column(_sql.Integer, _sql.ForeignKey("users.id"))
    DOB = _sql.Column(_sql.String, index=True)
    height = _sql.Column(_sql.String, index=True)
    weight = _sql.Column(_sql.String, index=True)
    bloodtype = _sql.Column(_sql.String, index=True)
    organdonor = _sql.Column(_sql.String, index=True)
    pmc = _sql.Column(_sql.String, index=True)
    medication = _sql.Column(_sql.String, index=True)
    allergies = _sql.Column(_sql.String, index=True)
    date_created = _sql.Column(_sql.DateTime, default=_dt.datetime.utcnow)

    owner = _orm.relationship("User")
