-- MySQL Script generated by MySQL Workbench
-- Sun Nov 26 11:54:19 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eshop` DEFAULT CHARACTER SET utf8 ;
USE `eshop` ;

-- -----------------------------------------------------
-- Table `eshop`.`cliente_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`cliente_rel` (
  `codcli` INT(15) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `cep` CHAR(10) NOT NULL,
  `fone1` VARCHAR(20) NULL,
  `fone2` VARCHAR(20) NULL,
  `fone3` VARCHAR(20) NULL,
  PRIMARY KEY (`codcli`),
  UNIQUE INDEX `fone2_UNIQUE` (`fone2` ASC) VISIBLE,
  UNIQUE INDEX `fone3_UNIQUE` (`fone3` ASC) VISIBLE,
  UNIQUE INDEX `fone1_UNIQUE` (`fone1` ASC) VISIBLE,
  UNIQUE INDEX `codcli_UNIQUE` (`codcli` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`cliente_vip_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`cliente_vip_rel` (
  `cliente_rel_codcli` INT(15) NOT NULL,
  `pontos_bonificacao` INT NULL,
  `desconto_padrao` INT(5) NULL,
  PRIMARY KEY (`cliente_rel_codcli`),
  INDEX `fk_cliente_vip_rel_cliente_rel_idx` (`cliente_rel_codcli` ASC) VISIBLE,
  UNIQUE INDEX `cliente_rel_codcli_UNIQUE` (`cliente_rel_codcli` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_vip_rel_cliente_rel`
    FOREIGN KEY (`cliente_rel_codcli`)
    REFERENCES `eshop`.`cliente_rel` (`codcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`cliente_especial_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`cliente_especial_rel` (
  `cliente_rel_codcli` INT(15) NOT NULL,
  `desconto_padrao` INT(5) NULL,
  PRIMARY KEY (`cliente_rel_codcli`),
  CONSTRAINT `fk_cliente_especial_rel_cliente_rel1`
    FOREIGN KEY (`cliente_rel_codcli`)
    REFERENCES `eshop`.`cliente_rel` (`codcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`pedido_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`pedido_rel` (
  `codped` INT(20) NOT NULL,
  `data_pedido` DATE NOT NULL,
  `data_entrega` DATE NULL,
  `rua` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` CHAR(2) NULL,
  `cep` CHAR(10) NULL,
  `cliente_rel_codcli` INT(15) NOT NULL,
  PRIMARY KEY (`codped`),
  INDEX `fk_pedido_rel_cliente_rel1_idx` (`cliente_rel_codcli` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_rel_cliente_rel1`
    FOREIGN KEY (`cliente_rel_codcli`)
    REFERENCES `eshop`.`cliente_rel` (`codcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`mercadoria_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`mercadoria_rel` (
  `codmer` INT NOT NULL,
  `preço` FLOAT(15,2) NOT NULL,
  `icms` FLOAT(5,2) NOT NULL,
  PRIMARY KEY (`codmer`),
  UNIQUE INDEX `codmer_UNIQUE` (`codmer` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshop`.`item_pedido_rel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshop`.`item_pedido_rel` (
  `no_item` INT(5) NOT NULL,
  `pedido_rel_codped` INT(20) NOT NULL,
  `quantidade` INT(15) NOT NULL,
  `desconto` FLOAT(5,2) NULL,
  `mercadoria_rel_codmer` INT NOT NULL,
  PRIMARY KEY (`no_item`, `pedido_rel_codped`),
  INDEX `fk_item_pedido_rel_pedido_rel1_idx` (`pedido_rel_codped` ASC) VISIBLE,
  INDEX `fk_item_pedido_rel_mercadoria_rel1_idx` (`mercadoria_rel_codmer` ASC) VISIBLE,
  CONSTRAINT `fk_item_pedido_rel_pedido_rel1`
    FOREIGN KEY (`pedido_rel_codped`)
    REFERENCES `eshop`.`pedido_rel` (`codped`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_pedido_rel_mercadoria_rel1`
    FOREIGN KEY (`mercadoria_rel_codmer`)
    REFERENCES `eshop`.`mercadoria_rel` (`codmer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
