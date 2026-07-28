-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-07-2026 a las 16:30:50
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fitcimm`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `id_ingreso` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `hora_ingreso` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`id_ingreso`, `id_socio`, `fecha_ingreso`, `hora_ingreso`) VALUES
(1, 1, '2026-07-01', '08:15:00'),
(2, 9, '2026-07-27', '20:57:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `membresia`
--

CREATE TABLE `membresia` (
  `id_membresia` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `valor_pagado` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `membresia`
--

INSERT INTO `membresia` (`id_membresia`, `id_socio`, `id_plan`, `fecha_inicio`, `fecha_fin`, `valor_pagado`) VALUES
(1, 1, 2, '2026-07-01', '2026-07-31', 75000.00),
(2, 2, 3, '2026-06-15', '2026-09-13', 195000.00),
(3, 3, 4, '2026-01-01', '2026-12-31', 650000.00),
(4, 4, 2, '2026-07-10', '2026-08-09', 75000.00),
(5, 5, 2, '2026-06-25', '2026-07-25', 75000.00),
(6, 6, 1, '2026-07-21', '2026-07-22', 8000.00),
(7, 7, 2, '2026-05-01', '2026-05-31', 75000.00),
(8, 8, 3, '2026-02-01', '2026-05-02', 195000.00),
(9, 1, 1, '2026-06-10', '2026-06-11', 8000.00),
(10, 2, 2, '2026-04-01', '2026-05-01', 75000.00),
(11, 4, 2, '2026-08-10', '2026-09-09', 75000.00),
(12, 9, 1, '2026-07-27', '2026-07-27', 8000.00),
(13, 10, 2, '2026-07-27', '2026-08-25', 75000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan`
--

CREATE TABLE `plan` (
  `id_plan` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `duracion_dias` int(11) NOT NULL CHECK (`duracion_dias` > 0),
  `valor` decimal(10,2) NOT NULL CHECK (`valor` > 0),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plan`
--

INSERT INTO `plan` (`id_plan`, `nombre`, `duracion_dias`, `valor`, `activo`) VALUES
(1, 'Dia', 1, 8000.00, 1),
(2, 'Mensual', 30, 75000.00, 1),
(3, 'Trimestral', 90, 195000.00, 1),
(4, 'Anual', 365, 650000.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL,
  `documento` varchar(15) NOT NULL,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`id_socio`, `documento`, `nombres`, `apellidos`, `telefono`, `correo`, `fecha_nacimiento`, `activo`) VALUES
(1, '1001001001', 'Juan', 'Perez', '3001111111', 'juan@gmail.com', '1998-05-12', 1),
(2, '1001001002', 'Maria', 'Gomez', '3002222222', 'maria@gmail.com', '1995-08-20', 1),
(3, '1001001003', 'Carlos', 'Rodriguez', '3003333333', 'carlos@gmail.com', '1992-11-15', 1),
(4, '1001001004', 'Laura', 'Martinez', '3004444444', 'laura@gmail.com', '2000-02-10', 1),
(5, '1001001005', 'Andres', 'Lopez', '3005555555', 'andres@gmail.com', '1997-09-30', 1),
(6, '1001001006', 'Sofia', 'Ramirez', '3006666666', 'sofia@gmail.com', '2001-01-18', 1),
(7, '1001001007', 'Miguel', 'Torres', '3007777777', 'miguel@gmail.com', '1994-06-25', 1),
(8, '1001001008', 'Valentina', 'Castro', '3008888888', 'valentina@gmail.com', '1999-12-05', 1),
(9, '1058274558', 'Juan Roberto', 'Perez Castro', '3134883509', 'juan@gmail.com', '2007-09-28', 1),
(10, '1058274553', 'Sofia', 'Lara', '3134883509', 'david@gmail.com', '2005-11-24', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`id_ingreso`),
  ADD UNIQUE KEY `uk_ingreso` (`id_socio`,`fecha_ingreso`);

--
-- Indices de la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD PRIMARY KEY (`id_membresia`),
  ADD KEY `fk_mem_socio` (`id_socio`),
  ADD KEY `fk_mem_plan` (`id_plan`);

--
-- Indices de la tabla `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`id_plan`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`id_socio`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `id_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `membresia`
--
ALTER TABLE `membresia`
  MODIFY `id_membresia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `plan`
--
ALTER TABLE `plan`
  MODIFY `id_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `socio`
--
ALTER TABLE `socio`
  MODIFY `id_socio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ing_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

--
-- Filtros para la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD CONSTRAINT `fk_mem_plan` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`),
  ADD CONSTRAINT `fk_mem_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
