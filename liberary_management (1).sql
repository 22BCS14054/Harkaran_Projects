CREATE DATABASE  LIBERARY_MANAGEMENT ;
USE LIBERARY_MANAGEMENT ;
CREATE TABLE  Books(
Book_ID   INT PRIMARY KEY AUTO_INCREMENT,
Title     VARCHAR (258) NOT NULL,
Author    VARCHAR(255) NOT NULL,
Category  VARCHAR(100) ,
Available  boolean NOT NULL DEFAULT TRUE
);
CREATE TABLE Members(
Member_ID  INT PRIMARY KEY AUTO_INCREMENT,
Name     VARCHAR(258) NOT NULL,
Email    VARCHAR(100)  UNIQUE NOT NULL
);


CREATE TABLE Borrowed_Books(
Borrow_ID  INT PRIMARY KEY auto_increment,
Member_ID  INT,
Book_ID   INT,
Borrow_Date DATE DEFAULT (CURRENT_DATE),
FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
FOREIGN KEY(Book_ID)  REFERENCES Books(Book_ID)
);
INSERT INTO Books (Title, Author,Category) VALUES 
('The Alchemist ','Paulo Coelho','Fiction'),
('1984 ','George Orwell','Dystopian'),
('Clean Code ','Paulo Coelho','Fiction');

INSERT INTO Members (Name, Email)  Values 
('Alice Johnson','alice@example.com'),
('Bob Smith','bob@example.com');

START TRANSACTION ;
INSERT  INTO Borrowed_Books (Member_ID,Book_ID) VALUES(1,2);
UPDATE  Books SET Available = FALSE WHERE Book_ID =2;
COMMIT;
  
  
START TRANSACTION ;
DELETE FROM Borrowed_Books  WHERE Member_ID=1 AND Book_ID=2 ;
UPDATE  Books SET Available =TRUE WHERE Book_ID=2;
COMMIT;

SELECT * FROM Books  WHERE Available =TRUE;

SELECT Books.Title,Books.Author,Borrowed_Books.Borrow_Date 
FROM Borrowed_Books 
JOIN Books ON
Borrowed_Books.Book_ID=Books.Book_ID
WHERE Borrowed_Books.Member_ID =1;

SELECT Category ,COUNT(*) FROM Books GROUP BY Category;
SELECT DISTINCT Name , Email
FROM Members JOIN Borrowed_Books ON
Members.Member_ID=Borrowed_Books.Member_ID
LIMIT 0,1000;
CREATE INDEX idx_book_id ON Books(Book_ID);

CREATE INDEX idx_member ON Members(Member_ID);
CREATE INDEX  idx_bb_book_id ON  Borrowed_Books(Book_ID);
CREATE INDEX  idx_bb_member_id ON Borrowed_Books(Member_ID);








