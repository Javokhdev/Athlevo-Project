-- Drop tables in reverse order of dependency
DROP TABLE IF EXISTS access_coach;
DROP TABLE IF EXISTS booking_coach;
DROP TABLE IF EXISTS access_group;
DROP TABLE IF EXISTS booking_group;
DROP TABLE IF EXISTS access_personal;
DROP TABLE IF EXISTS booking_personal;
DROP TABLE IF EXISTS subscription_coach;
DROP TABLE IF EXISTS subscription_group;
DROP TABLE IF EXISTS subscription_personal;
DROP TABLE IF EXISTS gym_facility;
DROP TABLE IF EXISTS facility;
DROP TABLE IF EXISTS sport_halls;
DROP TYPE IF EXISTS type_gender_enum;
DROP TABLE IF EXISTS tokens;
DROP TABLE IF EXISTS settings;
DROP TABLE IF EXISTS users;
DROP TYPE IF EXISTS role_type;