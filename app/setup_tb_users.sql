
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

-- \copy tb_users(first_name, last_name, date_of_birth, email, gender) FROM '/app/fake_users.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',') ON CONFLICT (email) DO NOTHING;

CREATE OR REPLACE FUNCTION import_csv_and_loop_insert()
RETURNS void AS $$
DECLARE
    row_record RECORD;
BEGIN
    -- 1. Create a temporary table matching your CSV structure
    -- (This table automatically drops when your database session ends)
    CREATE TEMP TABLE temp_csv_stage AS 
        SELECT * FROM tb_users;
    --  ON COMMIT DROP;

    -- 2. Execute COPY to pull the server-side file into the temp table
    -- Note: The PostgreSQL server must have read permissions for this path
    -- EXECUTE 'COPY temp_csv_stage FROM ''/app/fake_users.csv'' WITH (FORMAT csv, HEADER true, DELIMITER '','')';

    -- 3. Loop through the rows to process them sequentially
    FOR row_record IN SELECT * FROM temp_csv_stage LOOP
        
        -- Custom Logic Example: Filter out entries or manipulate variables
        IF row_record.first_name IS NOT NULL THEN
            
            -- 4. Insert targeted data into your production table
            RAISE NOTICE 'Inserting % %', row_record.first_name, row_record.last_name;
            INSERT INTO tb_users (first_name, last_name, date_of_birth, email, gender)
            VALUES (
                row_record.first_name, 
                UPPER(row_record.last_name), -- Text modification example
                row_record.date_of_birth, 
                row_record.email,
                row_record.gender
            ) ON CONFLICT (email) DO NOTHING;
            
        END IF;
        
    END LOOP;

END;
$$ LANGUAGE plpgsql;

-- SELECT import_csv_and_loop_insert();