-- MySQL Script generated by MySQL Workbench
-- Thu Mar  3 15:47:28 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbnegociopetshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbnegociopetshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbnegociopetshop` DEFAULT CHARACTER SET utf8 ;
USE `dbnegociopetshop` ;

-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`category` (
  `idcategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `condicion` TINYINT NOT NULL,
  PRIMARY KEY (`idcategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`subcategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`subcategory` (
  `idsubcategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `idcategory` INT NOT NULL,
  `idproducts` INT NOT NULL,
  PRIMARY KEY (`idsubcategory`),
  INDEX `fk_subcat_category_idx` (`idcategory` ASC),
  INDEX `fk_subcat_products_idx` (`idproducts` ASC),
  CONSTRAINT `fk_subcat_category`
    FOREIGN KEY (`idcategory`)
    REFERENCES `dbnegociopetshop`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subcat_products`
    FOREIGN KEY (`idproducts`)
    REFERENCES `dbnegociopetshop`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`products` (
  `idproducts` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  `stock` INT NOT NULL,
  `discount` INT NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `idsubcategory` INT NOT NULL,
  PRIMARY KEY (`idproducts`),
  INDEX `fk_products_subcategory_idx` (`idsubcategory` ASC),
  CONSTRAINT `fk_products_subcategory`
    FOREIGN KEY (`idsubcategory`)
    REFERENCES `dbnegociopetshop`.`subcategory` (`idsubcategory`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`users` (
  `idusers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `avatar` VARCHAR(60) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`idusers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`product_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`product_images` (
  `idproduct_images` INT NOT NULL AUTO_INCREMENT,
  `images` VARCHAR(70) NOT NULL,
  `idproducts` INT NOT NULL,
  PRIMARY KEY (`idproduct_images`),
  INDEX `fk_products_images_idx` (`idproducts` ASC),
  CONSTRAINT `fk_products_images`
    FOREIGN KEY (`idproducts`)
    REFERENCES `dbnegociopetshop`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`order` (
  `idorder` INT NOT NULL AUTO_INCREMENT,
  `idusers` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `creadted_at` DATETIME NOT NULL,
  `update_at` DATETIME NOT NULL,
  PRIMARY KEY (`idorder`),
  INDEX `fk_order_users_idx` (`idusers` ASC),
  CONSTRAINT `fk_order_users`
    FOREIGN KEY (`idusers`)
    REFERENCES `dbnegociopetshop`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbnegociopetshop`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbnegociopetshop`.`order_items` (
  `idorder_items` INT NOT NULL AUTO_INCREMENT,
  `idorder` INT NOT NULL,
  `idproducts` INT NOT NULL,
  `quantity` BIGINT(12) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `update_at` DATETIME NOT NULL,
  PRIMARY KEY (`idorder_items`),
  INDEX `fk_order_items_order_idx` (`idorder` ASC),
  INDEX `fk_order_items_products_idx` (`idproducts` ASC),
  CONSTRAINT `fk_order_items_order`
    FOREIGN KEY (`idorder`)
    REFERENCES `dbnegociopetshop`.`order` (`idorder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_products`
    FOREIGN KEY (`idproducts`)
    REFERENCES `dbnegociopetshop`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
