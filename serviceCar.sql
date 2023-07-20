-- Version: 1.0
-- Project: Car Service
-- Author: valois gomes

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `serviceCar` DEFAULT CHARACTER SET utf8 ;

create database if not exists serviceCar;

CREATE TABLE IF NOT EXISTS `serviceCar`.`client` (
  `idclient` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `dtNasc` DATE NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `address_idaddress` INT(11) NOT NULL,
  PRIMARY KEY (`idclient`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_cliente_address_idx` (`address_idaddress` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_address`
    FOREIGN KEY (`address_idaddress`)
    REFERENCES `serviceCar`.`address` (`idaddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`address` (
  `idaddress` INT(11) NOT NULL AUTO_INCREMENT,
  `place` VARCHAR(255) NOT NULL,
  `number` INT(11) NOT NULL,
  `comple` VARCHAR(45) NULL DEFAULT NULL,
  `district` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`idaddress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`car` (
  `idcar` INT(11) NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `year` DATE NOT NULL,
  `license` VARCHAR(10) NOT NULL,
  `client_idcliente` INT(11) NOT NULL,
  PRIMARY KEY (`idcar`),
  INDEX `fk_car_cliente1_idx` (`client_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_car_cliente1`
    FOREIGN KEY (`client_idcliente`)
    REFERENCES `serviceCar`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`sales` (
  `idsales` INT(11) NOT NULL AUTO_INCREMENT,
  `dateSale` DATE NOT NULL,
  `amount` DOUBLE NOT NULL,
  `discount` DOUBLE NOT NULL,
  `client_idcliente` INT(11) NOT NULL,
  `payment_idpayment` INT(11) NOT NULL,
  PRIMARY KEY (`idsales`),
  INDEX `fk_sales_cliente1_idx` (`client_idcliente` ASC) VISIBLE,
  INDEX `fk_sales_payment1_idx` (`payment_idpayment` ASC) VISIBLE,
  CONSTRAINT `fk_sales_cliente1`
    FOREIGN KEY (`client_idcliente`)
    REFERENCES `serviceCar`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_payment1`
    FOREIGN KEY (`payment_idpayment`)
    REFERENCES `serviceCar`.`payment` (`idpayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`payment` (
  `idpayment` INT(11) NOT NULL AUTO_INCREMENT,
  `typepayment` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idpayment`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`followup` (
  `idfollowup` INT(11) NOT NULL AUTO_INCREMENT,
  `status` CHAR(1) NOT NULL,
  `sales_idsales` INT(11) NOT NULL,
  PRIMARY KEY (`idfollowup`),
  INDEX `fk_followup_sales1_idx` (`sales_idsales` ASC) VISIBLE,
  CONSTRAINT `fk_followup_sales1`
    FOREIGN KEY (`sales_idsales`)
    REFERENCES `serviceCar`.`sales` (`idsales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`prodService` (
  `idprodService` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `value` DOUBLE(9,2) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `type` CHAR(1) NOT NULL,
  PRIMARY KEY (`idprodService`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `serviceCar`.`soldItems` (
  `prodService_idprodService` INT(11) NOT NULL,
  `sales_idsales` INT(11) NOT NULL,
  INDEX `fk_soldItems_prodService1_idx` (`prodService_idprodService` ASC) VISIBLE,
  INDEX `fk_soldItems_sales1_idx` (`sales_idsales` ASC) VISIBLE,
  CONSTRAINT `fk_soldItems_prodService1`
    FOREIGN KEY (`prodService_idprodService`)
    REFERENCES `serviceCar`.`prodService` (`idprodService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_soldItems_sales1`
    FOREIGN KEY (`sales_idsales`)
    REFERENCES `serviceCar`.`sales` (`idsales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

 show tables
