create database book_library;


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

create table users(
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
    longitude varchar(20),
    latitude varchar(20),
    created_at timestamp,
    updated_at timestamp ,
    Foreign Key (role_id) REFERENCES roles(id)
);

create table books (
    id int primary key auto_increment,
    title varchar(255) not null,
    author_id int REFERENCES authors.id,
    category_id int REFERENCES categories.id,
    publication_year varchar(10),
    ISBN varchar(255),
    status BOOLEAN DEFAULT true,
    image varchar(255),
    description varchar(255),
    notes varchar(255),
    created_at timestamp,
    updated_at timestamp
);

create table book_feedback(
    book_reader_id int REFERENCES book_reader.id,
    rating varchar(10),
    comment varchar(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table categories(
    id int primary key auto_increment,
    name varchar(255),
    status BOOLEAN DEFAULT true,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table authors(
    id int primary key auto_increment,
    name varchar(255),
    image varchar(255),
    description varchar(255)
);

create table book_reader(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    book_id int REFERENCES books.id,
    status varchar(20)
);

create table login_logs(
    email varchar(50),
    password varchar(255),
    attempt_count int,
    attempt_time datetime,
    system_info varchar(255),
    created_at TIMESTAMP
);

create table favorite_genre(
    user_id int REFERENCES users.id,
    category_id int REFERENCES categories.id,
    status BOOLEAN DEFAULT false
);