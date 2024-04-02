create database inventory_management;

use inventory_management;

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
    role_id int REFERENCES roles(id) on delete CASCADE on update CASCADE,
    permission_id int REFERENCES permissions(id) on delete CASCADE on update CASCADE,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp(),
    constraint role_permission_id primary key (role_id, permission_id)  
);

create table logs(
    id int primary key auto_increment,
    log_type_id int REFERENCES log_types(id),
    message varchar(50),
    created_at TIMESTAMP default current_timestamp
);

create table log_types(
    id int primary key auto_increment,
    name varchar(30)
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
    updated_at timestamp on update current_timestamp(),
    Foreign Key (role_id) REFERENCES roles(id)
);

create table warehouses(
    id int primary key auto_increment,
    name varchar(30),
    capacity varchar(20),
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP on update current_timestamp
);

create table products(
    id int primary key auto_increment,
    name varchar(30),
    image varchar(255),
    price decimal(9,2),
    sku_id int REFERENCES product_skus(id),
    status BOOLEAN DEFAULT true,
    category_id int REFERENCES categories(id),
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP on update current_timestamp
);

create table product_skus(
    id varchar(30) not null,
    name varchar(50) not null,
    constraint primary key (id, name)
);

create table categories(
    id int primary key auto_increment,
    name varchar(30),
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP on update current_timestamp
);

create table stocks(
    product_id int REFERENCES products(id),
    warehouse_id int REFERENCES warehouses(id),
    supplier_id int REFERENCES users(id),
    quntities int,
    buy_date TIMESTAMP,
    barcode varchar(255)
);