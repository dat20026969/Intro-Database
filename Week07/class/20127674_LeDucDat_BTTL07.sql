--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  đề  tài  đủ  tất  cả  các  chủ  đề. 
select gv.ten
from giaovien gv
where not exists(
	(select distinct cd.macd 
	from chude cd)
	except
	(select distinct cd1.macd
	from giaovien gv1 join thamgiadt tgdt on gv1.magv = tgdt.magv
		join detai dt1 on tgdt.madt = dt1.madt
	where gv1.magv = gv.magv)
)

select gv.ten 
from giaovien gv
where not exists(
	select *
	from chude cd
	where not exists(
		select *
		from giaovien gv1 join thamgiadt tgdt on gv1.magv = tgdt.magv
			join detai dt on tgdt.madt = dt.madt
		where dt.macd = cd.macd
	)
)

select gv.ten
from giaovien gv join thamgiadt tgdt on gv.magv = tgdt.magv
	join detai dt on tgdt.madt = dt.madt
group by gv.ten, gv.magv
having count(distinct dt.macd) = (
	select count(distinct macd)
	from chude
)
--Cho  biết  tên  đề  tài  nào  mà  được  tất  cả  các  giáo  viên  của  bộ  môn  HTTT  tham  gia.
select dt.tendt
from  detai dt
where not exists(
	(select distinct gv.magv 
	from giaovien gv
	where gv.mabm = 'HTTT')
	except
	(select distinct gv1.magv
	from giaovien gv1 join thamgiadt tgdt on gv1.magv = tgdt.magv
	where tgdt.madt = dt.madt)
)

select dt.tendt
from  detai dt
where not exists(
	select *
	from giaovien gv
	where gv.mabm = 'HTTT' and not exists(
		select *
		from thamgiadt tgdt 
		where tgdt.magv = gv.magv and tgdt.madt = dt.madt
	)
)

select dt.tendt
from detai dt join thamgiadt tgdt on dt.madt = tgdt.madt
	join giaovien gv on gv.magv = tgdt.magv
where gv.mabm = 'HTTT'
group by dt.tendt, dt.madt
having count(distinct gv.magv) = (
	select count(distinct magv)
	from giaovien
	where mabm = 'HTTT'
)
--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  tất  cả  các  công  việc  của  đề  tài  006.
select gv.ten
from giaovien gv
where not exists(
	(select madt, sott
	from congviec
	where madt = '006')
	except
	(select dt.madt, st.stt
	from giaovien gv1 join thamgiadt tgdt on gv.magv = tgdt.magv
	where dt.madt = '006' and gv.magv = gv1.magv
	)
)

select gv.ten 
from giaovien gv
where not exists(
	select *
	from congviec cv
	where cv.madt = '006' and not exists (
		select *
		from thamgiadt tgdt
		where tgdt.magv = gv.magv and tgdt.madt = cv.madt and st.stt = cv.sott
	)
)

select gv.ten
from giaovien gv join thamgiadt tgdt on gv.magv = tgdt.magv
where tgdt.madt = '006'
group by gv.ten, gv.magv
having count(distinct st.stt) = (
	select count(*)
	from congviec
	where madt = '006'
)
--Cho  biết  giáo  viên  nào  đã  tham  gia  tất  cả  các  đề  tài  có  mã  chủ  đề  là  QLGD. 
select gv.ten
from giaovien gv
where not exists (
	(select distinct madt
	from detai
	where macd = 'QLGD')
	except
	(select distinct dt.madt
	from thamgiadt tgdt join detai dt on tgdt.madt = dt.madt
	where tgdt.magv = gv.magv and dt.macd = 'QLGD')
)