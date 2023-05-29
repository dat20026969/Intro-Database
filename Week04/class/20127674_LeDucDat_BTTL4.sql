use QLDTGV
go

--Cho biet so luong giao vien va tong luong
select count(*), sum (luong)
from giaovien

--Cho biet so luong giao vien va luong trung binh cua tung bo mon
select mabm, count magv, avg(luong)
from giaovien gvien
group by gvien.mabm

--Cho biet ten chu de va so luong de tai thuoc ve chu de do
select cd.tencd, count (dt.madt)
from detai dt join chude cd on cd.macd
group by dt.macd, cd.tencd

--Cho biet ten giao vien va so luong de tai ma giao vien do tham gia
select gvien.ten, count(distinct dt.madt)
from giaovien gvien join thamgiadt tgdt on gvien.magv = tgdt.magv
group by gvien.magv, gvien.ten

--Cho biet ten giao vien va so luong de tai ma giao vien do chu nhom
select gvien.ten, count(distinct dt.madt)
from giaovien gvien join detai dt on gvien.magv = dt.magv
group by gvien.magv, gvien.ten

--Voi moi giao vien, cho biet ten giao vien va so nguoi than cua giao vien

--cho biet ten nhung giao vien da tham gia tu 3 de tai tro len
select gvien.ten
from giaovien gvien join thamgiadt tgdt on gvien.magv = tgdt.magv
group by gvien.magv, gvien.ten
having count (distinct tgdt.madt)>=3

