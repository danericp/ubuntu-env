import csv
import json
import random
import sys
from faker import Faker
from datetime import date, timedelta
from pathlib import Path

fake = Faker()

def load_config(config_path: str) -> dict:
    """Load JSON configuration file."""
    try:
        with open(config_path, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"Error: Config file not found -> {config_path}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format -> {e}")
        sys.exit(1)

def random_dob(min_age=0, max_age=0):
    today = date.today()
    min_birth = today - timedelta(days=max_age * 365)
    max_birth = today - timedelta(days=min_age * 365)
    return fake.date_between(start_date=min_birth, end_date=max_birth)

def generate_gender():
    return random.choice(['m', 'f'])

def generate_email(first_name, last_name):
    domain = fake.free_email_domain()
    return f"{first_name.lower()}.{last_name.lower()}@{domain}"

def main(config):
    OUTPUT_FILE = config.get("csv_output_name") + ".csv"
    NUM_RECORDS = config.get("csv_row_count")  # change this as needed
    with open(OUTPUT_FILE, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)

        # # Write headers
        # writer.writerow([
        #     "First Name",
        #     "Last Name",
        #     "Date of Birth",
        #     "email",
        #     "gender"
        # ])

        for _ in range(NUM_RECORDS):
            gender = generate_gender()

            if gender == 'm':
                first_name = fake.first_name_male()
            else:
                first_name = fake.first_name_female()

            last_name = fake.last_name()
            dob = random_dob(config.get("user_age_min"), config.get("user_age_max"))
            email = generate_email(first_name, last_name)

            writer.writerow([
                first_name,
                last_name,
                dob.strftime("%Y-%m-%d"),
                email,
                gender
            ])

    print(f"CSV file '{OUTPUT_FILE}' generated with {NUM_RECORDS} records.")
    pass

if __name__ == "__main__":
    config = load_config("./lib/app_config.json")
    main(config)