import uuid
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

NUM_RECORDS = 5000

roles = ['guest', 'host', 'admin']
payment_methods = ['credit_card', 'paypal', 'stripe']
booking_statuses = ['pending', 'confirmed', 'canceled']

# Containers to track relationships
users = []
hosts = []
guests = []
properties = []
bookings = []

def gen_uuid():
    return str(uuid.uuid4())

def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

with open("airbnb_seed.sql", "w", encoding="utf-8") as f:
    # User Table
    f.write("-- Seeding User table\n")
    for _ in range(NUM_RECORDS):
        user_id = gen_uuid()
        fname = fake.first_name()
        lname = fake.last_name()
        email = fake.unique.email()
        password = fake.sha256()
        phone = fake.phone_number() if random.random() > 0.3 else 'NULL'
        role = random.choice(roles)
        created_at = fake.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S')

        users.append((user_id, role))
        if role == 'host':
            hosts.append(user_id)
        elif role == 'guest':
            guests.append(user_id)

        phone_sql = f"'{phone[0:11]}'" if phone != 'NULL' else 'NULL'
        f.write(f"INSERT INTO `User` (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES ('{user_id}', '{fname}', '{lname}', '{email}', '{password}', {phone_sql}, '{role}', '{created_at}');\n")

    # Property Table
    f.write("\n-- Seeding Property table\n")
    for _ in range(NUM_RECORDS):
        property_id = gen_uuid()
        host_id = random.choice(hosts)
        name = fake.street_name()
        desc = fake.text(max_nb_chars=200)
        location = fake.address().replace('\n', ', ')
        price = round(random.uniform(30.00, 500.00), 2)
        created_at = fake.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S')
        updated_at = created_at

        properties.append(property_id)

        f.write(f"INSERT INTO `Property` (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES ('{property_id}', '{host_id}', '{name}', '{desc}', '{location}', {price}, '{created_at}', '{updated_at}');\n")

    # Booking Table
    f.write("\n-- Seeding Booking table\n")
    for _ in range(NUM_RECORDS):
        booking_id = gen_uuid()
        property_id = random.choice(properties)
        user_id = random.choice(guests)
        start_date = fake.date_between(start_date='-1y', end_date='today')
        end_date = start_date + timedelta(days=random.randint(1, 14))
        price_per_night = round(random.uniform(30.00, 500.00), 2)
        total_price = price_per_night * (end_date - start_date).days
        status = random.choice(booking_statuses)
        created_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        bookings.append(booking_id)

        f.write(f"INSERT INTO `Booking` (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES ('{booking_id}', '{property_id}', '{user_id}', '{start_date}', '{end_date}', {total_price}, '{status}', '{created_at}');\n")

    # Payment Table
    f.write("\n-- Seeding Payment table\n")
    for booking_id in random.sample(bookings, NUM_RECORDS):
        payment_id = gen_uuid()
        amount = round(random.uniform(30.00, 3000.00), 2)
        payment_date = fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        method = random.choice(payment_methods)

        f.write(f"INSERT INTO `Payment` (payment_id, booking_id, amount, payment_date, payment_method) VALUES ('{payment_id}', '{booking_id}', {amount}, '{payment_date}', '{method}');\n")

    # Review Table
    f.write("\n-- Seeding Review table\n")
    for _ in range(NUM_RECORDS):
        review_id = gen_uuid()
        property_id = random.choice(properties)
        user_id = random.choice(guests)
        rating = random.randint(1, 5)
        comment = fake.text(max_nb_chars=150)
        created_at = fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')

        f.write(f"INSERT INTO `Review` (review_id, property_id, user_id, rating, comment, created_at) VALUES ('{review_id}', '{property_id}', '{user_id}', {rating}, '{comment}', '{created_at}');\n")

    # Message Table
    f.write("\n-- Seeding Message table\n")
    for _ in range(NUM_RECORDS):
        message_id = gen_uuid()
        sender_id = random.choice(users)[0]
        recipient_id = random.choice(users)[0]
        while recipient_id == sender_id:
            recipient_id = random.choice(users)[0]
        message_body = fake.text(max_nb_chars=200)
        sent_at = fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')

        f.write(f"INSERT INTO `Message` (message_id, sender_id, recipient_id, message_body, sent_at) VALUES ('{message_id}', '{sender_id}', '{recipient_id}', '{message_body}', '{sent_at}');\n")

print("✅ SQL seed file 'airbnb_seed.sql' generated successfully.")
