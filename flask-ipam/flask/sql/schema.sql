### Transaction begin
BEGIN;

### Create database.
CREATE DATABASE ipam;

### Select database.
USE ipam;

### Create user table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(31) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### Create user group table.
CREATE TABLE User_Groups (
    user_group_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_name TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### Create user role master table.
CREATE TABLE User_Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(31) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### Create user role master data.
INSERT INTO User_Roles(role_name) VALUES('admin');
INSERT INTO User_Roles(role_name) VALUES('normal');

### Create belonging table.
CREATE TABLE User_Belongs_Group (
    user_id INT NOT NULL,
    user_group_id INT NOT NULL,
    role_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, user_group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (user_group_id) REFERENCES User_Groups(user_group_id),
    FOREIGN KEY (role_id) REFERENCES User_Roles(role_id)
);

### Create location table.
CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_id INT NOT NULL,
    location_name TEXT NOT NULL,
    note TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_group_id) REFERENCES User_Groups(user_group_id)
);

### Create IP version master table.
CREATE TABLE IP_Versions (
    ip_version_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_version TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

### Create IP version master data.
INSERT INTO IP_Versions(ip_version) VALUES ('4');
# NSERT INTO IP_Versions(ip_version) VALUES ('6'); # Only IPv4 for now.

### Create subnet mask master table.
CREATE TABLE Subnet_Masks (
    subnet_mask_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_version_id INT NOT NULL,
    subnet_mask_address TEXT NOT NULL,
    subnet_mask_number INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
    FOREIGN KEY (ip_version_id) REFERENCES IP_Versions(ip_version_id)
);

### Create subnet mask master data.
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.255', 32 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.254', 31 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.252', 30 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.248', 29 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.240', 28 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.224', 27 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.192', 26 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.128', 25 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.255.0', 24 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.254.0', 23 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.252.0', 22 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.248.0', 21 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.240.0', 20 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.224.0', 19 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.192.0', 18 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.128.0', 17 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.255.0.0', 16 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.254.0.0', 15 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.252.0.0', 14 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.248.0.0', 13 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.240.0.0', 12 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.224.0.0', 11 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.192.0.0', 10 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.128.0.0', 9 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '255.0.0.0', 8 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '254.0.0.0', 7 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '252.0.0.0', 6 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '248.0.0.0', 5 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '240.0.0.0', 4 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '224.0.0.0', 3 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '192.0.0.0', 2 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '128.0.0.0', 1 FROM IP_Versions WHERE ip_version='4';
INSERT INTO Subnet_Masks(ip_version_id, subnet_mask_address, subnet_mask_number) SELECT ip_version_id, '0.0.0.0', 0 FROM IP_Versions WHERE ip_version='4';

# Maybe, change from hard-coding to csv import.
# Only IPv4 for now.

### Create range table.
CREATE TABLE Ranges (
    range_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_id INT NOT NULL,
    ip_version_id INT NOT NULL,
    network_address TEXT NOT NULL,
    subnet_mask_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_group_id) REFERENCES User_Groups(user_group_id),
    FOREIGN KEY (ip_version_id) REFERENCES IP_Versions(ip_version_id)
);

### Create segment table
CREATE TABLE Segments (
    segment_id INT PRIMARY KEY AUTO_INCREMENT,
    segment_name TEXT NOT NULL,
    range_id INT NOT NULL,
    network_address TEXT NOT NULL,
    subnet_mask_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (range_id) REFERENCES Ranges(range_id),
    FOREIGN KEY (subnet_mask_id) REFERENCES Subnet_Masks(subnet_mask_id)
);

### Create host table
CREATE TABLE Hosts (
    host_id INT PRIMARY KEY AUTO_INCREMENT,
    segment_id INT NOT NULL,
    ip_version_id INT NOT NULL,
    ip_address TEXT NOT NULL,
    host_name TEXT NOT NULL,
    port_name TEXT,
    note TEXT,
    location_id INT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (segment_id) REFERENCES Segments(segment_id),
    FOREIGN KEY (ip_version_id) REFERENCES IP_Versions(ip_version_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

### Transaction end
COMMIT;