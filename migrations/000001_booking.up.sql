
CREATE TYPE role_type AS ENUM ('admin', 'user', 'owner','coach');

-- USER TABLE
CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    face_id VARCHAR(255),
    gym_id VARCHAR(255),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    date_of_birth DATE,
    role role_type NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at BIGINT DEFAULT 0
);

-- SETTING TABLE
CREATE TABLE IF NOT EXISTS settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    privacy_level VARCHAR(50) NOT NULL DEFAULT 'private',
    notification VARCHAR(30) NOT NULL DEFAULT 'on',
    language VARCHAR(255) NOT NULL DEFAULT 'en',
    theme VARCHAR(255) NOT NULL DEFAULT 'light',
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TOKEN
CREATE TABLE IF NOT EXISTS tokens (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at BIGINT DEFAULT 0
);

CREATE TYPE type_gender_enum as ENUM('male','female');


CREATE TABLE IF NOT EXISTS sport_halls (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    location TEXT NOT NULL,
    contact_number VARCHAR(50),
    owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    latitude float NOT NULL,
    longtitude float NOT NULL,
    type_sport VARCHAR(100) NOT NULL,
    type_gender type_gender_enum NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS facility (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100) NOT NULL,
    image TEXT NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS gym_facility (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sport_halls_id UUID NOT NULL REFERENCES sport_halls(id) ON DELETE CASCADE,
    facility_id UUID NOT NULL REFERENCES facility(id) ON DELETE CASCADE,
    count INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT DEFAULT 0
);

CREATE TABLE subscription_personal (
    id UUID PRIMARY KEY,
    gym_id UUID REFERENCES sport_halls(id),
    type VARCHAR(100),
    description TEXT,
    price INT,
    duration INT,
    count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);

CREATE TABLE subscription_group (
    id UUID PRIMARY KEY,
    gym_id UUID REFERENCES sport_halls(id),
    coach_id UUID, -- REFERENCES users(id),
    type VARCHAR(100),
    description TEXT,
    price INT,
    capacity INT,
    time TIMESTAMP,
    duration INT,
    count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);

CREATE TABLE subscription_coach (
    id UUID PRIMARY KEY,
    gym_id UUID REFERENCES sport_halls(id),
    coach_id UUID, -- REFERENCES users(id),
    type VARCHAR(100),
    description TEXT,
    price INT,
    duration INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);

CREATE TABLE booking_personal (
    id UUID PRIMARY KEY,
    user_id UUID, -- REFERENCES users(id),
    subscription_id UUID REFERENCES subscription_personal(id),
    payment INT,
    access_status VARCHAR(100),
    start_date TIMESTAMP,
    count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);


CREATE TABLE access_personal (
    booking_id UUID REFERENCES booking_personal(id),
    date TIMESTAMP
);

CREATE TABLE booking_group (
    id UUID PRIMARY KEY,
    user_id UUID ,-- REFERENCES users(id),
    subscription_id UUID REFERENCES subscription_group(id),
    payment INT,
    access_status VARCHAR(100),
    start_date TIMESTAMP,
    count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);

CREATE TABLE access_group (
    booking_id UUID REFERENCES booking_group(id),
    date TIMESTAMP
);

CREATE TABLE booking_coach (
    id UUID PRIMARY KEY,
    user_id UUID ,--REFERENCES users(id),
    subscription_id UUID  REFERENCES subscription_coach(id),
    payment INT,
    access_status VARCHAR(100),
    start_date TIMESTAMP,
    count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at BIGINT
);

CREATE TABLE access_coach (
    booking_id UUID REFERENCES booking_coach(id),
    date TIMESTAMP
);
