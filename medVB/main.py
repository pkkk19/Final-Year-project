from typing import List
import fastapi as _fastapi
import fastapi.security as _security

import sqlalchemy.orm as _orm

import services as _services
import schemas as _schemas
from fastapi.middleware.cors import CORSMiddleware

app = _fastapi.FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/api/users")
async def create_user(user: _schemas.UserCreate, db: _orm.Session = _fastapi.Depends(_services.get_db)):
    db_user = await _services.get_user_by_email(email=user.email, db=db)
    if db_user:
        raise _fastapi.HTTPException(
            status_code=400,
            detail="User with that email already exists")

    user = await _services.create_user(user=user, db=db)

    return await _services.create_token(user=user)


@app.get("/hello")
async def hello():
    return "hello"


@app.post("/api/token")
async def generate_token(form_data: _security.OAuth2PasswordRequestForm = _fastapi.Depends(), db: _orm.Session = _fastapi.Depends(_services.get_db)):
    user = await _services.authenticate_user(email=form_data.username, password=form_data.password, db=db)

    if not user:
        raise _fastapi.HTTPException(
            status_code=401, detail="Invalid Credentials")

    return await _services.create_token(user=user)


@app.get("/api/users/me", response_model=_schemas.User)
async def get_user(user: _schemas.User = _fastapi.Depends(_services.get_current_user)):
    return user


@app.post("/api/user-posts", response_model=_schemas.Post)
async def create_post(
    post: _schemas.PostCreate,
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.create_post(user=user, db=db, post=post)


@app.get("/api/my-posts", response_model=List[_schemas.Post])
async def get_user_posts(user: _schemas.User = _fastapi.Depends(_services.get_current_user),
                         db: _orm.Session = _fastapi.Depends(_services.get_db)):
    return await _services.get_user_posts(user=user, db=db)


@app.post("/user-details-post", response_model=_schemas.UserDetail)
async def UserDetail(
    UserDetail: _schemas.UserDetailCreate,
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.UserDetail(user=user, db=db, UserDetail=UserDetail)


@app.get("/user-details-get", response_model=List[_schemas.UserDetail])
async def get_UserDetails(
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.get_UserDetail(user=user, db=db)

# ====================================================================


@app.post("/medicine-post", response_model=_schemas.medicine)
async def medicine(
    medicine: _schemas.medicinecreate,
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.UserMedicine(user=user, db=db, medicine=medicine)


@app.get("/medicine-get", response_model=List[_schemas.medicine])
async def get_UserMedicine(
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.get_UserMedicine(user=user, db=db)


@app.delete("/medicine-delete/{medicine_id}", status_code=204)
async def delete_medicine(medicine_id: int, user: _schemas.User = _fastapi.Depends(_services.get_current_user),
                          db: _orm.Session = _fastapi.Depends(_services.get_db)
                          ):

    return await _services.drop_UserMedicine(db=db, user=user, medicine_id=medicine_id)


@app.post("/userinfo", response_model=_schemas.userInfo)
async def create_user_info(
    user_info: _schemas.userInfoCreate,
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.UserInfo(user=user, db=db, userInfo=user_info)


@app.get("/userinfo", response_model=List[_schemas.userInfo])
async def get_user_info(
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    return await _services.get_UserInfo(user=user, db=db)


class UserInfoResponse(_schemas.userInfo):
    pass


@app.put("/userinfo", response_model=_schemas.userInfo)
async def userInfoUpdate(
    user_info_update: _schemas.userInfoUpdate,
    user: _schemas.User = _fastapi.Depends(_services.get_current_user),
    db: _orm.Session = _fastapi.Depends(_services.get_db)
):
    user_information = await _services.update_UserInfo(user=user, db=db, user_info_update=user_info_update)
    return user_information
