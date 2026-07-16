import csv
import random
from faker import Faker
from datetime import date, timedelta

fake = Faker()

OUTPUT_FILE = "fake_users.csv"
NUM_RECORDS = 10  # change this as needed

def random_dob(min_age=18, max_age=65):
    today = date.today()
    min_birth = today - timedelta(days=max_age * 365)
    max_birth = today - timedelta(days=min_age * 365)
    return fake.date_between(start_date=min_birth, end_date=max_birth)

def generate_gender():
    return random.choice(['m', 'f'])

def generate_email(first_name, last_name):
    domain = fake.free_email_domain()
    return f"{first_name.lower()}.{last_name.lower()}@{domain}"

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
        dob = random_dob()
        email = generate_email(first_name, last_name)

        writer.writerow([
            first_name,
            last_name,
            dob.strftime("%Y-%m-%d"),
            email,
            gender
        ])

print(f"CSV file '{OUTPUT_FILE}' generated with {NUM_RECORDS} records.")