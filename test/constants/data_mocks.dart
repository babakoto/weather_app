import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entities/summary_entity.dart';
import 'package:weather_app/domain/entities/token_entity.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/entities/wind.dart';

const tUserName = "babakoto";
const tClientSecret = "code";
const fistName = "Eddy";
const lastName = "Tokiniaina";
const email = "eddy@sncf.fr";
const password = "12345";
const id = "1";

/// ENTITIES
const tUserEntity = UserEntity(
  id: id,
  firstName: fistName,
  lastName: lastName,
  email: email,
);

const tUserMap = {
  "firstName": fistName,
  "lastName": lastName,
  "email": email,
  "id": id
};

const tUserModel =
    UserModel(id: id, firstName: fistName, lastName: lastName, email: email);

const tTokenEntity = TokenEntity(assessToken: "token", tokenType: "bearer");
const tTokenModel = TokenModel(assessToken: "token", tokenType: "bearer");

/// DTO
const tSignInDto = SignInDto(
  email: email,
  password: password,
);

const tToken = """ 
{
  "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlZGR5X2Rhc2hib2FyZF90ZXN0Iiwic2NvcGVzIjpbXSwiZXhwIjoxNjYzNjY5NTEzfQ.G7n3FYxLHx4EPDLn0jlU86wqfkRlw0_1b5LBw8QpTtwublu5ZPN2bwOJbPanWxP5YuLXqlnP8WspjU1EUXUn6XDvZVslpC8fOulhi_WrNnkKMQ2sezPEzPSIP7hdnQ_3K43Y75DUd2n1PVTuoIzgNr_VbY7uHY-Tn5lgDdf3jWQN5Pb_0qmtUSSxl4RaTmMIvyWgFjv59iuyZOm3o1j9HiHC6RqNJbnA7tfvG26QgqkD4WEkNNQiZPaMsSbSLOBCVt3r-q2V96yr_ninR8oG9CMeYRl8Px2GAW4TK911In2rY9zzudU4XrvDZ0PDpqxpyWThfOz71rJFxvKap3r-sQ",
  "token_type": "bearer",
  "expires_at": 1663669513
}
""";

const userMap = {
  "id": "1",
  "email": "eddy@sncf.fr",
  "password": "12345",
  "firstName": "Eddy",
  "lastName": "Tokiniaina"
};

List<WeatherModel> weathers = [
  const WeatherModel(
    dt: 11,
    main: SummaryEntity(
      temp: 2.2,
      tempMin: 12.8,
      tempMax: 31.2,
    ),
    wind: Wind(
      speed: 2.2,
      deg: 4.4,
      gust: 5.9,
    ),
    dtTxt: "date",
  ),
  const WeatherModel(
    dt: 11,
    main: SummaryEntity(
      temp: 2.2,
      tempMin: 12.8,
      tempMax: 31.2,
    ),
    wind: Wind(
      speed: 2.2,
      deg: 4.4,
      gust: 5.9,
    ),
    dtTxt: "date",
  ),
];
