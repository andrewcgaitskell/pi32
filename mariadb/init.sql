CREATE USER 'pythonuser'@'localhost' IDENTIFIED BY 'pythonuser';
CREATE DATABASE dev;
CREATE DATABASE systemdata;
GRANT ALL PRIVILEGES ON *.* TO 'pythonuser'@'localhost' WITH GRANT OPTION;
ALTER USER 'pythonuser'@'%' IDENTIFIED BY 'pythonuser';
GRANT ALL PRIVILEGES ON *.* TO 'pythonuser'@'%' WITH GRANT OPTION;
