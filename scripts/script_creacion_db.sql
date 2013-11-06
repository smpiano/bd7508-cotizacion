-- GRUPO 16
-- Cotizador de Polizas
-- Script de creacion.
﻿-------------------------------------------------------
CREATE TABLE Zona(
	nombre varchar(50),
	nroZona integer,
	PRIMARY KEY (nroZona)
);
-------------------------------------------------------
CREATE TABLE Sucursal(
	nroSucursal integer,
	nombre varchar(50),
	PRIMARY KEY (nroSucursal)
);
-------------------------------------------------------
CREATE TABLE Rubro(
	nroRubro integer,
	nombre varchar(50),
	descripcion varchar(500),
	PRIMARY KEY (nroRubro)
);
-------------------------------------------------------
CREATE TABLE Cobertura(
	nroCobertura integer,
	nombre varchar(50),
	reaseguro varchar(50),
	coseguro varchar(50),
	descripcion varchar(50),
	PRIMARY KEY (nroCobertura)
);
-------------------------------------------------------
CREATE TABLE Cliente(
	dni integer,
	apellido varchar(100),
	nombre varchar(100),
	domicilio varchar(200),
	PRIMARY KEY (dni)
);
-------------------------------------------------------
CREATE TABLE Empleado(
	legajo integer,
	dni integer,
	apellido varchar(100),
	nombre varchar(100),
	nroSucursal integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_empl_sucursal FOREIGN KEY (nroSucursal) REFERENCES Sucursal(nroSucursal)
);
-------------------------------------------------------
CREATE TABLE MesaEntrada(
	legajo integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_mesaEnt_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE Inspector(
	legajo integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_inspec_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE EjecutivoCuentas(
	legajo integer,
	nroZona integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_ejecCue_zona FOREIGN KEY (nroZona) REFERENCES Zona(nroZona),
	CONSTRAINT fk_ejecCue_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE Cubre(
	nroRubro integer,
	nroCobertura integer,
	PRIMARY KEY	(nroRubro ,nroCobertura),
	CONSTRAINT fk_cubre_rubro FOREIGN KEY (nroRubro) REFERENCES Rubro(nroRubro),
	CONSTRAINT fk_cubre_cober FOREIGN KEY (nroCobertura) REFERENCES Cobertura(nroCobertura)
);
-------------------------------------------------------
CREATE TABLE Cotizacion(
	nroCotizacion integer,
	tipoVehiculo varchar(50),
	cantCuota integer,
	fechaCotizacion date,
	fechaExpiracion date,
	dni integer,
	nroRubro integer,
	legajo integer,
	nroSucursal integer,
	aprobacion varchar(50),
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_cotiz_clie FOREIGN KEY (dni) REFERENCES Cliente(dni),
	CONSTRAINT fk_cotiz_rubro FOREIGN KEY (nroRubro) REFERENCES Rubro(nroRubro),
	CONSTRAINT fk_cotiz_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo),
	CONSTRAINT fk_cotiz_sucu FOREIGN KEY (nroSucursal) REFERENCES Sucursal(nroSucursal)
);
-------------------------------------------------------
CREATE TABLE AutorizaCotizacion(
	nroCotizacion integer,
	legajo integer,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_autorCot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_autorCot_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE AnalizaCotizacion(
	nroCotizacion integer,
	legajo integer,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_analCot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_analCot_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE RelacionTrabaja(
	legajo integer,
	nroSucursal integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_rtrabaja_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo),
	CONSTRAINT fk_rtrabaja_sucu FOREIGN KEY (nroSucursal) REFERENCES Sucursal(nroSucursal)
);
-------------------------------------------------------
CREATE TABLE RelacionSolicitaCotizacion(
	nroCotizacion integer,
	dni integer,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_rsolic_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_rsolic_clie FOREIGN KEY (dni) REFERENCES Cliente(dni)
);
-------------------------------------------------------
CREATE TABLE Productor(
	legajo integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_productor_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE PoseeCobertura(
	nroCotizacion integer,
	nroCobertura integer,
	PRIMARY KEY (nroCotizacion, nroCobertura),
	CONSTRAINT fk_rposCob_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_rposCob_cober FOREIGN KEY (nroCobertura) REFERENCES Cobertura(nroCobertura)
);
-------------------------------------------------------
CREATE TABLE Poliza(
	nroPoliza integer,
	nroCotizacion integer,
	dni integer,
	fechaEmision date,
	fechaVigencia date,
	PRIMARY KEY (nroPoliza),
	CONSTRAINT fk_poliz_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_poliz_clie FOREIGN KEY (dni) REFERENCES Cliente(dni)
);
-------------------------------------------------------
CREATE TABLE Cuotas(
	nroCuota integer,
	nroCotizacion integer,
	fechaVencimiento date,
	monto integer,
	PRIMARY KEY (nroCuota, nroCotizacion),
	CONSTRAINT fk_cuot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion)
);
-------------------------------------------------------
CREATE TABLE Inspeccion(
	nroInspeccion integer,
	aprobado varchar(50),
	descripcion varchar(500),
	legajo integer,
	fechaInspeccion date,
	nroCotizacion integer,
	PRIMARY KEY (nroInspeccion, nroCotizacion),
	CONSTRAINT fk_inspe_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_inspe_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-------------------------------------------------------
CREATE TABLE Gerencia(
	legajo integer,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_gerenc_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
