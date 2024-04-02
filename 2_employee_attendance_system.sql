create database employee_attendance;

create table employee_attendance(
    emp_id int REFERENCES employee.id,
    attendance_status_id int REFERENCES attendance_status.id,
    status_time TIMESTAMP DEFAULT current_timestamp()
);

create table attendance_status(
    id int primary key auto_increment,
    attendance_status varchar(50) not null,
    status BOOLEAN DEFAULT true
);

create table employee(
    id int primary key auto_increment,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    email varchar(50) not null unique,
    phone varchar(13) not null unique,
    address1 varchar(50), 
    address2 varchar(50),
    city varchar(50),
    state varchar(50),
    salary varchar(20),
    status BOOLEAN DEFAULT true
);