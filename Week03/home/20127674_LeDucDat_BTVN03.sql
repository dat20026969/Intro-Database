use QLchuyenbay
go
--  Cho biết mã số tên phi công, địa chỉ,  điện thoại của các phi công đã từng lái máy bay B747
 select NV.manv,NV.ten, NV.diachi, NV.dienthoai
 FROM nhanvien NV, lichbay LB, phancong PC
 where LB.maloai = 'B747' and PC.macb = LB.macb AND PC.ngaydi = LB.ngaydi and PC.manv = NV.manv and NV.loainv = 1

-- Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay DCA trong khoảng thời gian từ 14h - 18h
 select CB.macb, LB.ngaydi
 from chuyenbay CB, lichbay LB
 where (sbdi = 'DCA' and (giodi between '14:00' and '18:00') and ( CB.macb = LB.macb))

 -- Cho biết những nhân viên được phân công trên chuyến bay có mã số 100 xuất phát tại sân bay SLC. các dòng chữ xuất ra không được phép trùng lắp
 select DISTINCT NV.ten
 from chuyenbay CB, nhanvien NV, phancong PC, lichbay LB
 where ((CB.macb = '100') and (sbdi = 'SLC') and PC.macb = CB.macb AND LB.macb = CB.macb and PC.ngaydi = LB.ngaydi AND NV.manv = PC.manv)

-- Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA. 
-- Các dòng dữ liệu xuất ra không được phép trùng lắp.
select l.maloai, l.sohieu
from lichbay l join chuyenbay c on l.macb = c.macb 
where c.sbdi = 'mia'

-- Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả các hành khách đi trên chuyến bay đó. 
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần.
select d.macb, d.ngaydi, k.ten, k.diachi, k.dienthoai
from datcho d join khachhang k on d.makh = d.makh
order by d.macb asc, d.ngaydi desc 


-- Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả những nhân viên được phân công trong chuyến bay đó. 
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần.
select p.macb, p.ngaydi, n.ten, n.diachi, n.dienthoai
from nhanvien n join phancong p on n.manv = p.manv
order by p.macb, p.ngaydi desc

-- Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công được phân vào chuyến bay hạ cánh xuống sân bay ORĐ
 select CB.macb, LB.ngaydi, NV.manv, ten
 from chuyenbay CB, nhanvien NV, phancong PC, lichbay LB
 where (CB.macb = PC.macb and PC.ngaydi = LB.ngaydi and NV.manv = PC.manv and CB.sbden = 'ORD' and LB.macb = CB.macb)

-- Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi công) trong đó phi công có mã số 1001 được phân công lái.
 select  PC.macb, ngaydi, ten
 from nhanvien NV, phancong PC
 where (NV.manv = '1001' and NV.manv = PC.manv)
 
--Với  mỗi  lịch  bay,  cho  biết  mã  chuyến  bay,  ngày  đi  cùng  với  số  lượng  nhân  viên  không 
--phải  là  phi  công  của  chuyến  bay  đó. 
select l.macb, l.ngaydi, count (p.manv)
from lichbay l join phancong p on (l.macb = p.macb and l.ngaydi = p.ngaydi)
	join nhanvien n on p.manv = n.manv
where n.loainv = 0
group by l.macb, l.ngaydi

-- Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi công) trong đó phi công có mã số 1001 được phân công lái.
 select  PC.macb, ngaydi, ten
 from nhanvien NV, phancong PC
 where (NV.manv = '1001' and NV.manv = PC.manv)

-- Cho biết thông tin(mã chuyến bay, sân bay đi, giờ đi, giờ đến, ngày đi) của những chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo ngày giảm dần, và sân bay xuất phát tăng dần
 select CB.macb, sbdi, giodi, gioden, ngaydi
 from chuyenbay CB, lichbay LB
 where (CB.sbden = 'DEN' and CB.macb = LB.macb )
 order by ngaydi DESC, sbdi ASC

-- Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay mà phi công này có khả năng lái. Xuất tên phi công, hãng sản xuất và maloai
 select ten, hangsx, LMB.maloai
 from KHANANG KN, nhanvien NV, loaimb LMB
 where( NV.manv = KN.manv and KN.maloai = LMB.maloai)

-- Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay mã số 100, và ngày 11/1/2000
 select NV.manv, ten
 from nhanvien NV, phancong PC, lichbay LB
 where (LB.macb = '100' and  LB.ngaydi = '11/01/2000' AND LB.macb = PC.macb AND NV.manv = PC.manv AND PC.ngaydi = LB.ngaydi)

-- Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công  vào chuyến bay xuất phát ngày 10/31/2000. tại sân bay MIA vào lúc 20h30
 select PC.macb, NV.manv, ten
 from nhanvien NV, phancong PC, chuyenbay CB, lichbay LB
 where(CB.sbdi = 'MIA' and CB.giodi = '20:30' and LB.ngaydi ='10/31/2000' and LB.macb = LB.macb and PC.ngaydi = LB.ngaydi and PC.macb = LB.macb and PC.manv = NV.manv and LB.macb = CB.macb)

-- Cho biết thông tin về chuyến bay mà phi công Quang đã lái(mã chuyến bay, số hiệu, mã loại, hãng sản xuất, )
  select PC.macb, sohieu, LMB.maloai, LMB.hangsx
  from nhanvien NV, phancong PC, loaimb LMB, lichbay LB, chuyenbay CB
  where NV.manv = PC.manv and NV.ten = 'Quang' and LB.macb = PC.macb and LB.maloai = LMB.maloai and LB.ngaydi = PC.ngaydi and LB.macb = CB.macb

-- Cho biết những phi công chưa được phân công chuyến bay nào 
 select ten
 from nhanvien 
 where (manv NOT IN (select PC.manv FROM phancong PC))
 
-- Cho biết tên những khách hàng đã đi chuyến bay trên máy bay của hãng BOEING
 select DISTINCT ten
 FROM khachhang KH, loaimb LMB, lichbay LB, datcho DC, chuyenbay CB
 where (LMB.hangsx = 'Boeing' and LB.maloai = LMB.maloai and DC.makh = KH.makh and DC.macb = LB.macb and DC.ngaydi = LB.ngaydi and CB.macb = LB.macb )

-- Cho biết mã các chuyến bay chỉ bay với máy bay số hiệu 10 và mã loại B747.
(select distinct macb
from lichbay
where sohieu = 10 and maloai = 'B747')
except
(select distinct macb
from lichbay
where sohieu != 10 or maloai != 'B747')