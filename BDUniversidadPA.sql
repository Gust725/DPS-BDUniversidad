-- Procedimientos almacenados TEscuela
-- Gustavo Delgado
-- 8 de agosto 2022
-- PA para TEscuela

-- Usar BDUniversidad
use BDUniversidad
go
	

	----- Procedimientos TEscuela -----


-- Crear Agregar Escuela
if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	-- Escuela no puede ser duplicado
	if not exists(select Escuela from TEscuela where Escuela=@Escuela)
		begin
			insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
			select CodError = 0, Mensaje = 'Se inserto correctamente Escuela'
		end
	else select CodError = 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

-- Agregar Escuelas
exec spAgregarEscuela 'E06','Mecatronica','Ingenieria'
go


-- Crear Eliminar Escuela
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as
begin
	-- No se puede eliminar CodEscuela que no existe  
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			delete from TEscuela where CodEscuela=@CodEscuela 
			select CodError = 0, Mensaje = 'Se elimino correctamente la escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela ingresado no existente'
end
go

-- Eliminar Escuelas
exec spEliminarEscuela'E06'
go


-- Crear Actualizar Escuela
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- No se puede actualizar escuela que no existe 
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			update TEscuela set Escuela = @Escuela, Facultad = @Facultad where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo correctamente la escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela ingresado no existente'
end
go

-- Actualizar Escuelas
exec spActualizarEscuela 'E05','Mecatronica','Ingenieria'
go


-- Crear Buscar Escuela
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@CodEscuela char(3)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@CodEscuela
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela ingresado no existente'
end
go

-- Buscar Escuelas
exec spBuscarEscuela 'E05'
go


-- Crear Listar Escuela
if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

-- Listar Escuelas
exec spListarEscuela
go


	----- Procedimientos TAlumno -----


-- Crear Agregar Alumno
if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go
create proc spAgregarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime, @CodEscuela varchar(3)
as
begin
	-- CodAlumno no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	-- Alumno no puede estar en mas de una escuela
	if not exists(select CodEscuela from TAlumno where Apellidos=@Apellidos)
		begin
			insert into TAlumno values(@CodAlumno, @Apellidos, @Nombres, @LugarNac, @FechaNac, @CodEscuela)
			select CodError = 0, Mensaje = 'Se inserto correctamente Alumno'
		end
	else select CodError = 1, Mensaje = 'Error: Alumno ya existente en la escuela'
	else select CodError = 1, Mensaje = 'Error: CodAlumno duplicado'
end
go

-- Agregar Alumnos
exec spAgregarAlumno 'A0001','Delgado Ayca','Luis Gustavo','Tacna','2001-05-25 00:00:00','E01'
exec spAgregarAlumno 'A0002','Becerra Tapia','Steffi','Cusco','1999-02-07 00:00:00','E01'
go


-- Crear Eliminar Alumno
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go
create proc spEliminarAlumno
@CodAlumno char(5)
as
begin
	-- No se puede eliminar CodAlumno que no existe  
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			delete from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se elimino correctamente el Alumno ingresado'
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno ingresado no existente'
end
go

-- Eliminar Alumnos
exec spEliminarAlumno 'A0002'
go


-- Crear Actualizar Alumno
if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go
create proc spActualizarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime, @CodEscuela varchar(3)
as
begin
	-- No se puede actualizar alumno que no existe 
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			update TAlumno set Apellidos=@Apellidos, Nombres=@Nombres, LugarNac=@LugarNac,FechaNac=@FechaNac, CodEscuela=@CodEscuela where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se actualizo correctamente los datos del alumno'
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno ingresado no existente'
end
go

-- Actualizar Alumno
exec spActualizarAlumno 'A0001','Delgado Ayca','Luis Gustavo','Cusco','2001-05-25 00:00:00','E01'
go


-- Crear Buscar Alumno
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
@CodAlumno char(5)
as
begin
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno where CodAlumno=@CodAlumno
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno ingresado no existente'
end
go

-- Buscar Alumno
exec spBuscarAlumno 'A0001'
go


-- Crear Listar Alumno
if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go
create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno
end
go

-- Listar Alumnos
exec spListarAlumno
go
