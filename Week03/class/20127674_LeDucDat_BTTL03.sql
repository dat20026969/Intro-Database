create database QLDt
go
use QLDt

--Cho  biết  tên  những  giáo  viên  KHOA  Công  nghệ  thông  tin. 
select GVIEN.TEN
from GIAOVIEN GVIEN join BOMON BMON on GVIEN.MABM = BMON.MABM
	join KHOA kh on BMON.MAKHOA = kh.MAKHOA
where kh.tenKHOA = N'Công nghệ thông tin';

--Cho  biết  thông  tin  của  bộ  môn  cùng  thông  tin  giảng  viên  làm  trưởng  bộ  môn  đó. 
select *
from BOMON BMON left join GIAOVIEN GVIEN on BMON.TRUONGBMON = GVIEN.MAGV

--Với  mỗi  giáo  viên,  hãy  cho  biết  thông  tin  của  bộ  môn  mà  họ  đang  làm  việc. 
select *
from GIAOVIEN GVIEN left join BOMON BMON on GVIEN.MABM = BMON.MABM

--Cho  biết  tên  người  chủ  nhiệm  đề  tài  của  những  đề  tài  thuộc  chủ  đề  Quản  lý  giáo  dục. 
select GVIEN.*
from GIAOVIEN GVIEN join DETAI d on GVIEN.MAGV = d.MADT 
	join CHUDE c on d.MACD = c.MACD
where c.TENCD = N'Quản lý giáo dục'

--Cho  biết  số  lượng  giáo  viên  viên  và  tổng  lương  của  họ. 
select count(*), sum(LUONG)
from GIAOVIEN

--Cho  biết  số  lượng  giáo  viên  và  lương  trung  bình  của  từng  bộ  môn. 
select MABM, count(MAGV), avg(LUONG)
from GIAOVIEN GVIEN
group by GVIEN.MABM

--Cho  biết  tên  chủ  đề  và  số  lượng  đề  tài  thuộc  về  chủ  đề  đó. 
select cd.TENCD, count(dt.MADT)
from DETAI dt join CHUDE cd on dt.MACD = cd.MACD
group by dt.macd, cd.TENCD

--Cho  biết  tên  giáo  viên  và  số  lượng  đề  tài  mà  giáo  viên  đó  tham  gia. 
select GVIEN.TEN, count(distinct t.MADT)
from GIAOVIEN GVIEN left join THAMGIADT t on GVIEN.MAGV = t.MAGV
group by GVIEN.MAGV, GVIEN.TEN

--Cho  biết  tên  giáo  viên  và  số  lượng  đề  tài  mà  giáo  viên  đó  làm  chủ  nhiệm.
select GVIEN.TEN, count(distinct d.MADT)
from GIAOVIEN GVIEN left join DETAI dt on GVIEN.MAGV = d.GVIENCNDT
group by GVIEN.MAGV, GVIEN.TEN

--Cho  biết  tên  những  giáo  viên  đã  tham  gia  từ  1  đề  tài  trở  lên. 
select GVIEN.TEN
from GIAOVIEN GVIEN join THAMGIADT t on GVIEN.MAGV = t.MAGV
group by GVIEN.MAGV, GVIEN.TEN
having count(distinct t.MADT) >= 1

--Cho  biết  mức  lương  cao  nhất  của  các  giảng  viên.
select max(LUONG)
from GIAOVIEN

select distinct gvien.LUONG
from GIAOVIEN gvien
where gvien.LUONG >= all (
	select g2.LUONG
	from GIAOVIEN g2)

--Cho  biết  những  giáo  viên  có  lương  lớn  nhất.
select gvien.*
from GIAOVIEN gvien
where g.LUONG >= all (
	select g2.LUONG
	from GIAOVIEN g2)

--Cho  biết  tên  những  giáo  viên  KHOA  Công  nghệ  thông  tin  mà  chưa  tham  gia  đề  tài  nào.
select gvien.TEN
from GIAOVIEN gvien join BOMON bmon on gvien.MABM = bmon.MABM
	join KHOA kh on bmon.MAKHOA = kh.MAKHOA
where kh.TENKHOA = N'Công nghệ thông tin' and gvien.MAGV not in (
	select MAGV
	from THAMGIADT)

--Tìm  những  trưởng  bộ  môn  tham  gia  tối  thiểu  1  đề  tài 
select distinct gvien.TEN
from GIAOVIEN gvien join BOMON bmon on gvien.MAGV = bmon.TRUONGBMON
	join THAMGIADT t on gvien.MAGV = t.MAGV

--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  đề  tài  đủ  tất  cả  các  chủ  đề. 
select gvien.TEN
from GIAOVIEN gvien 
where not exists(
	(select distinct cd.MACD 
	from CHUDE cd)
	except
	(select distinct d2.MACD
	from GIAOVIEN g2 join THAMGIADT t2 on g2.MAGV = t2.MAGV
		join DETAI d2 on t2.MADT = d2.MADT
	where g2.MAGV = gvien.MAGV)
)

select gvien.TEN 
from GIAOVIEN gvien
where not exists(
	select *
	from CHUDE cd
	where not exists(
		select *
		from GIAOVIEN g2 join THAMGIADT t on g2.MAGV = t.MAGV
			join DETAI dt on dt.MADT = dt.MADT
		where dt.MACD = cd.MACD
	)
)

select gvien.TEN
from GIAOVIEN gvien join THAMGIADT t on gvien.MAGV = t.MAGV
	join DETAI dt on t.MADT = dt.MADT
group by gvien.TEN, gvien.MAGV
having count(distinct dt.MACD) = (
	select count(distinct MACD)
	from CHUDE
)

--Cho  biết  tên  đề  tài  nào  mà  được  tất  cả  các  giáo  viên  của  bộ  môn  HTTT  tham  gia.
select dT.TENDT
from  DETAI dT
where not exists(
	(select distinct gvien.MAGV 
	from GIAOVIEN gvien
	where gvien.MABM = 'HTTT')
	except
	(select distinct g2.MAGV
	from GIAOVIEN g2 join THAMGIADT t on g2.MAGV = t.MAGV
	where t.MADT = dt.MADT)
)

select dt.TENDT
from  DETAI dt
where not exists(
	select *
	from GIAOVIEN gvien
	where gvien.MABM = 'HTTT' and not exists(
		select *
		from THAMGIADT t 
		where t.MAGV = gvien.MAGV and t.MADT = dt.MADT
	)
)

select dt.TENDT
from DETAI dt join THAMGIADT t on dt.MADT = t.MADT
	join GIAOVIEN gvien on gvien.MAGV = t.MAGV
where gvien.MABM = 'HTTT'
group by dt.TENDT, dt.MADT
having count(distinct gvien.MAGV) = (
	select count(distinct MAGV)
	from GIAOVIEN
	where MABM = 'HTTT'
)

--Cho  biết  giáo  viên  nào  đã  tham  gia  tất  cả  các  đề  tài  có  mã  chủ  đề  là  QLGD. 
select gvien.TEN
from GIAOVIEN gvien
where not exists (
	(select distinct MADT
	from DETAI
	where MACD = 'QLGD')
	except
	(select distinct dt.MADT
	from THAMGIADT t join DETAI dt on t.MADT = dt.MADT
	where t.MAGV = gvien.MAGV and dt.MACD = 'QLGD')
)

--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  tất  cả  các  công  việc  của  đề  tài  006.
select gvien.TEN
from GIAOVIEN gvien
where not exists(
	(select MADT, SOTT
	from CONGVIENIEC
	where MADT = '006')
	except
	(select t.MADT, t.STT
	from GIAOVIEN g2 join THAMGIADT t on g2.MAGV = t.MAGV
	where t.MADT = '006' and g.MAGV = g2.MAGV
	)
)

select gvien.TEN 
from GIAOVIEN gvien
where not exists(
	select *
	from CONGVIENIEC cv
	where cv.MADT = '006' and not exists (
		select *
		from THAMGIADT t
		where t.MAGV = gvien.MAGV and t.MADT = c.MADT and t.STT = c.STT
	)
)

select gvien.TEN
from GIAOVIEN gvien join THAMGIADT t on gvien.MAGV = t.MAGV
where t.MADT = '006'
group by gvien.TEN, gvien.MAGV
having count(distinct t.STT) = (
	select count(*)
	from CONGVIENIEC
	where MADT = '006'
)