-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2018 at 10:44 AM
-- Server version: 10.1.33-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pcd_adicionarProduto` (IN `pro_descricao` VARCHAR(70) CHARSET utf8, IN `mar_codigo` INT(11), IN `cat_codigo` INT(11), IN `pro_quantidade` INT(11), IN `pro_valor` INT(11))  BEGIN
	DECLARE idAtualProduto INT;
    
    INSERT INTO `tb_produto` (`pro_descricao`, `pro_valor`, `pro_quantidade`) VALUES (pro_descricao, pro_valor, pro_quantidade);
    SET @idAtualProduto = LAST_INSERT_ID();
    
	INSERT INTO `tb_marcaproduto` (`marpro_codproduto`, `marpro_codmarca`) VALUES (@idAtualProduto, mar_codigo);
    
	INSERT INTO `tb_categoriaproduto` (`catpro_codproduto`, `catpro_codcategoria`) 
    VALUES (@idAtualProduto, cat_codigo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pcd_realizarVenda` (IN `qtdeProduto` INT(11), IN `codigoProduto` INT(11), IN `codigoCliente` INT(11))  BEGIN
	DECLARE valorCompra DECIMAL;
    DECLARE codigoVenda INT;
    
    SET @valorCompra = (select pro_valor from tb_produto WHERE pro_codigo = codigoProduto) * qtdeProduto;
    
    INSERT INTO `tb_venda`(`ven_data`, `ven_valor`, `ven_codcliente`) 
    VALUES (NOW(), @valorCompra, codigoCliente);
    SET @codigoVenda = LAST_INSERT_ID();
	
    INSERT INTO `tb_itemvenda`(`itv_codvenda`, `itv_codproduto`, `itv_quantidade`) VALUES (@codigoVenda, codigoProduto, qtdeProduto);

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `func_valorVendasPeriodo` (`mesInicio` DATE) RETURNS INT(11) NO SQL
    DETERMINISTIC
BEGIN
	DECLARE totalVendas INT;
    DECLARE mesAtual DATE;
    
    SET @mesAtual = NOW();
    
    IF @mesAtual > mesInicio THEN
    	SET @totalVendas = (SELECT SUM(`ven_valor`)
                            FROM `tb_venda`
                            WHERE 	DATE_FORMAT(`ven_data`, '%Y-%m-%d') 						 		BETWEEN  DATE_FORMAT(mesInicio, '%Y-%m-%d') 
                                AND
                                    DATE_FORMAT(@mesAtual, '%Y-%m-%d'));

	END IF;
    
	RETURN @totalVendas;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `func_vendasPeriodo` (`mesInicio` DATE) RETURNS INT(11) BEGIN
	DECLARE totalVendas INT;
    DECLARE mesAtual DATE;
    
    SET @mesAtual = NOW();
    
    IF @mesAtual > mesInicio THEN
    	SET @totalVendas = (SELECT COUNT(*)
                            FROM `tb_venda`
                            WHERE 	DATE_FORMAT(`ven_data`, '%Y-%m-%d') 						 		BETWEEN  DATE_FORMAT(mesInicio, '%Y-%m-%d') 
                                AND
                                    DATE_FORMAT(@mesAtual, '%Y-%m-%d'));

	END IF;
    
    RETURN @totalVendas;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_avaliacaoproduto`
--

CREATE TABLE `tb_avaliacaoproduto` (
  `avp_codigo` int(11) NOT NULL,
  `avp_codproduto` int(11) NOT NULL,
  `avp_codcliente` int(11) NOT NULL,
  `avp_avaliacao` int(11) NOT NULL,
  `avp_codvenda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_avaliacaoproduto`
--

INSERT INTO `tb_avaliacaoproduto` (`avp_codigo`, `avp_codproduto`, `avp_codcliente`, `avp_avaliacao`, `avp_codvenda`) VALUES
(1, 1, 1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_categoria`
--

CREATE TABLE `tb_categoria` (
  `cat_codigo` int(11) NOT NULL,
  `cat_descricao` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_categoria`
--

INSERT INTO `tb_categoria` (`cat_codigo`, `cat_descricao`) VALUES
(1, 'Camiseta'),
(2, 'Moletom'),
(3, 'Meias');

-- --------------------------------------------------------

--
-- Table structure for table `tb_categoriaproduto`
--

CREATE TABLE `tb_categoriaproduto` (
  `catpro_codproduto` int(11) NOT NULL,
  `catpro_codcategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_categoriaproduto`
--

INSERT INTO `tb_categoriaproduto` (`catpro_codproduto`, `catpro_codcategoria`) VALUES
(1, 1),
(10, 2),
(11, 3),
(12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `cli_codigo` int(11) NOT NULL,
  `cli_nome` varchar(45) NOT NULL,
  `cli_email` varchar(45) NOT NULL,
  `cli_cpf` varchar(11) NOT NULL,
  `cli_senha` varchar(45) NOT NULL,
  `cli_dataCadastro` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_cliente`
--

INSERT INTO `tb_cliente` (`cli_codigo`, `cli_nome`, `cli_email`, `cli_cpf`, `cli_senha`, `cli_dataCadastro`) VALUES
(1, 'Giuseppe Setem', 'giuseppe@gap.com', '42042042042', '123456', '2018-07-01');

-- --------------------------------------------------------

--
-- Table structure for table `tb_funcionario`
--

CREATE TABLE `tb_funcionario` (
  `fun_codigo` int(11) NOT NULL,
  `fun_nome` varchar(45) NOT NULL,
  `fun_cpf` varchar(11) NOT NULL,
  `fun_senha` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_imagem`
--

CREATE TABLE `tb_imagem` (
  `img_codigo` int(11) NOT NULL,
  `img_nome` varchar(45) NOT NULL,
  `img_descricao` varchar(45) NOT NULL,
  `img_url` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_imagem`
--

INSERT INTO `tb_imagem` (`img_codigo`, `img_nome`, `img_descricao`, `img_url`) VALUES
(1, 'Camiseta_Thrasher_Classica.png', 'Camiseta_Thrasher_Classica', '/thrasher.png');

-- --------------------------------------------------------

--
-- Table structure for table `tb_imagemproduto`
--

CREATE TABLE `tb_imagemproduto` (
  `imgpro_codproduto` int(11) NOT NULL,
  `imgpro_codimagem` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_imagemproduto`
--

INSERT INTO `tb_imagemproduto` (`imgpro_codproduto`, `imgpro_codimagem`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_itemvenda`
--

CREATE TABLE `tb_itemvenda` (
  `itv_codvenda` int(11) NOT NULL,
  `itv_codproduto` int(11) NOT NULL,
  `itv_quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_itemvenda`
--

INSERT INTO `tb_itemvenda` (`itv_codvenda`, `itv_codproduto`, `itv_quantidade`) VALUES
(1, 1, 2),
(2, 1, 5),
(3, 1, 2),
(5, 1, 10),
(8, 2, 1),
(9, 1, 6);

--
-- Triggers `tb_itemvenda`
--
DELIMITER $$
CREATE TRIGGER `trg_alteraQtdeEstoque` AFTER INSERT ON `tb_itemvenda` FOR EACH ROW BEGIN
	UPDATE tb_produto SET tb_produto.pro_quantidade = pro_quantidade - NEW.itv_quantidade
	WHERE NEW.itv_codproduto = tb_produto.pro_codigo;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_verificaEstoque` BEFORE INSERT ON `tb_itemvenda` FOR EACH ROW BEGIN
	DECLARE quantidadeProduto INT(11);
    SELECT pro_quantidade 
    INTO quantidadeProduto
    FROM tb_produto
    WHERE NEW.itv_codproduto = tb_produto.pro_codigo;
    IF NEW.itv_quantidade > quantidadeProduto THEN
    	SIGNAL SQLSTATE '22542'
        SET MESSAGE_TEXT = 'Quantidade Indisponivel no Estoque', MYSQL_ERRNO = 22542;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_marca`
--

CREATE TABLE `tb_marca` (
  `mar_codigo` int(11) NOT NULL,
  `mar_descricao` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_marca`
--

INSERT INTO `tb_marca` (`mar_codigo`, `mar_descricao`) VALUES
(1, 'Thrasher'),
(2, 'Baker');

-- --------------------------------------------------------

--
-- Table structure for table `tb_marcaproduto`
--

CREATE TABLE `tb_marcaproduto` (
  `marpro_codproduto` int(11) NOT NULL,
  `marpro_codmarca` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_marcaproduto`
--

INSERT INTO `tb_marcaproduto` (`marpro_codproduto`, `marpro_codmarca`) VALUES
(1, 1),
(10, 1),
(11, 2),
(12, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_pedido`
--

CREATE TABLE `tb_pedido` (
  `ped_codigo` int(11) NOT NULL,
  `ped_codvenda` int(11) NOT NULL,
  `ped_enderecoEntrega` varchar(80) NOT NULL,
  `ped_status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_pedido`
--

INSERT INTO `tb_pedido` (`ped_codigo`, `ped_codvenda`, `ped_enderecoEntrega`, `ped_status`) VALUES
(1, 1, 'Av Brasil n 3891', 'ENVIADO');

-- --------------------------------------------------------

--
-- Table structure for table `tb_produto`
--

CREATE TABLE `tb_produto` (
  `pro_codigo` int(11) NOT NULL,
  `pro_descricao` varchar(45) NOT NULL,
  `pro_valor` decimal(10,0) NOT NULL,
  `pro_quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_produto`
--

INSERT INTO `tb_produto` (`pro_codigo`, `pro_descricao`, `pro_valor`, `pro_quantidade`) VALUES
(1, 'Thrasher Classica', '50', 35),
(2, 'NIKE SB', '150', 19),
(3, 'MOLETOM', '150', 20),
(4, 'Moletom GG', '150', 20),
(5, 'Moletom GGG', '150', 20),
(6, 'Moletom m', '151', 20),
(7, 'Moletom m', '151', 20),
(8, 'Moletom m', '151', 20),
(9, 'Moletom m', '151', 20),
(10, 'Moletom m', '151', 20),
(11, 'MEIA CREW', '60', 50),
(12, 'Camiseta ANDREW REYNOLDS', '200', 50);

-- --------------------------------------------------------

--
-- Table structure for table `tb_venda`
--

CREATE TABLE `tb_venda` (
  `ven_codigo` int(11) NOT NULL,
  `ven_data` datetime NOT NULL,
  `ven_valor` decimal(10,0) NOT NULL,
  `ven_codcliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_venda`
--

INSERT INTO `tb_venda` (`ven_codigo`, `ven_data`, `ven_valor`, `ven_codcliente`) VALUES
(1, '2018-07-01 16:54:12', '100', 1),
(2, '2018-07-02 03:24:31', '250', 1),
(3, '2018-07-02 03:25:51', '100', 1),
(4, '2018-07-02 03:26:44', '2600', 1),
(5, '2018-07-02 03:27:04', '500', 1),
(7, '2018-07-02 03:27:24', '2100', 1),
(8, '2018-08-31 04:07:16', '150', 1),
(9, '2018-08-31 04:07:29', '300', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_avaliacaoproduto`
--
ALTER TABLE `tb_avaliacaoproduto`
  ADD PRIMARY KEY (`avp_codigo`),
  ADD KEY `avp_codproduto_idx` (`avp_codproduto`),
  ADD KEY `avp_codcliente_idx` (`avp_codcliente`),
  ADD KEY `avp_codvenda_idx` (`avp_codvenda`);

--
-- Indexes for table `tb_categoria`
--
ALTER TABLE `tb_categoria`
  ADD PRIMARY KEY (`cat_codigo`);

--
-- Indexes for table `tb_categoriaproduto`
--
ALTER TABLE `tb_categoriaproduto`
  ADD KEY `catpro_codproduto_idx` (`catpro_codproduto`),
  ADD KEY `catpro_codcategoria_idx` (`catpro_codcategoria`);

--
-- Indexes for table `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`cli_codigo`);

--
-- Indexes for table `tb_funcionario`
--
ALTER TABLE `tb_funcionario`
  ADD PRIMARY KEY (`fun_codigo`);

--
-- Indexes for table `tb_imagem`
--
ALTER TABLE `tb_imagem`
  ADD PRIMARY KEY (`img_codigo`);

--
-- Indexes for table `tb_imagemproduto`
--
ALTER TABLE `tb_imagemproduto`
  ADD KEY `imgpro_codproduto_idx` (`imgpro_codproduto`),
  ADD KEY `imgpro_codimagem_idx` (`imgpro_codimagem`);

--
-- Indexes for table `tb_itemvenda`
--
ALTER TABLE `tb_itemvenda`
  ADD KEY `itv_codvenda_idx` (`itv_codvenda`),
  ADD KEY `itv_codproduto_idx` (`itv_codproduto`);

--
-- Indexes for table `tb_marca`
--
ALTER TABLE `tb_marca`
  ADD PRIMARY KEY (`mar_codigo`);

--
-- Indexes for table `tb_marcaproduto`
--
ALTER TABLE `tb_marcaproduto`
  ADD KEY `marpro_codproduto_idx` (`marpro_codproduto`),
  ADD KEY `marpro_codmarca_idx` (`marpro_codmarca`);

--
-- Indexes for table `tb_pedido`
--
ALTER TABLE `tb_pedido`
  ADD PRIMARY KEY (`ped_codigo`),
  ADD KEY `ped_codvenda_idx` (`ped_codvenda`);

--
-- Indexes for table `tb_produto`
--
ALTER TABLE `tb_produto`
  ADD PRIMARY KEY (`pro_codigo`);

--
-- Indexes for table `tb_venda`
--
ALTER TABLE `tb_venda`
  ADD PRIMARY KEY (`ven_codigo`),
  ADD KEY `cli_codigo_idx` (`ven_codcliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_avaliacaoproduto`
--
ALTER TABLE `tb_avaliacaoproduto`
  MODIFY `avp_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_categoria`
--
ALTER TABLE `tb_categoria`
  MODIFY `cat_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `cli_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_funcionario`
--
ALTER TABLE `tb_funcionario`
  MODIFY `fun_codigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_imagem`
--
ALTER TABLE `tb_imagem`
  MODIFY `img_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_marca`
--
ALTER TABLE `tb_marca`
  MODIFY `mar_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_pedido`
--
ALTER TABLE `tb_pedido`
  MODIFY `ped_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_produto`
--
ALTER TABLE `tb_produto`
  MODIFY `pro_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tb_venda`
--
ALTER TABLE `tb_venda`
  MODIFY `ven_codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_avaliacaoproduto`
--
ALTER TABLE `tb_avaliacaoproduto`
  ADD CONSTRAINT `avp_codcliente` FOREIGN KEY (`avp_codcliente`) REFERENCES `tb_cliente` (`cli_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `avp_codproduto` FOREIGN KEY (`avp_codproduto`) REFERENCES `tb_produto` (`pro_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `avp_codvenda` FOREIGN KEY (`avp_codvenda`) REFERENCES `tb_venda` (`ven_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_categoriaproduto`
--
ALTER TABLE `tb_categoriaproduto`
  ADD CONSTRAINT `catpro_codcategoria` FOREIGN KEY (`catpro_codcategoria`) REFERENCES `tb_categoria` (`cat_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `catpro_codproduto` FOREIGN KEY (`catpro_codproduto`) REFERENCES `tb_produto` (`pro_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_imagemproduto`
--
ALTER TABLE `tb_imagemproduto`
  ADD CONSTRAINT `imgpro_codimagem` FOREIGN KEY (`imgpro_codimagem`) REFERENCES `tb_imagem` (`img_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `imgpro_codproduto` FOREIGN KEY (`imgpro_codproduto`) REFERENCES `tb_produto` (`pro_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_itemvenda`
--
ALTER TABLE `tb_itemvenda`
  ADD CONSTRAINT `itv_codvenda` FOREIGN KEY (`itv_codvenda`) REFERENCES `tb_venda` (`ven_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pro_codigo` FOREIGN KEY (`itv_codproduto`) REFERENCES `tb_produto` (`pro_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_marcaproduto`
--
ALTER TABLE `tb_marcaproduto`
  ADD CONSTRAINT `marpro_codmarca` FOREIGN KEY (`marpro_codmarca`) REFERENCES `tb_marca` (`mar_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `marpro_codproduto` FOREIGN KEY (`marpro_codproduto`) REFERENCES `tb_produto` (`pro_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_pedido`
--
ALTER TABLE `tb_pedido`
  ADD CONSTRAINT `ped_codvenda` FOREIGN KEY (`ped_codvenda`) REFERENCES `tb_venda` (`ven_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_venda`
--
ALTER TABLE `tb_venda`
  ADD CONSTRAINT `ven_codcliente` FOREIGN KEY (`ven_codcliente`) REFERENCES `tb_cliente` (`cli_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
