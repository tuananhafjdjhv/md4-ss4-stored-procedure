SELECT * FROM customers;
use classicmodels;
-- thuc hanh 1
SELECT * FROM customers WHERE customerName = "Land of Toys Inc."; 
EXPLAIN SELECT * FROM customers WHERE customerName = "Land of Toys Inc.";
ALTER TABLE customers ADD INDEX idx_customerName(customerName);
ALTER TABLE customers DROP INDEX idx_customerName;
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' or contactFirstName = 'King';

-- thuc hanh 2
DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END ;

call findAllCustomers();
DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//
CREATE PROCEDURE findAllCustomers()

BEGIN
SELECT * FROM customers where customerNumber = 175;
END ;
call findAllCustomers();

-- thuc hanh 3
DELIMITER //
DROP PROCEDURE IF EXISTS `getCusById`//
CREATE PROCEDURE getCusById
(IN cusNum INT(11))
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //
call getCusById(175);
-- thuc hanh 4
DELIMITER //
DROP PROCEDURE IF EXISTS `GetCustomersCountByCity`//
CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END//
DELIMITER ;
CALL GetCustomersCountByCity('Lyon',@total);
SELECT @total;
DROP PROCEDURE IF EXISTS `SetCounter`;
DELIMITER //
CREATE PROCEDURE SetCounter( INOUT counter INT,IN inc INT )
BEGIN
   SET counter = counter + inc;
 END
//DELIMITER ;
SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8
-- bai tap





