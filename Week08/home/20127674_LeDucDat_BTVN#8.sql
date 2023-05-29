create database phongtro123
go
use phongtro123
go

--Tao bang CSDL
create table phong(
	maphong nvarchar(5),
	tinhtrang nvarchar(5),
	loaiphong nvarchar(5),
	dongia numeric(10,2),
	primary key (maphong)
)

create table khach(
	makh nvarchar(5),
	hoten nvarchar(30),
	diachi nvarchar(100),
	dienthoai nvarchar(10),
	primary key (makh)
)

create table datphong(
	ma nvarchar(5),
	makh nvarchar(5),
	maphong nvarchar(5),
	ngaydp datetime,
	ngaytra datetime,
	thanhtien numeric(10,2),
	primary key (ma)
)
--Tao khoa ngoai
go

alter table datphong add
	constraint fk_datphong_makh
	foreign key (makh) references khach (makh),
	constraint fk_datphong_maphong
	foreign key (maphong) references phong (maphong)

go

insert into khach (makh) values
	(1),
	(2),
	(3);

insert into phong (maphong, tinhtrang, dongia) values
	(1, N'Rảnh', 2500000),
	(2, N'Bận', 3000000),
	(3, N'Rảnh', 3500000);

go

--Store procedure spDatPhong
create procedure spDatPhong
	@makh int,
	@maphong int,
	@ngaydat datetime
as
begin
	declare @available int
	set @available = 1
	if(@makh not in 
	(select makh
	from khach))
	begin
		set @available = 0
		print 'There are no customers in the room'
	end
	if(not exists(
	select *
	from phong
	where maphong = @maphong and tinhtrang = N'Rảnh'))
	begin
		set @available = 0
		print 'There is no free room for you'
	end
	if(@available = 1)
	begin
		declare @ma int
		select @ma = isnull (max(ma), 0) + 1
		from datphong
		insert into datphong(ma, makh, maphong, ngaydp) values
			(@ma, @makh, @maphong, @ngaydat)
		update phong
			set tinhtrang = N'Bận'
			where maphong = @maphong
		print 'Added successfully'
	end
	else
		print 'Cannot be added'
end
go
delete from datphong
update phong
	set tinhtrang = N'Rảnh'
select * from phong
select * from khach
select * from datphong
exec spDatPhong 1, 1, '03-28-2022'
exec spDatPhong 2, 3, '03-20-2022'

go

--Store procedure spTraPhong
create procedure spTraPhong
	@madp int,
	@makh int
as
begin
	declare @available int
	set @available = 1
	if(not exists(
	select *
	from datphong
	where ma = @madp and makh = @makh))
	begin
		print 'Does not exist that room and customer code in the reservation'
		set @available = 0
	end
	if(@available = 1)
	begin
		declare @dongia numeric(8, 2), @maphong int
		select @dongia = p.dongia, @maphong = p.maphong
		from phong p join datphong d on p.maphong = d.maphong
		where d.ma = @madp
		print @dongia
		update datphong 
		set	ngaytra = getdate(), thanhtien = datediff(d, ngaydp, getdate()) * @dongia
		where ma = @madp
		update phong 
		set tinhtrang = N'Rảnh'
		where maphong = @maphong
		print 'Checked Successfully'
	end
	else
		print 'Cannot be checked'
end
go
select * from phong
select * from khach
select * from datphong
exec spTraPhong 2, 2
