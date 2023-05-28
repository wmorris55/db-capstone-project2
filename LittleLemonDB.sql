-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondm` DEFAULT CHARACTER SET utf8 ;
USE `littlelemondm` ;

-- -----------------------------------------------------
-- Table `littlelemondm`.`Orders_Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Orders_Deliveries` (
  `Order_DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `Order_Delivery_Status` VARCHAR(45) NOT NULL,
  `Created_DateTime` DATETIME NOT NULL,
  `Expected_Delivery_DateTime` DATETIME NULL,
  PRIMARY KEY (`Order_DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Menu_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Menu_Items` (
  `Menu_ItemsID` INT NOT NULL AUTO_INCREMENT,
  `Course_Name` VARCHAR(45) NOT NULL,
  `Starter_Name` VARCHAR(45) NULL,
  `Desert_Name` VARCHAR(45) NOT NULL,
  `DrinkName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Menu_ItemsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Menu_ItemsID` INT NOT NULL,
  `Menu_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menu_items_id_fk_idx` (`Menu_ItemsID` ASC) VISIBLE,
  CONSTRAINT `menu_items_id_fk`
    FOREIGN KEY (`Menu_ItemsID`)
    REFERENCES `littlelemondm`.`Menu_Items` (`Menu_ItemsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Contact_Number` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Tables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Tables` (
  `TableID` INT NOT NULL AUTO_INCREMENT,
  `No_Of_Seats` INT NULL,
  `Location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TableID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Waiters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Waiters` (
  `WaiterID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Salary` INT NULL,
  `Contact_Number` VARCHAR(45) NULL,
  PRIMARY KEY (`WaiterID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Cooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Cooks` (
  `CookID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Salary` INT NULL,
  `Contact_Number` VARCHAR(45) NULL,
  PRIMARY KEY (`CookID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Orders` (
  `OrdersID` INT NOT NULL AUTO_INCREMENT,
  `OrdersDeliveryID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `Date_time` DATETIME NOT NULL,
  `WaiterID` INT NOT NULL,
  `CookID` INT NOT NULL,
  `TableID` INT NOT NULL,
  `TotalCost` INT NOT NULL,
  PRIMARY KEY (`OrdersID`),
  INDEX `orders_delivery_id_fk_idx` (`OrdersDeliveryID` ASC) VISIBLE,
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `table_id_fk_idx` (`TableID` ASC) VISIBLE,
  INDEX `waiter_id_fk1_idx` (`WaiterID` ASC) VISIBLE,
  INDEX `cook_id_fk_idx` (`CookID` ASC) VISIBLE,
  CONSTRAINT `orders_delivery_id_fk`
    FOREIGN KEY (`OrdersDeliveryID`)
    REFERENCES `littlelemondm`.`Orders_Deliveries` (`Order_DeliveryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondm`.`Menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondm`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `table_id_fk1`
    FOREIGN KEY (`TableID`)
    REFERENCES `littlelemondm`.`Tables` (`TableID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `waiter_id_fk`
    FOREIGN KEY (`WaiterID`)
    REFERENCES `littlelemondm`.`Waiters` (`WaiterID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cook_id_fk`
    FOREIGN KEY (`CookID`)
    REFERENCES `littlelemondm`.`Cooks` (`CookID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `Booking_Date` DATETIME NOT NULL,
  `NumberOfPeople` INT NULL,
  `TableID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `order_id_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `table_id_fk_idx` (`TableID` ASC) VISIBLE,
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `order_id_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondm`.`Orders` (`OrdersID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `table_id_fk`
    FOREIGN KEY (`TableID`)
    REFERENCES `littlelemondm`.`Tables` (`TableID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondm`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
