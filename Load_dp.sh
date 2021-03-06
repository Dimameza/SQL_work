#/bin/sh

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Links_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Cards_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Users_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Opername_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Channel_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Cardstyps_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Location_p"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS Sex_p"

echo "‡ Јаг¦ Ґ¬ Opername_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Opername_p (
    id integer PRIMARY KEY,
    OperationName varchar(20)
    );'
psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Opername_p FROM '/data/Data_pd/Opername_p.csv' DELIMITER ',' CSV HEADER"


echo "‡ Јаг¦ Ґ¬ Channel_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Channel_p (
    id integer PRIMARY KEY,
    Channel varchar(20)
    );'
psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Channel_p FROM '/data/Data_pd/Channel_p.csv' DELIMITER ',' CSV HEADER"


echo "‡ Јаг¦ Ґ¬ Cardstyps_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Cardstyps_p (
    id integer PRIMARY KEY,
    Name_type varchar(20)
    );'
psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Cardstyps_p FROM '/data/Data_pd/Cardstyps_p.csv' DELIMITER ',' CSV HEADER"



echo "‡ Јаг¦ Ґ¬ Location_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Location_p (
    id integer PRIMARY KEY,
    Location varchar(60)
    );'
psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Location_p FROM '/data/Data_pd/Location_p.csv' DELIMITER ',' CSV HEADER"

echo "‡ Јаг¦ Ґ¬ sex_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Sex_p (
    id integer PRIMARY KEY,
    SexTyp varchar(20)
    );'
psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Sex_p FROM '/data/Data_pd/Sex_p.csv' DELIMITER ',' CSV HEADER"




echo "‡ Јаг¦ Ґ¬ Users_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Users_p (
    id bigint PRIMARY KEY,
    LocationID integer,
    Age integer,
  SexID integer REFERENCES Sex_p(ID)
    );'

psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Users_p FROM '/data/Data_pd/Users_p.csv' DELIMITER ',' CSV HEADER"

echo "‡ Јаг¦ Ґ¬ Cards_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS Cards_p (
    id bigint PRIMARY KEY,
  Userid bigint REFERENCES Users_p(ID),
  LocationID integer REFERENCES Location_p(ID),
    typcardid integer REFERENCES Cardstyps_p(ID),  
  MB boolean
  );'

psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy Cards_p FROM '/data/Data_pd/Cards_p.csv' DELIMITER ',' CSV HEADER"

echo "‡ Јаг¦ Ґ¬ links_p.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS links_p (
    id bigint PRIMARY KEY,
    CardID bigint REFERENCES cards_p(ID),
    LocationID integer REFERENCES Location_p(ID),
    ChannelId integer REFERENCES Channel_p(ID),
  OpernameID integer REFERENCES Opername_p(ID),
  Summ numeric
  );'

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy links_p FROM '/data/Data_pd/links_p.csv' DELIMITER ',' CSV HEADER"