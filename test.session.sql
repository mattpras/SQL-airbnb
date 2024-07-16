
-- @block
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);

-- @block
SELECT * FROM Users;

-- @block
INSERT INTO Users (email, bio, country)
VALUES (
    'mattpras@email.com',
    'allergic to dogs',
    'AU'
)

-- @block
INSERT INTO Users (email, bio, country)
VALUES
    ('Martin@gmail.com', 'nice guy', 'AU'),
    ('jisna@jichuz.com', 'rich af', 'AU'),
    ('AliAbdi@outlook.com', 'owns many airbnbs', 'AU');

-- @block
SELECT email, id, bio FROM Users
WHERE email like 'm%' OR email LIKE 'a%'
AND id > 0
ORDER BY id ASC;

-- @block
CREATE INDEX email_index ON Users(email);

-- @block
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block
SELECT * FROM Rooms;

-- @block
INSERT INTO Rooms (owner_id, street)
VALUES 
    (1, 'san diego sailboat'),
    (1, 'nantucket cottage'),
    (1, 'vail cabin'),
    (1, 'sf cardboard box'),
    (2, 'Flagstaff'),
    (3, 'Boys House');

-- @block
SELECT
    Users.id AS User_id,
    email,
    street AS address,
    Rooms.id AS Room_NO,
    owner_id
FROM Users
LEFT JOIN Rooms ON Rooms.owner_id = users.id
ORDER BY User_id ASC;

-- @block
DELETE FROM Rooms WHERE id < 23;

-- @block
ALTER TABLE Rooms AUTO_INCREMENT = 1;

-- @block
CREATE TABLE Reservations(
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block
INSERT INTO Reservations (guest_id, room_id, check_in)
VALUES
    (1, 1, '2024-07-03 11:38:45');

-- @block
SELECT * FROM Reservations;


-- @block Rooms a user has booked
SELECT
    guest_id,
    street,
    check_in
FROM Reservations
INNER JOIN Rooms ON Rooms.owner_id = Reservations.guest_id
WHERE guest_id = 1;

-- @block Guests who have stayed in a room
SELECT
    room_id,
    guest_id,
    email,
    bio
FROM Reservations
INNER JOIN Users ON Users.id = Reservations.guest_id
WHERE room_id = 1;