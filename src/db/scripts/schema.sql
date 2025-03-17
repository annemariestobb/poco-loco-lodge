-- Create tables for Poco Loco Lodge reservation system

-- Rooms table
CREATE TABLE rooms (
  room_id SERIAL PRIMARY KEY,
  room_number VARCHAR(10) NOT NULL,
  room_type VARCHAR(50) NOT NULL,
  description TEXT,
  bed_configuration VARCHAR(100) NOT NULL,
  has_full_kitchen BOOLEAN NOT NULL,
  has_kitchenette BOOLEAN NOT NULL,
  max_occupancy INT NOT NULL,
  base_price_per_night DECIMAL(10, 2) NOT NULL,
  image_urls TEXT[],
  status VARCHAR(20) DEFAULT 'available',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Guests table
CREATE TABLE guests (
  guest_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  address TEXT,
  city VARCHAR(50),
  state VARCHAR(20),
  zip_code VARCHAR(20),
  special_requests TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Reservations table
CREATE TABLE reservations (
  reservation_id SERIAL PRIMARY KEY,
  guest_id INT REFERENCES guests(guest_id),
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(20) DEFAULT 'confirmed',
  payment_status VARCHAR(20) DEFAULT 'pending',
  square_payment_id VARCHAR(100),
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Reservation_details table (for linking reservations to rooms)
CREATE TABLE reservation_details (
  detail_id SERIAL PRIMARY KEY,
  reservation_id INT REFERENCES reservations(reservation_id),
  room_id INT REFERENCES rooms(room_id),
  price_per_night DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Amenities table
CREATE TABLE amenities (
  amenity_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT
);

-- Room_amenities table (for linking rooms to amenities)
CREATE TABLE room_amenities (
  room_id INT REFERENCES rooms(room_id),
  amenity_id INT REFERENCES amenities(amenity_id),
  PRIMARY KEY (room_id, amenity_id)
);

-- Users table (for admin access)
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  role VARCHAR(20) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Availability table (for tracking room availability)
CREATE TABLE availability (
  availability_id SERIAL PRIMARY KEY,
  room_id INT REFERENCES rooms(room_id),
  date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'available',
  UNIQUE(room_id, date)
);