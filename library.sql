create database National_Library;
create table Author(
    authorId int primary key,
    fName varchar(32) not null,
    lName varchar(32) not null,
    DOB date not null,
    nationality varchar(64) not null,
);
create table Book(
    ISBN int primary key,
    title varchar(128) not null,
    pubYear int not null,
    genre varchar(32) not null,
    authId int,
    constraint un_ISBN unique (ISBN),
    constraint fk_book foreign key (authId) references Author(authorId)
);
alter table Book
drop constraint fk_book;
alter table Book
drop column authId;
create table Creation(
    authId int,
    bookId int,
    edition int,
    primary key (authId, bookId, edition),
    constraint fk_authId foreign key (authId) references Author(authorId),
    constraint fk_bookId foreign key (bookId) references Book(ISBN),
);
create table Member(
    memberId int primary key,
    fName varchar(32) not null,
    lName varchar(32) not null,
    DOB date not null,
    address varchar(128) not null,
    phoneNumber int not null,
    gender varchar(8) default 'female' not null check (gender<>''),
    constraint chk_gender check (gender = 'male' or gender = 'female')
);
create table MemberEmail(
    email varchar(128),
    memberId int,
    primary key (email, memberId),
    constraint fk_memId foreign key (memberId) references Member(memberId)
);
create table Employee(
    employeeID int primary key,
    fName varchar(32) not null,
    lName varchar(32) not null,
    address varchar(128) not null,
    supId int,
    constraint fk_supId foreign key (supId) references Employee(employeeID)
);
create table Rental(
    MID int,
    ISBN int,
    EID int,
    cost money,
    returnDate date,
    rentalDate date,
    primary key (MID, ISBN, rentalDate),
    constraint chk_return check (returnDate > rentalDate),
    constraint fk_memId foreign key (MID) references Member(memberId),
    constraint fk_isbn foreign key (ISBN) references Book(ISBN),
    constraint fk_empId foreign key (EID) references Employee(employeeID)
);
