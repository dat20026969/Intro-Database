--Quan li de tai
-- Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn hệ thống thông tin tham gia
select tendt
from detai dt
where dt.madt in(select dt.madt
    from detai dt
    where not exists (select gv.magv
          from giaovien gv
          where gv.mabm = 'HTTT'
          except
          select tgdt.magv
          from thamgiadt tgdt
          where dt.madt = tgdt.madt 
          )
)
-- Câu 61: Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD
select *
from giaovien gv
where not exists (select dt.madt
      from detai dt
      where dt.macd = 'QLGD'
      except 
      select tgdt.madt
      from thamgiadt tgdt
      where gv.magv = tgdt.magv
)
-- Câu 63: Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia
select tendt
from detai dt
where dt.madt in(select dt.madt
    from detai dt
    where not exists (select gv.magv
          from giaovien gv, bomon bm
          where gv.mabm = bm.mabm and bm.tenbm = N'Hóa hữu cơ'
          except
          select tgdt.magv
          from thamgiadt tgdt
          where dt.madt = tgdt.madt
           )
)
-- Câu 65: Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề ứng dụng công nghệ
select *
from giaovien gv
where not exists (select dt.madt
      from detai dt, chude cd
      where dt.macd = cd.macd and cd.tencd = N'Ứng dụng công nghệ'
      except 
      select tgdt.madt
      from thamgiadt tgdt
      where gv.magv = tgdt.magv
	  )
-- 67: Cho biết tên đề tài nào được tất cả giáo viên của khhangoa CNTT tham gia
select tendt
from detai dt
where dt.madt in(select dt.madt
    from detai dt
    where not exists (select gv.magv
          from giaovien gv, bomon bm
          where gv.mabm = bm.mabm and bm.makhoa = 'CNTT'
          except
          select tgdt.magv
          from thamgiadt tgdt
          where dt.madt = tgdt.madt
           )
)
-- 69: Tìm tên các giáo viên được phân công làm tất cả các công việc của đề tài có kinh phí trên 100tr
select gv.ten
from giaovien gv
where gv.magv in(select gv.magv
      from giaovien gv
      where not exists (select dt.madt
         from detai dt
         where dt.kinhphi >100000000
      
         except
         select tgdt.madt
         from thamgiadt tgdt
         where gv.magv = tgdt.magv
         ) 
)
-- 71: Cho biết mã số, họ tên, ngày sinh của giáo viên của giáo viên tham gia tất cả các công việc của đề tài ứng dụng xanh 
select gv.ten, gv.magv, gv.ngaysinh
from giaovien gv
where gv.magv in(select gv.magv
      from giaovien gv
      where not exists (select dt.madt, cv.sott
         from detai dt, congviec cv
         where dt.madt = cv.madt and dt.tendt = N'Ứng dụng xanh'
      
         except
         select tgdt.madt
         from thamgiadt tgdt
         where gv.magv = tgdt.magv
         )
)
----------------------------------------------
-- Quan li chuyen bay
--51:Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng "Boeing"
select lbay.macb
from lichbay lbay
where not exists (select *
from loaimb lmbay
where lmbay.hangsx='BOEING' and not exists (select *
from lichbay lbay
where lbay.maloai=lmbay.maloai and lbay.macb=lbay.macb))

--52:Cho biết mã và tên phi công có khhangả năng lái tất cả các máy bay của hãng "Airbus"
select nv.manv,nv.ten
from nhanvien nv
where not exists (select *
from loaimb lmbay, khhanganang knang
where lmbay.hangsx='AIRBUS'and lmbay.maloai=knang.maloai and not exists (select *
from khhanganang knang1
where knang1.manv=nv.manv and knang1.maloai=knang.maloai))

--53:Cho biết tên nhân viên (khhangông phải là phi công)được phân công bay vào tất cả các chuyến bay có mã 100
select nv.ten
from nhanvien nv
where nv.loainv <>1 and not exists (select *
from phancong pcong
where pcong.macb=100 and not exists (select *
from phancong pcong1
where pcong1.manv=nv.manv and pcong1.macb=pcong.macb and pcong1.ngaydi=pcong.ngaydi))

--54--Cho biết ngày đi nào mà tất cả các loại máy bay của hãng "Boeing" tham gia
select lbay.ngaydi
from lichbay lbay
where not exists (select *
from loaimb lmbay
where lmbay.hangsx ='BOEING' and not exists (select *
from lichbay lbay1
where lbay1.maloai=lmbay.maloai and lbay.ngaydi=lbay1.ngaydi))

--55:Cho biết loại máy bay của hãng "Boeing" nào có tham gia vào tất cả các ngày đi
select lmbay.maloai
from loaimb lmbay
where lmbay.hangsx='BOEING' and not exists (select *
from lichbay lbay
where not exists (select *
from lichbay lbay2
where lbay2.maloai=lmbay.maloai and lbay2.ngaydi=lbay.ngaydi))

--56:Cho biết mã và tên các khhangách hàng có đặt chổ trong tất cả các ngày từ 31/10/2000 và 11/1/2000
select khhang.makh, khhang.ten
from khachhang khhang
where not exists (select *
from datcho dcho
where dcho.ngaydi between '10/31/2000' and '11/1/2000' and not exists (select *
from datcho dcho1
where dcho1.makh=khhang.makh and dcho1.ngaydi=dcho.ngaydi))

--57:Cho biết mã và tên phi công khhangông có khhangả năng lái được tất cả các máy bay của hãng "Airbus"
select nv.ten,nv.manv
from nhanvien nv
where nv.loainv=1 and exists (select *
from loaimb lmbay
where lmbay.hangsx='AIRBUS' and not exists (select *
from khhanganang knang
where knang.maloai=lmbay.maloai and knang.manv=nv.manv))

--58:Cho biết sân bay nào đã có tất cả các loại máy bay của hãng "Boeing" xuất phát
select cb.sobd
from chuyenbay cb
where not exists (select *
from loaimb lmbay, lichbay lbay
where lbay.maloai=lmbay.maloai and lmbay.hangsx='BOEING' and not exists (select *
from chuyenbay cb1
where cb1.sobd=cb.sobd and cb1.macb=lbay.macb))