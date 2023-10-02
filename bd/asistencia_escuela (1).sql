-- phpMyAdmin SQL Dump
-- version 5.2.1-1.fc37
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 14-04-2023 a las 00:01:25
-- Versión del servidor: 10.5.18-MariaDB
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `asistencia_escuela`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidoPaterno` varchar(255) NOT NULL,
  `apellidoMaterno` varchar(255) NOT NULL,
  `grupo_id` int(11) NOT NULL,
  `RFIDcard` varchar(8) DEFAULT NULL,
  `CorreoTutor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `grupo_id`, `RFIDcard`, `CorreoTutor`) VALUES
(11, 'Salvador Sebastian', 'Zaragoza', 'Hurtado', 1, '0378A343', NULL),
(12, 'Francisco Nathael', 'Sanchez', 'Ceballos', 1, 'C390A842', NULL),
(13, 'Jose Angel', 'Maldonado', 'Zamora', 1, 'D3E71B42', NULL),
(14, 'luz elena', 'arcos', 'lopez', 1, '909E0232', NULL),
(15, 'ashley leilani', 'soto', 'santiago', 1, '136CBC43', NULL),
(16, 'brenda isela', 'zuñiga', 'donato', 1, 'F3EAE842', NULL),
(17, 'abrul alejandra', 'oyorzabal', 'martinez', 1, 'C37C3042', NULL),
(18, 'abraham ', 'gonzalez', 'melchor', 1, '63950D43', NULL),
(19, 'williams', 'cuenca', 'maldonado', 1, 'D37E0742', NULL),
(20, 'arely jazmin', 'sanchez', 'manzano', 1, '036D4D43', NULL),
(21, 'Isis Megan', 'Gonzales', 'Palmas', 1, '36B4', NULL),
(22, 'sarai', 'roman', 'flores', 1, 'C38CC242', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `materia_id` int(11) NOT NULL,
  `maestro_id` int(11) NOT NULL,
  `hora_de_entrada` time NOT NULL,
  `fecha` date NOT NULL,
  `asistio` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`id`, `alumno_id`, `materia_id`, `maestro_id`, `hora_de_entrada`, `fecha`, `asistio`) VALUES
(25, 12, 1, 12, '23:46:21', '2023-03-15', 1),
(26, 20, 1, 12, '23:46:31', '2023-03-15', 1),
(27, 19, 1, 12, '23:46:34', '2023-03-15', 1),
(28, 18, 1, 12, '23:46:38', '2023-03-15', 1),
(29, 17, 1, 12, '23:46:41', '2023-03-15', 1),
(30, 16, 1, 12, '23:46:44', '2023-03-15', 1),
(31, 14, 1, 12, '23:46:47', '2023-03-15', 1),
(32, 15, 1, 12, '23:46:49', '2023-03-15', 1),
(33, 13, 1, 12, '23:46:52', '2023-03-15', 1),
(34, 11, 1, 12, '23:46:58', '2023-03-15', 1),
(35, 11, 1, 12, '11:05:44', '2023-03-16', 1),
(36, 12, 1, 12, '11:06:32', '2023-03-16', 1),
(37, 13, 1, 12, '11:06:49', '2023-03-16', 1),
(38, 15, 1, 12, '11:07:01', '2023-03-16', 1),
(39, 14, 1, 12, '11:07:10', '2023-03-16', 1),
(40, 14, 1, 12, '11:07:17', '2023-03-16', 1),
(41, 16, 1, 12, '11:07:24', '2023-03-16', 1),
(42, 17, 1, 12, '11:07:32', '2023-03-16', 1),
(43, 18, 1, 12, '11:07:39', '2023-03-16', 1),
(44, 19, 1, 12, '11:07:46', '2023-03-16', 1),
(45, 20, 1, 12, '11:07:49', '2023-03-16', 1),
(46, 20, 1, 12, '11:48:50', '2023-03-16', 1),
(47, 22, 1, 12, '18:07:40', '2023-03-16', 1),
(48, 19, 1, 12, '18:17:53', '2023-03-16', 1),
(49, 17, 1, 12, '18:17:55', '2023-03-16', 1),
(50, 16, 1, 12, '18:17:59', '2023-03-16', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`id`, `nombre`) VALUES
(1, 'ofimatica'),
(2, 'soporte'),
(3, 'contabilidad'),
(4, 'trabajo social');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `id` int(11) NOT NULL,
  `GradoYGrupo` varchar(3) DEFAULT NULL,
  `especialidad_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`id`, `GradoYGrupo`, `especialidad_id`) VALUES
(1, '6°A', 1),
(2, '4°B', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `id` int(11) NOT NULL,
  `grupo_id` int(11) NOT NULL,
  `dia` varchar(255) DEFAULT NULL,
  `materia_id` int(11) NOT NULL,
  `maestro_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id`, `grupo_id`, `dia`, `materia_id`, `maestro_id`, `modulo_id`) VALUES
(1, 1, 'Lunes', 1, 12, 1),
(2, 1, 'Lunes', 1, 12, 2),
(3, 1, 'Lunes', 2, 13, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestro`
--

CREATE TABLE `maestro` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidoPaterno` varchar(255) NOT NULL,
  `apellidoMaterno` varchar(255) NOT NULL,
  `RFIDcard` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `maestro`
--

INSERT INTO `maestro` (`id`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `RFIDcard`) VALUES
(12, 'Francisco Javier', 'Cadena', 'Rosas', '03C0C343'),
(13, 'Edgar Manuel', 'Pali', 'Rodriguez', 'D3EE6642');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id`, `nombre`) VALUES
(1, 'Matemáticas'),
(2, 'Física'),
(3, 'Química'),
(4, 'Historia'),
(5, 'Inglés'),
(6, 'Informática');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id`, `nombre`, `hora_inicio`, `hora_fin`) VALUES
(1, 'Modulo 1', '07:00:00', '08:00:00'),
(2, 'Modulo 2', '08:00:00', '09:00:00'),
(3, 'Receso', '09:00:00', '09:30:00'),
(4, 'Modulo 3', '09:30:00', '10:30:00'),
(5, 'Modulo 4', '10:30:00', '11:30:00'),
(6, 'Modulo 5', '11:30:00', '12:30:00'),
(7, 'Modulo 6', '12:30:00', '13:30:00'),
(8, 'Modulo 7', '13:30:00', '14:30:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tutor`
--

CREATE TABLE `Tutor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_alumno_grupos` (`grupo_id`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_asistencia_materia` (`materia_id`),
  ADD KEY `fk_asistencia_maestro` (`maestro_id`),
  ADD KEY `fk_asistencia_alumno` (`alumno_id`) USING BTREE;

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_grupos_especialidad` (`especialidad_id`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_horario_modulo` (`modulo_id`),
  ADD KEY `fk_horario_materia` (`materia_id`),
  ADD KEY `fk_horario_maestro` (`maestro_id`),
  ADD KEY `grupo_id` (`grupo_id`);

--
-- Indices de la tabla `maestro`
--
ALTER TABLE `maestro`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Tutor`
--
ALTER TABLE `Tutor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `maestro`
--
ALTER TABLE `maestro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `Tutor`
--
ALTER TABLE `Tutor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_alumno_grupos` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`);

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `fk_asistencia_alumno_nueva` FOREIGN KEY (`alumno_id`) REFERENCES `alumno` (`id`),
  ADD CONSTRAINT `fk_asistencia_maestro` FOREIGN KEY (`maestro_id`) REFERENCES `maestro` (`id`),
  ADD CONSTRAINT `fk_asistencia_materia` FOREIGN KEY (`materia_id`) REFERENCES `materia` (`id`);

--
-- Filtros para la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD CONSTRAINT `fk_grupos_especialidad` FOREIGN KEY (`id`) REFERENCES `especialidad` (`id`);

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `fk_horario_maestro` FOREIGN KEY (`maestro_id`) REFERENCES `maestro` (`id`),
  ADD CONSTRAINT `fk_horario_materia` FOREIGN KEY (`materia_id`) REFERENCES `materia` (`id`),
  ADD CONSTRAINT `fk_horario_modulo` FOREIGN KEY (`modulo_id`) REFERENCES `modulos` (`id`),
  ADD CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
