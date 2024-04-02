create database task_management;

use task_management;

create table roles(
    id int primary key auto_increment,
    name varchar(256) not null unique,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
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

create table users(
    id int primary key auto_increment,
    role_id int, 
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) not null UNIQUE,
    password varchar(256),
    salting varchar(10),
    activation_link_expiry datetime,
    password_expiry datetime,
    isActivated BOOLEAN default false,
    created_at timestamp,
    updated_at timestamp ,
    Foreign Key (role_id) REFERENCES roles(id)
);

create table tasks(
    id int primary key auto_increment,
    name varchar(255),
    descriptions text,
    duedate datetime,
    priority varchar(100) check (priority in('urgent', 'importance')),
    category_id int REFERENCES categories.id,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp(),
    status BOOLEAN DEFAULT true
);

create table categories(
    id int primary key auto_increment,
    name varchar(255) not null,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table additional_task_details(
    task_id int REFERENCES tasks.id,
    comments varchar(256),
    attech_files_url varchar(256),
    other_info varchar(256)
);

create table collabrations(
    id int primary key auto_increment,
    asignee_id int REFERENCES users.id,
    task_id int REFERENCES tasks.id,
    user_id int REFERENCES users.id,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp(),
    status BOOLEAN DEFAULT true
);

create table task_statuses(
    task_id int REFERENCES tasks.id,
    status varchar(256) check (status in ('todo', 'in-progress', 'completed')),
    created_at TIMESTAMP DEFAULT current_timestamp() 
);