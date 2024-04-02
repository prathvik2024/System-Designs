create database online_shopping_cart;

use online_shopping_cart;

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

create table products(
    id int primary key auto_increment,
    name varchar(100) not null,
    price decimal(7,2),
    description varchar(60),
    image varchar(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status BOOLEAN DEFAULT true
);

create table master_cart(
    user_id int REFERENCES users.id,
    id int primary key auto_increment
);

create table cart(
    master_cart_id int REFERENCES master_cart.id,
    product_id int REFERENCES products.id,
    quantities int,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table shipping_details(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    address1 varchar(255),
    address2 varchar(255),
    city varchar(100),
    state varchar(100)
);

create table orders(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    master_cart_id int REFERENCES master_cart.id,
    shipping_id int REFERENCES shipping_details.id,
    total_amount decimal(8,2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table payment_details(
    user_id int REFERENCES users.id,
    order_id int REFERENCES orders.id,
    transactions_id int REFERENCES payment_transactions.id
);

create table payment_transactions(
    id int primary key auto_increment,
    payment_type varchar(50) not null,
    amount decimal(8,2) not null,
    payment_mode varchar(50) not null,
    created_at TIMESTAMP,
    status varchar(50) not null
);