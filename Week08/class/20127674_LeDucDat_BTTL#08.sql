create database store_procedure_and_function
go
use store_procedure_and_function
go

-- a. Hello
create procedure helloWorld
as
	declare @greeting nvarchar(100)
	set @greeting = N'Hello World'
	select @greeting;

exec @greeting;

-- b. Tong 2 so bat ky
create procedure sumOf2Numbers
	@num1 int,
	@num2 int
as
	declare @sum int
	set @sum = @num1 + @num2
	select @sum

exec sumOf2Numbers 1,2;

-- c. Tong 2 so co output
use store_procedure_and_function
create procedure outputSum
	@num1 int,
	@num2 int,
	@sum1 int out
as
	set @sum1 = @num1 + @num2

declare @sum2 int
exec outputSum 10, 15, @sum2 out
print @sum2

-- d. Tong 3 so, su dung lai cau c
alter procedure outputSum3Num
	@num1 int,
	@num2 int,
	@num3 int,
	@sum1 int out
as
	declare @tempor int
	exec outputSum3Num @num1, @num2, @tempor out
	exec outputSum3Num @tempor, @num3, @sum1 out

declare @sum3 int
exec outputSum3Num 25, 3, 2, @sum3 out
print @sum3
-- e. Tong cac so trong khoang [m, n]
create procedure sum_from_m_to_n
	@m int,
	@n int
as
	declare @sum int, @i int
	set @sum = 0
	set @i = @m
	while (@i <= @n)
	begin
		set @sum = @sum + @i
		end
		set @i = @i + 1
	end
	select @sum

exec sum_from_m_to_n 3, 25;

-- f. Kiem tra so nguyen to
-- sao giong c++ the nho :v
create procedure checkPrimeNumber
	@n int
as
	declare @isPrime int
	set @isPrime = 1
	if(@n < 2)
		set @isPrime = 0
	else
	begin
		if(@n = 2)
			set @isPrime = 1
		else
		begin
			if(@n % 2 = 0)
				set @isPrime = 0
			else
			begin
			declare @i int
			set @i = 3
			while (@i * @i <= @n)
			begin
				if(@n % @i =0)
				begin
					set @isPrime = 0
					break
				end
				set @i = @i + 2
			end
			end
		end
	end	

	if(@isPrime = 1)
		print 'n la so nguyen to'
	else
		print 'n khong phai la so nguyen to'

exec checkPrimeNumber 25

-- g. In ra tổng các số nguyên tố trong đoạn [m, n]
-- h. Tim UCLN
alter procedure gcd
	@a int,
	@b int,
	@ucln int out
as
begin
	declare @a1 int, @b1 int
	if (@a < 0)
		set @a1 = -@a
	else 
		set @a1 = @a
	if (@b < 0)
		set @b1 = -@b
	else 
		set @b1 = @b
	while (@a1 != 0 and @b1 !=0)
	begin
		if(@a1 > @b1)
			set @a1 = @a1 % @b1
		else
			set @b1 = @b1 % @a1
	end
	if (@a1 = 0 and @b1 = 0)
		set @ucln = 1
	else
	begin
		if (@a1 = 0)
			set @ucln = @b1
		else
			set @ucln = @a1
	end
end

declare @ucln1 int
exec gcd 15, 15, @ucln1 out
print @ucln1

-- i.Tim BCNN
create procedure lcm
	@a int,
	@b int,
	@bcnn int out
as
	declare @a1 int, @b1 int
	if (@a < 0)
		set @a1 = -@a
	else 
		set @a1 = @a
	if (@b < 0)
		set @b1 = -@b
	else 
		set @b1 = @b
	declare @ucln2 int
	exec gcd @a1, @b1, @ucln2 out
	set @bcnn = @a1 * @b1 / @ucln2

declare @bcnn1 int
exec lcm 5,15, @bcnn1 out
print @bcnn1

-- j. Xuất ra toàn bộ danh sách giáo viên.
create procedure allGV
as
	select *
	from giaovien

go
exec allGV

go

-- k. Tính số lượng đề tài mà một giáo viên đang thực hiện.
create procedure arcicleCount
	@magv char(3),
	@articleAmount int out
as
	select @articleAmount = count(t.magv)
	from giaovien g left join thamgiadt t on g.magv = t.magv
	where g.magv = @magv

go
declare @articleAmount int
exec arcicleCount '005', @articleAmount out
print @articleAmount

go

-- l. In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
create procedure countRelative
	@magv char(3),
	@relativeAmount int out
as
	select @relativeAmount = count(n.magv)
	from giaovien gv left join nguoithan n on gv.magv = n.magv
	where gv.magv = @magv
go
alter procedure teacherIn4
	@magv char(3)
as
begin
	select *
	from giaovien
	where magv = @magv
	declare @articleAmount int
	exec arcicleCount @magv, @articleAmount out
	print 'So luong de tai tham gia cua giao vien: ' + cast(@articleAmount as varchar)
	declare @relativeAmount int
	exec countRelative @magv, @relativeAmount out
	print 'So luong nguoi than của tung giao vien: ' + cast(@relativeAmount as varchar)
end

go
exec teacherIn4 '005'

go
-- m/ Kiem tra su ton tai cua giao vien theo magv
use QlyGV
alter procedure GVexists 
	@magv char(5)
as
	if(exists(
	select *
	from giaovien
	where magv = @magv))
		print 'Existed';
	else
		print 'Not existed';

exec GVexists '003'

-- p. Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan (Có thân nhân, có làm đề tài, ...) thì báo lỗi.
go
create procedure gvDelete 
	@magv char(5)
as
begin
	declare @valid int
	set @valid = 1
	
	-- co tham gia de tai
	if(@magv in (
	select magv
	from thamgiadt))
		set @valid = 0
	
	-- co nguoi than
	if(@magv in (
	select magv
	from nguoithan))
		set @valid = 0
	
	-- co quan ly giang vien khac
	if(@magv in(
	select gvqlcm
	from giaovien))
		set @valid = 0
	
	-- lam truong bo mon
	if(@magv in (
	select truongbm
	from bomon))
		set @valid = 0
	
	-- lam truong khoa
	if(@magv in (
	select truongkhoa 
	from khoa))
		set @valid = 0
	
	-- lam chu nhiem de tai
	if(@magv in (
	select gvcndt
	from detai))
		set @valid = 0

	if(@valid = 1)
	begin
		delete from giaovien
		where magv = @magv
		print 'Remove Successfully'
	end
	else
		print 'Cannot be removed'
end

-- r. Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn c của b thì lương của a phải cao hơn lương của b. (a, b: mã giáo viên)
go
create procedure gvChecking
	@magv1 char(5),
	@magv2 char(5)
as
begin
	declare @regulated int
	set @regulated = 1
	if(@magv1 in (
	select b.truongbm
	from giaovien gv join bomon bm on gv.mabm = bm.mabm
	where gv.magv = @magv2))
	begin
		declare @luong1 numeric(6, 1), @luong2 numeric(6, 1)
		select @luong1 = luong
		from giaovien
		where magv = @magv1;
		select @luong2 = luong
		from giaovien
		where magv = @magv2;
		if(@luong1 <= @luong2)
			set @regulated = 2
	end

	if(@regulated = 1)
		print 'Regulated'
	else
		print 'Irregulated'
end
go
exec gvChecking '001', '005'

-- s. Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18, lương > 0
go
create procedure addGV
	@magv char(5),
	@hoten nvarchar(50),
	@luong numeric(6,1),
	@phai nchar(5),
	@ngsinh date,
	@diachi nvarchar(100),
	@gvqlcm char(5),
	@mabm nchar(5)
as
begin
	declare @regulated int
	set @regulated = 1
	if(@hoten in (
	select hoten
	from giaovien))
		set @regulated = 0
	if(datediff(y, @ngsinh, getdate()) <= 18)
		set @regulated = 0
	if(@luong < 0)
		set @regulated = 0
	if(@regulated = 1)
	begin
		insert into giaovien(magv, hoten, luong, phai, ngsinh, diachi, gvqlcm, mabm) values
			(@magv, @hoten, @luong, @phai, @ngsinh, @diachi, @gvqlcm, @mabm)
		print 'Added successfully'
	end
	else
		print 'Cannot be added'
end
go
exec addGV '009', N'Đạt', 10000.0, null, '03-25-2002', null, null, null
select * from giaovien



