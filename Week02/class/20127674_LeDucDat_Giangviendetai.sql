create database GIAOVIEN98
go
use GIAOVIEN98

create table GIAOVIEN (
 MAGV nvarchar(5),
 TEN nvarchar(30),
 LUONG float,
 GIOITINH nvarchar(5),
 NGAYSINH datetime,
 DIACHI nvarchar(50),
 GVQLCM nvarchar(5),
 MABM nvarchar(5),
 primary key (MAGV)
)

create table GV_DT (
 MAGV nvarchar(5),
 DIENTHOAI nvarchar(10),
 primary key (MAGV, DIENTHOAI)
)

create table BOMON (
 MABM nvarchar(5),
 TENBM nvarchar(20),
 PHONG nvarchar(5),
 DIENTHOAI nvarchar(10),
 TRUONGBM nvarchar(30),
 MAKHOA nvarchar(5),
 NGAYNHAMCHUC datetime,
 primary key (MABM)
)

create table KHOA ( 
 MAKHOA nvarchar(5),
 TENKHOA nvarchar(20),
 NAMTL int,
 PHONG nvarchar(5),
 DIENTHOAI nvarchar(10),
 TRUONGKHOA nvarchar(30),
 NGAYNHAMCHUC datetime,
 primary key (MAKHOA)
)

create table DETAI (
 MADT nvarchar(10),
 TENDT nvarchar(100),
 KINHPHI money,
 CAPQL nvarchar(10),
 NGAYBD datetime,
 NGAYKT datetime,
 MACD nvarchar(10),
 GVCNDT nvarchar(30),
 primary key (MADT)
)

create table CHUDE (
 MACD nvarchar(10),
 TENCD nvarchar(50),
 primary key (MACD)
)

create table CONGVIEC (
 MADT nvarchar(10),
 STT int,
 TENCV nvarchar(50),
 NGAYBD datetime,
 NGAYKT datetime,
 primary key(MADT, STT)
)

create table THAMGIADT (
 MAGV nvarchar(5),
 MADT nvarchar(10),
 STT int,
 PHUCAP float,
 KETQUA nvarchar(10),
 primary key (MAGV, MADT, STT)
)

create table NGUOITHAN (
 MAGV nvarchar(5),
 TEN nvarchar(30),
 NGAYSINH datetime,
 GIOITINH nvarchar(5),
)

 alter table THAMGIADT
 add constraint IN4
 foreign key(MADT, STT)
 references CONGVIEC(MADT, STT) 

 alter table THAMGIADT
 add constraint IN4_1
 foreign key (MAGV)
 references GIAOVIEN(MAGV)

 alter table CONGVIEC
 add constraint INFOR
 foreign key(MADT)
 references DETAI(MADT)

 alter table DETAI
 add constraint DETAI1
 foreign key (MACD)
 references CHUDE(MACD) 

 alter table GV_DT
 add constraint PHONE
 foreign key (MAGV)
 references GIAOVIEN(MAGV)

 alter table NGUOITHAN
 add constraint FAMILY
 foreign key (MAGV)
 references GIAOVIEN(MAGV)
 
 insert into GIAOVIEN values ('0001',  'Hồ Thị Hoàng Vy', '1000', 'Nữ', '01/01/1990', 'Sài Gòn', '0002', 'HTTT')
 insert into GIAOVIEN values ('0002',  'Tiết Gia Hồng', '2000', 'Nữ', '01/01/1980', 'Sài Gòn', 'null', 'HTTT')
 insert into GIAOVIEN values ('0003',  'Văn Chí Nam', '2500', 'Nam', '01/01/1975', 'Sài Gòn', 'null', 'CNPM')
 insert into GIAOVIEN values ('0004',  'Bùi Tiến Lên', '2100', 'Nam', '01/01/1970', 'Sài Gòn', 'null', 'KHMT')
 
 insert into GV_DT values ('0001', '0123456789')
 insert into GV_DT values ('0002', '0987654321')
 insert into GV_DT values ('0003', '0147258369')
 insert into GV_DT values ('0004', '0369258147')
 
 insert into BOMON values ('HTTT', 'Hệ Thống Thông Tin', 'B13', '0888514045', 'Lê Đức Đạt', 'CNTT', '01/01/2022')
 insert into BOMON values ('CNPM', 'Công Nghệ Phần Mềm', 'I82', '0888514046', 'Đinh Bá Tiến', 'CNTT', '02/01/2015')
 insert into BOMON values ('KHMT', 'Khoa Học Máy Tính', 'I81', '0888514047', 'Lê Hoài Bắc', 'CNTT', '03/01/2000')
 insert into BOMON values ('TTNT', 'Trí Tuệ Nhân Tạo', 'I81', '0888514048', 'Trần Minh Triết', 'CNTT', '04/01/2019')
 
 insert into KHOA values ('CNTT', 'Công Nghệ Thông Tin', '1995', 'I53', '0283835426', 'Đinh Bá Tiến', '01/01/2015')
 
 insert into DETAI values ('001', 'Game Lịch Sử', '10000', 'Khoa', '01/01/2022', '07/02/2022', 'NCPT', 'null')
 insert into DETAI values ('002', 'Quản lí bệnh viện 4.0', '100000', 'Trường', '01/01/2022', '07/02/2022', 'NCPT', 'null')
 insert into DETAI values ('003', 'Blockchain Security', '25000', 'Thành', '03/01/2022', '09/02/2022', 'UDCN', 'null')
 insert into DETAI values ('004', 'Xử lí hình ảnh bằng OpenCV-Python', '5000', 'QG', '04/01/2022', '10/02/2022', 'UDCN', 'null')
 
 insert into CHUDE VALUES ('NCPT', 'Nghiên Cứu Phát Triển')
 insert into CHUDE VALUES ('UDCN', 'Ứng dụng công nghệ')

 insert into CONGVIEC values ('001', '1', 'Founder', '01/01/2022', '07/02/2022')
 insert into CONGVIEC values ('002', '2', 'Developer', '01/01/2022', '07/02/2022')
 insert into CONGVIEC values ('003', '3', 'Tester', '03/01/2022', '09/02/2022')
 insert into CONGVIEC values ('004', '4', 'Co-founder', '04/01/2022', '10/02/2022')

 insert  into THAMGIADT values ('0001', '002', '1', '2.0', 'Đạt')
 insert  into THAMGIADT values ('0002', '004', '2', '3.0', 'Đạt')
 insert  into THAMGIADT values ('0003', '003', '3', '4.0', 'Đạt')
 insert  into THAMGIADT values ('0004', '001', '4', '5.0', 'Đạt') 
 
 insert into NGUOITHAN  values ('0001', 'Phan Tấn Trung', '02/26/1989', 'Nam')
 insert into NGUOITHAN  values ('0002', 'Phùng Thanh Độ', '09/12/1989', 'Nam')
 insert into NGUOITHAN  values ('0003', 'Nguyễn Văn A', '01/01/1970', 'Nam')
 insert into NGUOITHAN  values ('0004', 'Nguyễn Thị B', '01/02/1970', 'Nữ')
