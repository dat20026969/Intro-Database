create database quanlychuyenbay1
go
use quanlychuyenbay1
create table KHACHHANG (
 MAKH nvarchar(10),
 TEN nvarchar(30),
 DCHI nvarchar(100),
 DTHOAI nvarchar(10),
 primary key (MAKH)
)

create table NHANVIEN (
 MANV nvarchar(5),
 TEN nvarchar(30),
 DCHI nvarchar(100),
 DTHOAI nvarchar(11),
 LUONG money,
 LOAINV bit,
 primary key (MANV)
)

create table LOAIMAYBAY (
 MALOAI nvarchar(10),
 HANGSX nvarchar(10),
 primary key (MALOAI)
)
create table MAYBAY ( 
 SOHIEU int,
 MALOAI nvarchar(10),
 primary key (SOHIEU, MALOAI)
)

create table CHUYENBAY (
 MACB nvarchar(5),
 SBDI nvarchar(3),
 SBDEN nvarchar(3),
 GIODI time,
 GIODEN time,
 primary key (MACB)
)

create table LICHBAY (
 NGAYDI datetime,
 MACB nvarchar(5),
 SOHIEU int,
 MALOAI nvarchar(10),
 primary key (NGAYDI, MACB)
)

create table DATCHO (
 MAKH nvarchar(10),
 NGAYDI datetime,
 MACB nvarchar(5),
 primary key(MAKH, NGAYDI, MACB)
)

create table KHANANG (
 MANV nvarchar(5),
 MALOAI nvarchar(10),
 primary key (MANV, MALOAI)
)

create table PHANCONG (
 MANV nvarchar(5),
 NGAYDI datetime,
 MACB nvarchar(5),
 primary key (MANV, NGAYDI, MACB)
)

 alter table MAYBAY
 add constraint THUOC
 foreign key(MALOAI)
 references LOAIMAYBAY(MALOAI) 

 alter table LICHBAY
 add constraint BAY
 foreign key (MACB)
 references CHUYENBAY(MACB)

 alter table LICHBAY
 add constraint DINHDANH
 foreign key(SOHIEU, MALOAI)
 references MAYBAY(SOHIEU, MALOAI)

 alter table DATCHO
 add constraint DOITUONG
 foreign key (MAKH)
 references KHACHHANG(MAKH)

 alter table DATCHO
 add constraint PHUONGTIEN1
 foreign key (NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)

 alter table KHANANG
 add constraint PHUCVU
 foreign key (MANV)
 references NHANVIEN(MANV)

 alter table KHANANG
 add constraint T
 foreign key (MALOAI)
 references LOAIMAYBAY(MALOAI)

 alter table PHANCONG
 add constraint NV
 foreign key (MANV)
 references NHANVIEN(MANV)

 alter table PHANCONG
 add constraint NV2
 foreign key( NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)

 
 insert into KHACHHANG values ('0001',  'Đạt', 'Hòa Thành', '0888514045')
 insert into KHACHHANG values ('0002',  'Thành', 'Hòa Thành', '0919435064')
 insert into KHACHHANG values ('0003',  'Quý', 'Hòa Thành', '0916971295')
 insert into KHACHHANG values ('0004',  'Tiên', 'Hòa Thành', '0123456789')

 insert into CHUYENBAY values ('100', 'THA', 'SGN', '08:30','09:30' )
 insert into CHUYENBAY values ('112', 'THA', 'SGN', '08:30','09:30' )
 insert into CHUYENBAY values ('121', 'THA', 'SGN', '08:30','09:30' )
 insert into CHUYENBAY values ('122', 'THA', 'SGN', '08:30','09:30' )


 insert into LOAIMAYBAY values ('777','Boeing')
 insert into LOAIMAYBAY values ('778','Boeing')
 insert into LOAIMAYBAY values ('779','Boeing')
 insert into LOAIMAYBAY values ('780','Boeing')
 

 insert into NHANVIEN values ('1001', 'Trạch', 'Quảng Trị', '0123456987', 1500, 0)
 insert into NHANVIEN values ('1002', 'Đạt', 'Phú Yên', '0123654789', 5000, 0)
 insert into NHANVIEN values ('1003', 'Hải', 'Phú Yên', '0987654123', 5000, 1)
 insert into NHANVIEN values ('1004', 'Trung', 'Phú Yên', '0987654321', 1500, 1)
 

 insert into KHANANG values ('1001', '777')
 insert into KHANANG values ('1002', '778')
 insert into KHANANG values ('1003', '779')
 insert into KHANANG values ('1004', '780')

 insert into MAYBAY VALUES (10, '777')
 insert into MAYBAY VALUES (11, '778')
 insert into MAYBAY VALUES (12, '779')
 insert into MAYBAY VALUES (13, '780') 

 insert into LICHBAY values ('02/19/2022', '100', 10, '777')
 insert into LICHBAY values ('02/19/2022', '112', 11, '778')
 insert into LICHBAY values ('02/19/2022', '121', 12, '779')
 insert into LICHBAY values ('02/19/2022', '122', 13, '780')

 insert  into DATCHO values ('0001', '02/19/2022', 100)
 insert  into DATCHO values ('0002', '02/19/2022', 112)
 insert  into DATCHO values ('0003', '02/19/2022', 121)
 insert  into DATCHO values ('0004', '02/19/2022', 122)
 
 insert into PHANCONG  values ('1001', '02/19/2022', '100')
 insert into PHANCONG  values ('1002', '02/19/2022', '112')
 insert into PHANCONG  values ('1003', '02/19/2022', '121')
 insert into PHANCONG  values ('1004', '02/19/2022', '122')
