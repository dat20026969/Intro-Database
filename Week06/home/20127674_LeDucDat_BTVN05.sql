 -- Câu 34: Cho biết hãng sản xuất, mã loại và số hiệu của máy bay được sử dụng nhiều nhất
 SELECT hangsx, lmb.maloai, lb.sohieu
 FROM loaimb lmb, lichbay lba
 WHERE lmb.maloai = lb.maloai 
 GROUP BY hangsx, lmb.maloai, lb.sohieu
 HAVING COUNT(lb.sohieu) >= ALL(SELECT COUNT(*)
          FROM lichbay lbb 
          GROUP BY lbb.maloai, lbb.sohieu
          )
 -- Câu 35: Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất
 SELECT nv.hoten
 FROM nhanvien nv, phancong pc
 WHERE nv.manv = pc.manv AND nv.loainv = 0
 GROUP BY nv.hoten
 HAVING COUNT(nv.manv) >= ALL (SELECT COUNT(*) 
       FROM phancong pc, nhanvien nv
       WHERE nv.manv = pc.manv AND nv.loainv = 0
       GROUP BY pc.manv)         
 -- Câu 36: Cho biết thông tin của phi công(Tên, địa chỉ, điện thoại) lái nhiều chuyến bay nhất
 SELECT nv.hoten, nv.diachi, nv.dienthoai
 FROM nhanvien nv, phancong pc
 WHERE pc.manv = nv.manv AND nv.loainv = 1
 GROUP BY nv.hoten, nv.diachi, nv.dienthoai
 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
        FROM phancong pc, nhanvien nv
        WHERE pc.manv = nv.manv AND nv.loainv = 1
        GROUP BY pc.manv)
 -- Câu 37: Cho biết sân bay(sbden) và số lượng chuyến bay của sân bay có ít chuyến bay đáp xuống nhất
 SELECT sbden, COUNT(*) slcbaydap
 FROM chuyenbay cb
 GROUP BY cb.sbden
 HAVING COUNT(*) <= ALL (SELECT COUNT(*)
       FROM chuyenbay cb
       GROUP BY cb.sbden)
 -- Câu 38: Cho biết sân bay(sbdi) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất phát nhất
 SELECT sbdi, COUNT(*) slcbaycatcanh
 FROM chuyenbay cb
 GROUP BY cb.sbdi
 HAVING COUNT(*) >= ALL (SELECT COUNT(*) 
       FROM chuyenbay cb
       GROUP BY cb.sbdi)
 -- Câu 39: Cho biết tên, địa chỉ, điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất
 SELECT hoten, diachi, dienthoai
 FROM khachhang kh, datcho dc
 WHERE kh.makh = dc.makh
 GROUP BY dc.makh
 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
       FROM datcho dc
       GROUP BY dc.makh)
 -- Câu 40: Cho biết mã số, tên, lương của các phi công có khả năng lái nhiều máy bay nhất
 SELECT kn.manv, hoten, luongnv
 FROM nhanvien nv, khanang kn
 WHERE nv.manv = kn.manv
 GROUP BY kn.manv 
 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
       FROM khanang kn
       GROUP BY kn.manv)
  
 -- Câu 41: Cho biết thông tin của nhân viên(mã, tên, lương) của nhân viên có lương cao nhất
 SELECT manv, hoten, luongnv
 FROM nhanvien 
 WHERE luongnv = (SELECT MAX(luongnv)
     FROM nhanvien)
 -- Câu 42: Cho biết tên, địa chỉ, của các nhân viên LƯƠNG cao nhất trong phi hành đoàn(các nhân viên được phân công trong 1 chuyến bay mà người đó tham gia
 SELECT hoten, diachi
 FROM nhanvien nv
 WHERE EXISTS (  SELECT *
     FROM phancong pc,  nhanvien nv1
     WHERE nv1.manv = pc.manv
     GROUP BY macb, ngaydi
     HAVING nv.luongnv IN(SELECT MAX(nv1.luongnv) 
             FROM phancong pc,  nhanvien nv1
          WHERE nv1.manv = pc.manv
          GROUP BY macb, ngaydi
          )
     )
 -- Câu 43: Cho biết mã chuyến bay, giờ đi, giờ đến của chuyến bay sớm nhất trong ngày
 SELECT cb.macb, lb.ngaydi, cb.giodi, cb.gioden
 FROM lichbay lb, chuyenbay cb
 WHERE lb.macb = cb.macb AND EXISTS (
          SELECT*
          FROM lichbay lba, chuyenbay cb1
          WHERE lba.macb = cb1.macb AND lb.ngaydi = lba.ngaydi
          GROUP BY lba.ngaydi
          HAVING cb.giodi = MIN(cb1.giodi)
          )
      
 
 -- Câu 44: Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ma ra mã chuyến bay và thời gian bay(tính bằng phút)
 SELECT cb.macb, DATEDIFF(mi, cb.giodi, cb.gioden)
 FROM chuyenbay cb
 WHERE DATEDIFF(mi, cb.giodi, cb.gioden) >= ALL (SELECT DATEDIFF(mi, cb.giodi, cb.gioden) 
            FROM chuyenbay cb)
 -- Câu 45: Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến bay và thời gian bay
 SELECT cb.macb, DATEDIFF(mi, cb.giodi, cb.gioden)
 FROM chuyenbay cb
 WHERE DATEDIFF(mi, cb.giodi, cb.gioden) <= ALL (SELECT DATEDIFF(mi, cb.giodi, cb.gioden) 
            FROM chuyenbay cb)
 -- Câu 46: Cho biết mã chuyến bay, ngày đi của của những chuyến bay trên loại máy bay B747 nhiều nhất
 SELECT macb, ngaydi
 FROM lichbay lb
 WHERE EXISTS(
   SELECT *
   FROM lichbay lba
   WHERE lba.maloai = 'B747' AND lba.macb = lb.macb
   GROUP BY macb
   HAVING COUNT(lba.ngaydi) >= ALL (SELECT COUNT(lbb.ngaydi)
         FROM lichbay lbb
         WHERE lbb.maloai = 'B747'
         GROUP BY macb
        )
        )
 -- Câu 47: Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay và số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay số lượng nhân viên
 SELECT lb.macb, COUNT(DISTINCT pc.manv) slnvien
 FROM datcho dc, phancong pc, lichbay lb
 WHERE dc.macb = lb.macb AND dc.ngaydi = lb.ngaydi AND pc.ngaydi = lb.ngaydi AND pc.macb = lb.macb
 GROUP BY lb.macb, lb.ngaydi
 HAVING COUNT(DISTINCT dc.makh) > 2
 
 -- 48: Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng nhân viên trong từng loại nhân viên đó. xuất loại nhân viên, số lượng nhân viên tương ứng
 SELECT loainv, COUNT(manv)
 FROM nhanvien nv
 GROUP BY loainv
 HAVING SUM(nv.luongnv) > 600000
 -- Câu 49: Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay, và số lượng khách hàng đã đặt chỗ trên chuyến bay đó.
 SELECT lb.macb, COUNT(DISTINCT dc.makh) slnvienkhach
 FROM datcho dc, phancong pc, lichbay lb
 WHERE dc.macb = lb.macb AND dc.ngaydi = lb.ngaydi AND pc.ngaydi = lb.ngaydi AND pc.macb = lb.macb
 GROUP BY lb.macb, lb.ngaydi
 HAVING COUNT(DISTINCT pc.manv) > 1
 -- Câu 50:Với mỗi loại máy bay có nhiều hơn 1 chiếc, cho biết số lượng chuyến bay đã được bố trí bay bằng loại máy bay đó, xuất ra mã loại và số lượng
 SELECT lb.maloai, COUNT(*) slnvcb
 FROM lichbay lb
 WHERE lb.maloai IN (SELECT maloai
      FROM maybay mb
      GROUP BY maloai
      HAVING COUNT(*) > 1)
 GROUP BY lb.maloai