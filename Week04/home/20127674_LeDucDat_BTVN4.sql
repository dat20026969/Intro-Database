-- Với mỗi sân bay(sbden), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó. Kêt quả được sắp xếp theo thứ tự tăng dần của số chuyến bay đến.
 select sbden, COUNT(*) AS soluong
 FROM chuyenbay cb
 GROUP BY sbden 
 ORDER BY soluong ASC
-- Với mỗi sân bay đi(sbdi), cho biết số lượng sân bay xuất phát từ sân bay đó , sắp xếp theo thứ tự tăng dần của chuyến bay xuất phát
 select sbdi, COUNT(*) AS soluong
 FROM chuyenbay cb
 GROUP BY sbdi
 ORDER BY soluong ASC
 -- Với mỗi sân bay(sbdi), cho biết số lượng chuyến bay xuất phát theo từng ngày. Xuất ra mã sân bay, ngày và số lượng
 select sbdi, ngaydi, COUNT(*) AS soluong
 FROM chuyenbay cb, lichbay lb
 WHERE cb.macb = lb.macb
 GROUP BY sbdi, ngaydi
 -- Với mỗi sân bay đến(sbden), cho biết số lượng chuyến bay hạ cánh theo từng ngày. Xuất ra mã sân bay đến, ngày và số lượng.
 select sbden, ngaydi, COUNT(*) AS soluong
 FROM chuyenbay cb, lichbay lb
 WHERE cb.macb = lb.macb
 GROUP BY sbden, ngaydi
 -- Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi, cùng số lượng nhân viên không phải là phi công của chuyến bay đó
 select lb.macb, lb.ngaydi,COUNT(pc.manv) AS slnv0thamgia
 FROM lichbay lb, phancong pc, nhanvien nv
 WHERE pc.ngaydi = lb.ngaydi AND pc.macb = lb.macb AND pc.manv = nv.manv AND nv.loainv = 0
 GROUP BY lb.macb, lb.ngaydi
 -- Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000
 SELECT COUNT(*) soluong
 FROM chuyenbay cb, lichbay lb
 WHERE cb.sbdi = 'MIA' AND lb.ngaydi = '11/01/2000' AND lb.macb = cb.macb
 -- Với mỗi chuyến bay cho biết mã chuyến bay, ngày đi, số lượng nhân viên được phân công trên chuyến bay đó, sắp theo thứ tự giảm dần số lượng
 SELECT lb.macb, lb.ngaydi, COUNT(*) slnvthamgia
 FROM lichbay lb, nhanvien nv, phancong pc
 WHERE pc.macb = lb.macb AND pc.ngaydi = lb.ngaydi AND pc.manv = nv.manv
 GROUP BY lb.macb, lb.ngaydi
 -- Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã đặt chỗ của chuyến bay đó, sắp xếp theo thứ tự giảm dần của số lượng
 SELECT dc.macb, dc.ngaydi, COUNT(*) AS slhanhkhach
 FROM lichbay lb, datcho dc, khachhang kh
 WHERE dc.macb = lb.macb AND dc.ngaydi = lb.ngaydi AND dc.makh = kh.makh
 GROUP BY dc.macb, dc.ngaydi
 ORDER BY slhanhkhach DESC
 -- Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của phi hành đoàn. sắp tăng dần tổng lương
 SELECT pc.macb, pc.ngaydi, SUM(luong) AS tongluong
 FROM lichbay lb, nhanvien nv, phancong pc
 WHERE lb.ngaydi = pc.ngaydi AND lb.macb = pc.macb 
 GROUP BY pc.macb, pc.ngaydi
 -- Cho biết lương trung bình của các nhân viên không là phi công
 SELECT AVG(luong) AS luongtbnhanvien
 FROM nhanvien nv
 WHERE nv.loainv = 0
 -- Cho biết mức lương trung bình của các phi công
 SELECT AVG(luong) AS luongtbphicong
 FROM nhanvien nv
 WHERE nv.loainv = 1
 -- Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay đó hạ cánh xuống sân bay ORD/ Xuất mã loại máy bay và số lượng chuyến bay.
 SELECT lb.maloai, COUNT(*) soluongchuyenbay
 FROM chuyenbay cb, lichbay lb
 WHERE lb.macb = cb.macb AND cb.sbden = 'ORD'
 GROUP BY lb.maloai 
 -- Cho biết sân bay(sbdi) và số lượng chuyến bay có nhiều hơn 2 chuyến bay xuất phát trong khoảng 10h đến 22h
 SELECT sbdi, COUNT(*) soluong
 FROM chuyenbay cb
 WHERE giodi BETWEEN '10:00' AND '22:00'
 GROUP BY sbdi
 HAVING COUNT(*) > 2
 -- Cho biết tên phi công đã được phân công vào ít nhất 2 chuyến bay trong cùng một ngày
 SELECT nv.ten
 FROM phancong pc, nhanvien nv
 WHERE pc.manv = nv.manv AND nv.loainv = 1
 GROUP BY nv.ten
 HAVING COUNT(*) > 2
 -- Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3 hành khách đặt chỗ
 SELECT dc.macb, dc.ngaydi
 FROM lichbay lb, datcho dc
 WHERE lb.ngaydi = dc.ngaydi AND lb.maloai = dc.macb 
 GROUP BY dc.ngaydi, dc.macb
 HAVING COUNT(dc.makh) > 3
 -- Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001 được phân lái trên 2 lần
 SELECT sohieu, lb.maloai
 FROM phancong pc, lichbay lb
 WHERE pc.manv = '1001' AND pc.macb = lb.macb AND pc.ngaydi = lb.ngaydi
 GROUP BY lb.sohieu, lb.maloai
 HAVING COUNT(*) >2
 -- Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó sản xuất. Xuất ra hãng sản xuất và số lượng.
 SELECT hangsx, COUNT(lmb.maloai) AS soluongmb
 FROM loaimb lmb, maybay mb
 WHERE lmb.maloai = mb.maloai
 GROUP BY hangsx