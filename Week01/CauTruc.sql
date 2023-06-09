USE [20127674_LeDucDat_HomeworkTuan1]
GO
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'1', N'Lê Ð?c Ð?t', N'Nam', N'0888514045', N'Phú Yên')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'2', N'Lê Ð?c Thành', N'Nam', N'0919435064', N'Phú Yên')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'3', N'Nguy?n Th? H?ng Quý', N'N?', N'0916971295', N'Phú Yên')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'4', N'Lê Th?y Tiên', N'N?', N'0987654321', N'Phú Yên')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'5', N'Nguy?n Th? In', N'N?', N'0123456789', N'Phú Yên')
GO
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'12', CAST(N'2022-01-23T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'23', CAST(N'2022-01-23T00:00:00.000' AS DateTime), N'2')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'34', CAST(N'2022-01-23T00:00:00.000' AS DateTime), N'3')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'45', CAST(N'2022-01-23T00:00:00.000' AS DateTime), N'4')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'56', CAST(N'2022-01-23T00:00:00.000' AS DateTime), N'5')
GO
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'ba', N'thuocmen', CAST(N'2022-01-03T00:00:00.000' AS DateTime), 40000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'bon', N'dienthoai', CAST(N'2022-01-04T00:00:00.000' AS DateTime), 15000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'hai', N'botngot', CAST(N'2022-01-02T00:00:00.000' AS DateTime), 30000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'mot', N'laptop', CAST(N'2022-01-01T00:00:00.000' AS DateTime), 30000000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'nam', N'loathung', CAST(N'2022-01-05T00:00:00.000' AS DateTime), 2000000)
GO
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'12', N'mot', 1, 30000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'23', N'hai', 2, 30000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'34', N'ba', 3, 40000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'45', N'bon', 1, 15000000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'56', N'nam', 2, 2000000)
GO
