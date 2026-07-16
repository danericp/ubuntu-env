
DROP TABLE IF EXISTS tb_users;
CREATE TABLE tb_users(
    id SERIAL PRIMARY KEY, -- SERIAL PRIMARY KEY → auto-increment ID
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL, -- DATE for DOB → proper date handling (not string)
    email VARCHAR(255) UNIQUE NOT NULL, -- UNIQUE(email) → prevents duplicate emails
    gender CHAR(1) NOT NULL CHECK (gender IN ('m', 'f')), -- CHAR(1) + CHECK → restricts gender to 'm' or 'f'
    
    -- Ensure age is between 18 and 65
    -- age_check constraint → enforces your 18–65 rule at DB level
    CONSTRAINT age_check CHECK (
        date_of_birth <= CURRENT_DATE - INTERVAL '18 years'
        AND date_of_birth >= CURRENT_DATE - INTERVAL '65 years'
    )
);

-- Case-insensitive emails
CREATE EXTENSION IF NOT EXISTS citext;
ALTER TABLE tb_users ALTER COLUMN email TYPE CITEXT;

-- Faster lookups
CREATE INDEX idx_users_last_name ON tb_users(last_name);

\copy tb_users(first_name, last_name, date_of_birth, email, gender) FROM '/app/fake_users.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',')
