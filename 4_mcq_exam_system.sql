create database mcq_exam_db;

use mcq_exam_db;
-- Roles Module

create table roles(
    id int primary key auto_increment,
    name varchar(256) not null unique,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP DEFAULT current_timestamp()
);

create table permissions(
    id int primary key auto_increment,
    name varchar(256) not null unique,
    created_at TIMESTAMP, 
    updated_at TIMESTAMP
);

create table role_has_permission(
    role_id int REFERENCES roles.id on delete CASCADE on update CASCADE,
    permission_id int REFERENCES permissions.id on delete CASCADE on update CASCADE,
    created_at TIMESTAMP, 
    updated_at TIMESTAMP,
    constraint role_permission_id primary key (role_id, permission_id)  
);

create table students(
    id int primary key auto_increment,
    role_id int, 
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) not null UNIQUE,
    dob date,
    password varchar(256),
    salting varchar(10),
    activation_link_expiry datetime,
    password_expiry datetime,
    isActivated BOOLEAN default false,
    language varchar(20),
    created_at timestamp,
    updated_at timestamp ,
    Foreign Key (role_id) REFERENCES roles(id)
);

create table exam_details(
    id int primary key auto_increment,
    title varchar(255),
    duration time,
    start_time TIMESTAMP,
    passing_score varchar(10),
    instructions text,
    difficulty_level VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table exam_questions(
    exam_id int REFERENCES exam_details.id,
    id int primary key auto_increment,
    title varchar(255),
    option_a varchar(255),
    option_b varchar(255),
    option_c varchar(255),
    option_d varchar(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table exam_topics(
    id int primary key auto_increment,
    topic_name varchar(255)
);

create table exam_answers(
    id int primary key auto_increment,
    exam_id int REFERENCES exam_details.id,
    questions_id int REFERENCES exam_questions.id,
    answers text
);

create table take_exam(
    student_id int REFERENCES students.id,
    exam_id int REFERENCES exam_details.id,
    created_at TIMESTAMP
);

create table exam_result(
    student_id int REFERENCES students.id,
    exam_id int REFERENCES exam_details.id,
    total_questions int,
    total_attemped_question int,
    total_marks int,
    obtain_marks int,
    grade varchar(10),
    feedback varchar(255)
);