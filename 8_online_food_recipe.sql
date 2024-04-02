create database food_recipe;

use food_recipe;

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
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp(),
    constraint role_permission_id primary key (role_id, permission_id)  
);

create table logs(
    id int primary key auto_increment,
    log_type_id int REFERENCES log_types.id,
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
    difficulty_level_id int REFERENCES difficulty_levels.id,
    created_at timestamp,
    updated_at timestamp on update current_timestamp(),
    Foreign Key (role_id) REFERENCES roles(id)
);

create table meal_types(
    id int primary key auto_increment,
    type varchar(30),
    description varchar(256),
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table cooking_methods(
    id int primary key auto_increment,
    name varchar(50),
    description varchar(256),
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table difficulty_levels(
    id int primary key auto_increment,
    level varchar(30),
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table recipes(
    id int primary key auto_increment,
    name varchar(100),
    instructions text,
    incredients json,
    nutrition varchar(256),
    serving_size varchar(50),
    cooking_method_id int REFERENCES cooking_methods.id,
    difficulty_level_id int REFERENCES difficulty_levels.id,
    meal_type_id int REFERENCES meal_types.id,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table recipe_media(
    id int primary key auto_increment,
    recipe_id int REFERENCES recipes.id,
    type varchar(10) check (type in('image', 'video', 'blog')),
    url varchar(256)   
);

create table favorite_recipes(
    id int primary key auto_increment,
    recipe_id int REFERENCES recipes.id,
    user_id int REFERENCES users.id
);

create table recipe_engagements(
    id int primary key auto_increment,
    recipe_id int REFERENCES recipes.id,
    user_id int REFERENCES users.id,
    comments varchar(256),
    ratings decimal(2,1),
    reviews varchar(256),
    tips text,
    post_url varchar(256),
    modifications_to_recipe text,
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

create table collaborations(
    id int primary key auto_increment,
    name varchar(20),
    descriptions text,
    type varchar(20) check (type in ('brand', 'influencers', 'chef')),
    starting_at TIMESTAMP,
    ending_at TIMESTAMP
);

create table shopping_master(
    id int primary key auto_increment,
    user_id int REFERENCES users.id,
    status varchar(20),
    created_at TIMESTAMP
);

create table recipe_shoppinglists(
    id int primary key auto_increment,
    shopping_id int REFERENCES shopping_master.id,
    recipe_id int REFERENCES recipes.id,
    other_incredients json,
    schedule_date TIMESTAMP,
    serving_size varchar(20),
    created_at TIMESTAMP DEFAULT current_timestamp(), 
    updated_at TIMESTAMP on update current_timestamp()
);

