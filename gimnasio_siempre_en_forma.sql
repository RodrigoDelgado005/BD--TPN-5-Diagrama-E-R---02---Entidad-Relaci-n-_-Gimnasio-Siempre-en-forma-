-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-06-2024 a las 03:31:19
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gimnasio siempre en forma`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aparatos`
--

CREATE TABLE `aparatos` (
  `id_aparato` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado_conservacion` enum('bueno','regular','malo') NOT NULL,
  `id_sala` int(11) NOT NULL,
  `id_tipo_aparato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenciaclase`
--

CREATE TABLE `asistenciaclase` (
  `id_asistencia` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

CREATE TABLE `clases` (
  `id_clase` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `dia_hora` datetime NOT NULL,
  `id_sala` int(11) NOT NULL,
  `dni_monitor` int(11) NOT NULL,
  `capacidad_maxima` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `monitor`
--

CREATE TABLE `monitor` (
  `dni` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `telefono` int(11) NOT NULL,
  `titulacion` tinyint(1) NOT NULL,
  `experiencia_profesional` varchar(255) NOT NULL,
  `especialidad` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pistasquash`
--

CREATE TABLE `pistasquash` (
  `id_pista` int(11) NOT NULL,
  `estado` enum('disponible','ocupada','mentinimiento') NOT NULL,
  `id_sala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id_reserva` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_pista` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `duracion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salas`
--

CREATE TABLE `salas` (
  `id_sala` int(11) NOT NULL,
  `metros_cuadrados` decimal(10,0) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `tipo_sala` enum('cardio','general','muscular','squash') NOT NULL,
  `tiene_aparato` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `telefono` int(11) NOT NULL,
  `profesion` text NOT NULL,
  `datos_bancarios` varchar(155) NOT NULL,
  `fecha_alta` date NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoaparatos`
--

CREATE TABLE `tipoaparatos` (
  `id_tipo_aparato` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aparatos`
--
ALTER TABLE `aparatos`
  ADD PRIMARY KEY (`id_aparato`),
  ADD KEY `aparatos_id_sala_salas_id_sala` (`id_sala`),
  ADD KEY `aparatos_id_tipo_aparato_TipoAparatos_id_tipo_aparato` (`id_tipo_aparato`);

--
-- Indices de la tabla `asistenciaclase`
--
ALTER TABLE `asistenciaclase`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `AsistenciaClase_id_socio_socio_id_socio` (`id_socio`),
  ADD KEY `AsistenciaClase_id_clase_clases_id_clase` (`id_clase`);

--
-- Indices de la tabla `clases`
--
ALTER TABLE `clases`
  ADD PRIMARY KEY (`id_clase`),
  ADD KEY `clases_id_sala_salas_id_sala` (`id_sala`),
  ADD KEY `clases_dni_monitor_monitor_dni` (`dni_monitor`);

--
-- Indices de la tabla `monitor`
--
ALTER TABLE `monitor`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `pago_id_socio_socio_id_socio` (`id_socio`);

--
-- Indices de la tabla `pistasquash`
--
ALTER TABLE `pistasquash`
  ADD PRIMARY KEY (`id_pista`),
  ADD KEY `PistaSquash_id_sala_salas_id_sala` (`id_sala`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `reserva_id_socio_socio_id_socio` (`id_socio`),
  ADD KEY `reserva_id_pista_salas_id_sala` (`id_pista`);

--
-- Indices de la tabla `salas`
--
ALTER TABLE `salas`
  ADD PRIMARY KEY (`id_sala`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`id_socio`);

--
-- Indices de la tabla `tipoaparatos`
--
ALTER TABLE `tipoaparatos`
  ADD PRIMARY KEY (`id_tipo_aparato`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aparatos`
--
ALTER TABLE `aparatos`
  ADD CONSTRAINT `aparatos_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`),
  ADD CONSTRAINT `aparatos_id_tipo_aparato_TipoAparatos_id_tipo_aparato` FOREIGN KEY (`id_tipo_aparato`) REFERENCES `tipoaparatos` (`id_tipo_aparato`);

--
-- Filtros para la tabla `asistenciaclase`
--
ALTER TABLE `asistenciaclase`
  ADD CONSTRAINT `AsistenciaClase_id_clase_clases_id_clase` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`),
  ADD CONSTRAINT `AsistenciaClase_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

--
-- Filtros para la tabla `clases`
--
ALTER TABLE `clases`
  ADD CONSTRAINT `clases_dni_monitor_monitor_dni` FOREIGN KEY (`dni_monitor`) REFERENCES `monitor` (`dni`),
  ADD CONSTRAINT `clases_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

--
-- Filtros para la tabla `pistasquash`
--
ALTER TABLE `pistasquash`
  ADD CONSTRAINT `PistaSquash_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_id_pista_salas_id_sala` FOREIGN KEY (`id_pista`) REFERENCES `salas` (`id_sala`),
  ADD CONSTRAINT `reserva_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
