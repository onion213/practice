### データベース作成
CREATE DATAbASE ipam;

### データベースを選択
USE ipam;

### ユーザテーブル作成
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name TEXT NOT NULL UNIQUE 
    hashed_password TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### ユーザグループテーブル作成
CREATE TABLE User_Groups (
    user_group_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_name TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### ユーザロールマスタ作成
CREATE TABLE User_Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name TEXT NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### ユーザロールマスタデータ作成
INSERT INTO User_Roles(`role_name`) VALUES('admin');
INSERT INTO User_Roles(`role_name`) VALUES('normal');

### 所属テーブル作成
CREATE TABLE User_Belongs_Group (
    user_id INT NOT NULL,
    user_group_id INT NOT NULL,
    role_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    PRIMARY KEY(user_id, user_group_id),
    FOREIGN KEY user_id REFERENCES Users(user_id),
    FOREIGN KEY user_group_id REFERENCES User_Groups(user_group_id),
    FOREIGN KEY role_id REFERENCES User_Roles(role_id)
);

### 拠点テーブル作成
CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_id INT NOT NULL,
    location_name TEXT NOT NULL,
    note TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    FOREIGN KEY user_group_id REFERENCES User_Groups(user_group_id)
);

### IPバージョンマスタ作成
CREATE TABLE IP_Versions (
    ip_version_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_version TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
);

### IPバージョンマスタデータ作成
INSERT INTO IP_Versions(`ip_version`) VALUES ('4');
INSERT INTO IP_Versions(`ip_version`) VALUES ('6');

### サブネットマスクマスタ作成
CREATE TABLE Subnet_Masks (
    subnet_mask_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_version_id INT NOT NULL,
    subnet_mask_address TEXT NOT NULL,
    subnet_mask_number INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    FOREIGN KEY ip_version_id REFERENCES IP_Versions(ip_version_id)
);

### サブネットマスクマスタデータ作成
INSERT INTO IP_Versions(`ip_version_id`, `subnet_mask_address`, `subnet_mask_number`) VALUES(
    SELECT ip_version_id, '255.255.255.255', 32 FROM IP_Versions WHERE ip_version='4'
);
# 他多数

### レンジテーブル作成
CREATE TABLE Ranges (
    range_id INT PRIMARY KEY AUTO_INCREMENT,
    user_group_id INT NOT NULL,
    ip_version_id INT NOT NULL,
    network_address TEXT NOT NULL,
    subnet_mask_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    FOREIGN KEY user_group_id REFERENCES User_Groups(user_group_id),
    FOREIGN KEY ip_version_id REFERENCES IP_Versions(ip_version_id)
);

### セグメントテーブル作成
CREATE TABLE Segments (
    segment_id INT PRIMARY KEY AUTO_INCREMENT,
    segment_name TEXT NOT NULL,
    range_id INT NOT NULL,
    network_address TEXT NOT NULL,
    subnet_mask_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    FOREIGN KEY range_id REFERENCES Ranges(range_id),
    FOREIGN KEY subnet_mask_id REFERENCES Subnet_Masks(subnet_mask_id)
);

### ホストテーブル作成
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
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP   
    FOREIGN KEY segment_id REFERENCES Segments(segment_id),
    FOREIGN KEY ip_version_id REFERENCES IP_Versions(ip_version_id),
    FOREIGN KEY location_id REFERENCES Locations(location_id)
);