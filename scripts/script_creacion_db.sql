-- GRUPO 16
-- Cotizador de Polizas
-- Script de creacion.
-- Zona
CREATE TABLE Zona(
	nombre varchar(50) NOT NULL,
	nroZona integer NOT NULL,
	PRIMARY KEY (nroZona)
);
-- Sucursal
CREATE TABLE Sucursal(
	nroSucursal integer NOT NULL,
	nombre varchar(50) NOT NULL,
	PRIMARY KEY (nroSucursal)
);
-- Rubro
CREATE TABLE Rubro(
	nroRubro integer NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion varchar(500),
	PRIMARY KEY (nroRubro)
);
-- Cobertura
CREATE TABLE Cobertura(
	nroCobertura integer NOT NULL,
	nombre varchar(50) NOT NULL,
	reaseguro varchar(50),
	coseguro varchar(50),
	descripcion varchar(50),
	PRIMARY KEY (nroCobertura)
);
-- Cliente
CREATE TABLE Cliente(
	dni integer NOT NULL,
	apellido varchar(100) NOT NULL,
	nombre varchar(100) NOT NULL,
	domicilio varchar(200) NOT NULL,
	telefono varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	PRIMARY KEY (dni)
);
-- Empleado
CREATE TABLE Empleado(
	legajo integer NOT NULL,
	dni integer NOT NULL,
	apellido varchar(100) NOT NULL,
	nombre varchar(100) NOT NULL,
	nroSucursal integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_empl_sucursal FOREIGN KEY (nroSucursal) REFERENCES Sucursal(nroSucursal)
);
-- Mesa Entrada
CREATE TABLE MesaEntrada(
	legajo integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_mesaEnt_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Inspector
CREATE TABLE Inspector(
	legajo integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_inspec_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- EjecutivoCuentas
CREATE TABLE EjecutivoCuentas(
	legajo integer NOT NULL,
	nroZona integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_ejecCue_zona FOREIGN KEY (nroZona) REFERENCES Zona(nroZona),
	CONSTRAINT fk_ejecCue_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Cubre
CREATE TABLE Cubre(
	nroRubro integer NOT NULL,
	nroCobertura integer NOT NULL,
	PRIMARY KEY	(nroRubro ,nroCobertura),
	CONSTRAINT fk_cubre_rubro FOREIGN KEY (nroRubro) REFERENCES Rubro(nroRubro),
	CONSTRAINT fk_cubre_cober FOREIGN KEY (nroCobertura) REFERENCES Cobertura(nroCobertura)
);
-- Cotizacion
CREATE TABLE Cotizacion(
	nroCotizacion integer NOT NULL,
	tipoVehiculo varchar(50) NOT NULL,
	cantCuota integer NOT NULL,
	fechaCotizacion date NOT NULL,
	fechaExpiracion date NOT NULL,
	dni integer NOT NULL,
	nroRubro integer NOT NULL,
	legajo integer NOT NULL,
	nroSucursal integer NOT NULL,
	aprobacion varchar(50) NOT NULL,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_cotiz_clie FOREIGN KEY (dni) REFERENCES Cliente(dni),
	CONSTRAINT fk_cotiz_rubro FOREIGN KEY (nroRubro) REFERENCES Rubro(nroRubro),
	CONSTRAINT fk_cotiz_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo),
	CONSTRAINT fk_cotiz_sucu FOREIGN KEY (nroSucursal) REFERENCES Sucursal(nroSucursal)
);
-- Autoriza Cotizacion
CREATE TABLE AutorizaCotizacion(
	nroCotizacion integer NOT NULL,
	legajo integer NOT NULL,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_autorCot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_autorCot_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Analiza Cotizacion
CREATE TABLE AnalizaCotizacion(
	nroCotizacion integer NOT NULL,
	legajo integer NOT NULL,
	PRIMARY KEY (nroCotizacion),
	CONSTRAINT fk_analCot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_analCot_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Productor
CREATE TABLE Productor(
	legajo integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_productor_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Posee Cobertura
CREATE TABLE PoseeCobertura(
	nroCotizacion integer NOT NULL,
	nroCobertura integer NOT NULL,
	PRIMARY KEY (nroCotizacion, nroCobertura),
	CONSTRAINT fk_rposCob_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_rposCob_cober FOREIGN KEY (nroCobertura) REFERENCES Cobertura(nroCobertura)
);
-- Poliza
CREATE TABLE Poliza(
	nroPoliza integer NOT NULL,
	nroCotizacion integer NOT NULL,
	dni integer NOT NULL,
	fechaEmision date NOT NULL,
	fechaVigencia date NOT NULL,
	PRIMARY KEY (nroPoliza),
	CONSTRAINT fk_poliz_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_poliz_clie FOREIGN KEY (dni) REFERENCES Cliente(dni)
);
-- Cuotas
CREATE TABLE Cuotas(
	nroCuota integer NOT NULL,
	nroCotizacion integer NOT NULL,
	fechaVencimiento date NOT NULL,
	monto integer NOT NULL,
	PRIMARY KEY (nroCuota, nroCotizacion),
	CONSTRAINT fk_cuot_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion)
);
-- Inspeccion
CREATE TABLE Inspeccion(
	nroInspeccion integer NOT NULL,
	aprobado varchar(50) NOT NULL,
	descripcion varchar(500),
	legajo integer NOT NULL,
	fechaInspeccion date NOT NULL,
	nroCotizacion integer NOT NULL,
	PRIMARY KEY (nroInspeccion, nroCotizacion),
	CONSTRAINT fk_inspe_cotiz FOREIGN KEY (nroCotizacion) REFERENCES Cotizacion(nroCotizacion),
	CONSTRAINT fk_inspe_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
-- Gerencia
CREATE TABLE Gerencia(
	legajo integer NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_gerenc_empl FOREIGN KEY (legajo) REFERENCES Empleado(legajo)
);
