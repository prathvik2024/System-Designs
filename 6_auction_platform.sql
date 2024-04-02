create database online_auction_platform;

use online_auction_platform;

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

create table login_logs(
    email varchar(50),
    password varchar(255),
    attempt_count int,
    attempt_time datetime,
    system_info varchar(255),
    created_at TIMESTAMP
);

create table users(
    id int primary key auto_increment,
    role_id int, 
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) not null UNIQUE,
    phone varchar(13),
    dob date,
    password varchar(256),
    salting varchar(10),
    activation_link_expiry datetime,
    password_expiry datetime,
    isActivated BOOLEAN default false,
    created_at timestamp,
    updated_at timestamp ,
    Foreign Key (role_id) REFERENCES roles(id)
);

create table categories(
    id int primary key auto_increment,
    name varchar(50) not null,
    description varchar(256),
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table product_categories(
    id int primary key auto_increment,
    product_id int REFERENCES products.id,
    product_category_id int REFERENCES categories.id,
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp(),
    status BOOLEAN DEFAULT true
);

create table products(
    id int primary key auto_increment,
    name varchar(255) not null,
    description text,
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp(),
    status BOOLEAN DEFAULT true
);

create table products_in_auction(
    id int primary key auto_increment,
    product_id int REFERENCES products.id,
    host varchar(255) not null,
    start_time datetime,
    end_time datetime,
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table product_images(
    product_id int REFERENCES products.id,
    image_urls varchar(250),
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table bids(
    id int primary key auto_increment,
    product_in_auction_id int REFERENCES products_in_auction.id,
    start_price decimal(9,2) not null,
    reserve_price decimal(9,2) not null,
    increment_bid_price decimal(9,2),
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table order_master(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    discount decimal(5,2),
    gst_pr decimal(5,2),
    created_at TIMESTAMP DEFAULT current_timestamp(),
    status BOOLEAN DEFAULT true
);

create table products_in_order(
    id int primary key auto_increment,
    order_id int REFERENCES order_master.id,
    bid_id int REFERENCES bids.id,
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table payments(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    order_id int REFERENCES order_master.id,
    type varchar(255)not null, -- (cod, credit card, debit card, UPI etc..)
    mode varchar(255) not null, -- (online, offline)
    status varchar(100) check (status in ('success', 'failed')),
    amount DECIMAL(8,2),
    pay_details text,
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);

create table shipping_details(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    order_id int REFERENCES order_master.id,
    tracking_link varchar(256),
    address1 varchar(256),
    address2 varchar(256),
    city varchar(100),
    state varchar(100),
    created_at TIMESTAMP DEFAULT current_timestamp(),
    updated_at TIMESTAMP on update current_timestamp()
);
