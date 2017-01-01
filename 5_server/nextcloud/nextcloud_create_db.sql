CREATE DATABASE IF NOT EXISTS nextcloud;
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'username'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
