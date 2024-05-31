-- INSERT INTO CHINHANH
INSERT INTO ChiNhanh VALUES ('ChiNhanh1', '0123456789', '123', 'Le Loi', 'Ben Thanh', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh2', '0987654321', '456', 'Nguyen Hue', 'Ben Nghe', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh3', '0123456789', '789', 'Dien Bien Phu', 'Da Kao', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh4', '0987654321', '012', 'Hai Ba Trung', 'Ben Nghe', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh5', '0123456789', '345', 'Le Duan', 'Ben Nghe', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh6', '0987654321', '678', 'Nam Ky Khoi Nghia', 'Ben Nghe', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh7', '0123456789', '901', 'Nguyen Binh Khiem', 'Da Kao', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh8', '0987654321', '234', 'Nguyen Thi Minh Khai', 'Da Kao', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh9', '0123456789', '567', 'Pham Ngoc Thach', 'Da Kao', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');
INSERT INTO ChiNhanh VALUES ('ChiNhanh10', '0987654321', '890', 'Truong Dinh', 'Ben Thanh', 'District 1', 'Ho Chi Minh', '8:00 - 22:00');


-- INSERT INTO NGUYENLIEU
INSERT INTO NguyenLieu VALUES ('NL00000001', 'Duong den');
INSERT INTO NguyenLieu VALUES ('NL00000002', 'Duong trang');
INSERT INTO NguyenLieu VALUES ('NL00000003', 'Si ro dau');
INSERT INTO NguyenLieu VALUES ('NL00000004', 'Si ro dao');
INSERT INTO NguyenLieu VALUES ('NL00000005', 'Si ro vai');
INSERT INTO NguyenLieu VALUES ('NL00000006', 'Bot kem beo');
INSERT INTO NguyenLieu VALUES ('NL00000007', 'Bot matcha');
INSERT INTO NguyenLieu VALUES ('NL00000008', 'Bot cacao');
INSERT INTO NguyenLieu VALUES ('NL00000009', 'Ca phe');
INSERT INTO NguyenLieu VALUES ('NL00000010', 'Sua tuoi');
INSERT INTO NguyenLieu VALUES ('NL00000011', 'Sua dac');
INSERT INTO NguyenLieu VALUES ('NL00000012', 'Tra den');
INSERT INTO NguyenLieu VALUES ('NL00000013', 'Tra lai');
INSERT INTO NguyenLieu VALUES ('NL00000014', 'Muoi');
INSERT INTO NguyenLieu VALUES ('NL00000015', 'Sua chua');
INSERT INTO NguyenLieu VALUES ('NL00000016', 'Dau phong');
INSERT INTO NguyenLieu VALUES ('NL00000017', 'Chan trau den');
INSERT INTO NguyenLieu VALUES ('NL00000018', 'Tran chau trang');
INSERT INTO NguyenLieu VALUES ('NL00000019', 'Hat thuy tinh');
INSERT INTO NguyenLieu VALUES ('NL00000020', 'Soda');

-- INSERT INTO SANPHAM
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000001', 'San pham 1', 'L', 100.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000002', 'San pham 2', 'M', 200.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000003', 'San pham 3', 'S', 300.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000004', 'San pham 4', 'L', 400.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000005', 'San pham 5', 'M', 500.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000006', 'San pham 6', 'S', 600.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000007', 'San pham 7', 'L', 700.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000008', 'San pham 8', 'M', 800.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000009', 'San pham 9', 'S', 900.00);
INSERT INTO SanPham(MaSanPham, TenSanPham, KichThuoc, Gia)
VALUES ('SP00000010', 'San pham 10', 'L', 1000.00);

-- INSERT INTO NGUYENLIEU_SANPHAM
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000001', 'NL00000001', 10);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000002', 'NL00000002', 20);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000003', 'NL00000003', 30);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000004', 'NL00000004', 40);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000005', 'NL00000005', 50);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000006', 'NL00000006', 60);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000007', 'NL00000007', 70);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000008', 'NL00000008', 80);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000009', 'NL00000009', 90);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000010', 'NL00000010', 100);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000001', 'NL00000011', 10);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000002', 'NL00000012', 20);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000003', 'NL00000012', 30);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000004', 'NL00000014', 40);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000005', 'NL00000015', 50);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000006', 'NL00000016', 60);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000007', 'NL00000017', 70);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000008', 'NL00000018', 80);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000009', 'NL00000019', 90);
INSERT INTO NguyenLieu_SanPham(MaSanPham, MaNguyenLieu, SoLuong)
VALUES ('SP00000010', 'NL00000020', 100);

-- INSERT INTO NHANVIEN
INSERT INTO NhanVien (HoVaTen, MaNhanVien, CCCD, NgaySinh, DiaChi, GioiTinh, Email, SoTaiKhoan, NgayVaoLam, TenChiNhanh)
VALUES 
    ('Nguyen Van A', 'NV00000001', '123456789012', '1990-01-01', '123 Duong ABC, Quan XYZ, Thanh pho HCM', 'Nam', 'nguyenvana@example.com', '1234567890', '2020-01-01', 'ChiNhanh1'),
    ('Tran Thi B', 'NV00000002', '234567890123', '1991-02-02', '456 Duong DEF, Quan UVW, Thanh pho Ha Noi', 'Nu', 'tranthib@example.com', '2345678901', '2020-01-02', 'ChiNhanh2'),
    ('Pham Van C', 'NV00000003', '345678901234', '1992-03-03', '789 Duong GHI, Quan RST, Thanh pho Da Nang', 'Nam', 'phamvanc@example.com', '3456789012', '2020-01-03', 'ChiNhanh3'),
    ('Le Thi D', 'NV00000004', '456789012345', '1993-04-04', '012 Duong JKL, Quan OPQ, Thanh pho Can Tho', 'Nu', 'lethid@example.com', '4567890123', '2020-01-04', 'ChiNhanh4'),
    ('Hoang Van E', 'NV00000005', '567890123456', '1994-05-05', '345 Duong MNO, Quan IJK, Thanh pho Hai Phong', 'Nam', 'hoangvane@example.com', '5678901234', '2020-01-05', 'ChiNhanh5'),
    ('Nguyen Thi F', 'NV00000006', '678901234567', '1995-06-06', '678 Duong PQR, Quan LMN, Thanh pho Vung Tau', 'Nu', 'nguyenthif@example.com', '6789012345', '2020-01-06', 'ChiNhanh6'),
    ('Tran Van G', 'NV00000007', '789012345678', '1996-07-07', '901 Duong STU, Quan XYZ, Thanh pho Quy Nhon', 'Nam', 'tranvang@example.com', '7890123456', '2020-01-07', 'ChiNhanh7'),
    ('Pham Thi H', 'NV00000008', '890123456789', '1997-08-08', '234 Duong VWX, Quan UVW, Thanh pho Nha Trang', 'Nu', 'phamthih@example.com', '8901234567', '2020-01-08', 'ChiNhanh8'),
    ('Le Van I', 'NV00000009', '901234567890', '1998-09-09', '567 Duong YZT, Quan RST, Thanh pho Phan Thiet', 'Nam', 'levani@example.com', '9012345678', '2020-01-09', 'ChiNhanh9'),
    ('Hoang Thi K', 'NV00000010', '012345678901', '1999-10-10', '890 Duong CDE, Quan OPQ, Thanh pho Long Xuyen', 'Nu', 'hoangthik@example.com', '0123456789', '2020-01-10', 'ChiNhanh10'),
    ('Nguyen Van L', 'NV00000011', '123456789012', '1980-11-11', '234 Duong ABC, Quan XYZ, Thanh pho HCM', 'Nam', 'nguyenvanl@example.com', '1234567890', '2020-01-11', 'ChiNhanh1'),
    ('Tran Thi M', 'NV00000012', '234567890123', '1981-12-12', '567 Duong DEF, Quan UVW, Thanh pho Ha Noi', 'Nu', 'tranthim@example.com', '2345678901', '2020-01-12', 'ChiNhanh2'),
    ('Pham Van N', 'NV00000013', '345678901234', '1982-01-13', '890 Duong GHI, Quan RST, Thanh pho Da Nang', 'Nam', 'phamvann@example.com', '3456789012', '2020-01-13', 'ChiNhanh3'),
    ('Le Thi O', 'NV00000014', '456789012345', '1983-02-14', '123 Duong JKL, Quan OPQ, Thanh pho Can Tho', 'Nu', 'lethio@example.com', '4567890123', '2020-01-14', 'ChiNhanh4'),
    ('Hoang Van P', 'NV00000015', '567890123456', '1984-03-15', '456 Duong MNO, Quan IJK, Thanh pho Hai Phong', 'Nam', 'hoangvanp@example.com', '5678901234', '2020-01-15', 'ChiNhanh5'),
    ('Nguyen Thi Q', 'NV00000016', '678901234567', '1985-04-16', '789 Duong PQR, Quan LMN, Thanh pho Vung Tau', 'Nu', 'nguyenthiq@example.com', '6789012345', '2020-01-16', 'ChiNhanh6'),
    ('Tran Van R', 'NV00000017', '789012345678', '1986-05-17', '012 Duong STU, Quan XYZ, Thanh pho Quy Nhon', 'Nam', 'tranvar@example.com', '7890123456', '2020-01-17', 'ChiNhanh7'),
    ('Pham Thi S', 'NV00000018', '890123456789', '1987-06-18', '234 Duong VWX, Quan UVW, Thanh pho Nha Trang', 'Nu', 'phamthis@example.com', '8901234567', '2020-01-18', 'ChiNhanh8'),
    ('Le Van T', 'NV00000019', '901234567890', '1988-07-19', '567 Duong YZT, Quan RST, Thanh pho Phan Thiet', 'Nam', 'levant@example.com', '9012345678', '2020-01-19', 'ChiNhanh9'),
    ('Hoang Thi U', 'NV00000020', '012345678901', '1989-08-20', '890 Duong CDE, Quan OPQ, Thanh pho Long Xuyen', 'Nu', 'hoangthiu@example.com', '0123456789', '2020-01-20', 'ChiNhanh10');

-- INSERT INTO QUANLY
INSERT INTO QuanLy VALUES ('NV00000001', 10000000);
INSERT INTO QuanLy VALUES ('NV00000002', 10000000);
INSERT INTO QuanLy VALUES ('NV00000003', 10000000);
INSERT INTO QuanLy VALUES ('NV00000004', 10000000);
INSERT INTO QuanLy VALUES ('NV00000005', 10000000);

-- INSERT INTO CHINHANH_QUANLY
INSERT INTO ChiNhanh_QuanLy VALUES ('ChiNhanh1', 'NV00000001', '2020-02-12');
INSERT INTO ChiNhanh_QuanLy VALUES ('ChiNhanh2', 'NV00000002', '2020-02-12');
INSERT INTO ChiNhanh_QuanLy VALUES ('ChiNhanh3', 'NV00000003', '2020-02-12');
INSERT INTO ChiNhanh_QuanLy VALUES ('ChiNhanh4', 'NV00000004', '2020-02-12');
INSERT INTO ChiNhanh_QuanLy VALUES ('ChiNhanh5', 'NV00000005', '2020-02-12');

-- INSERT INTO PHUCVU
INSERT INTO PhucVu VALUES ('NV00000006');
INSERT INTO PhucVu VALUES ('NV00000007');
INSERT INTO PhucVu VALUES ('NV00000008');
INSERT INTO PhucVu VALUES ('NV00000009');
INSERT INTO PhucVu VALUES ('NV00000010');
INSERT INTO PhucVu VALUES ('NV00000011');
INSERT INTO PhucVu VALUES ('NV00000012');
INSERT INTO PhucVu VALUES ('NV00000013');
INSERT INTO PhucVu VALUES ('NV00000014');
INSERT INTO PhucVu VALUES ('NV00000015');
INSERT INTO PhucVu VALUES ('NV00000016');
INSERT INTO PhucVu VALUES ('NV00000017');
INSERT INTO PhucVu VALUES ('NV00000018');
INSERT INTO PhucVu VALUES ('NV00000019');
INSERT INTO PhucVu VALUES ('NV00000020');

-- INSERT INTO KHACHHANG        
INSERT INTO KhachHang VALUES ('KH00000000');

-- INSERT INTO ChUONGTRINHKHUYENMAI
INSERT INTO ChuongTrinhKhuyenMai VALUES ('KM00000000', 'None', '2020 - 02 - 20', '2020 - 02 - 20', 'None');

-- INSERT INTO PHUONGTHUCTHANHTOAN
INSERT INTO PhuongThucThanhToan VALUES ('GD00000000', 'Tien mat');

-- Tạo dữ liệu cho bảng NhapNguyenLieu
INSERT INTO NhapNguyenLieu (TenChiNhanh, MaNguyenLieu) VALUES
('ChiNhanh10', 'NL00000001'),
('ChiNhanh3', 'NL00000003'),
('ChiNhanh4', 'NL00000004'),
('ChiNhanh5', 'NL00000005'),
('ChiNhanh6', 'NL00000006'),
('ChiNhanh7', 'NL00000007'),
('ChiNhanh9', 'NL00000008'),
('ChiNhanh10', 'NL00000009'),
('ChiNhanh2', 'NL00000010');

INSERT INTO NhapNguyenLieu (TenChiNhanh, MaNguyenLieu) VALUES
('ChiNhanh2', 'NL00000001'),
('ChiNhanh2', 'NL00000002'),
('ChiNhanh2', 'NL00000003'),
('ChiNhanh2', 'NL00000004'),
('ChiNhanh2', 'NL00000005'),
('ChiNhanh2', 'NL00000006'),
('ChiNhanh2', 'NL00000007'),
('ChiNhanh2', 'NL00000008'),
('ChiNhanh2', 'NL00000009'),
('ChiNhanh2', 'NL00000010'),
('ChiNhanh2', 'NL00000011'),
('ChiNhanh2', 'NL00000012'),
('ChiNhanh2', 'NL00000013'),
('ChiNhanh2', 'NL00000014'),
('ChiNhanh2', 'NL00000015'),
('ChiNhanh2', 'NL00000016'),
('ChiNhanh2', 'NL00000017'),
('ChiNhanh2', 'NL00000018'),
('ChiNhanh2', 'NL00000019'),
('ChiNhanh2', 'NL00000020');

-- Tạo dữ liệu cho bảng LoNguyenLieu
INSERT INTO LoNguyenLieu (TenChiNhanh, MaNguyenLieu, NgayNhap, HanSuDung, SoLuong, GiaNhap) VALUES
('ChiNhanh10', 'NL00000001', '2023-04-01', '2024-03-31', 100, 10000),
('ChiNhanh2', 'NL00000002', '2023-04-02', '2023-12-31', 200, 20000),
('ChiNhanh2', 'NL00000004', '2023-04-02', '2023-12-31', 200, 24000),
('ChiNhanh3', 'NL00000003', '2023-04-03', '2024-06-30', 150, 15000),
('ChiNhanh4', 'NL00000004', '2023-04-04', '2023-10-31', 300, 25000),
('ChiNhanh5', 'NL00000005', '2023-04-05', '2024-02-28', 180, 18000),
('ChiNhanh6', 'NL00000006', '2023-04-06', '2023-09-30', 250, 22000),
('ChiNhanh7', 'NL00000007', '2023-04-07', '2024-04-30', 120, 12000),
('ChiNhanh9', 'NL00000008', '2023-04-08', '2024-01-31', 280, 28000),
('ChiNhanh10', 'NL00000009', '2023-04-09', '2023-11-30', 160, 16000),
('ChiNhanh2', 'NL00000010', '2023-04-10', '2023-12-31', 220, 24000);

INSERT INTO LoNguyenLieu (TenChiNhanh, MaNguyenLieu, NgayNhap, HanSuDung, SoLuong, GiaNhap) VALUES
('ChiNhanh2', 'NL00000001', '2023-04-01', '2024-03-31', 100, 10000),
('ChiNhanh2', 'NL00000002', '2023-04-01', '2023-12-31', 200, 20000),
('ChiNhanh2', 'NL00000003', '2023-04-01', '2024-06-30', 150, 15000),
('ChiNhanh2', 'NL00000004', '2023-04-01', '2023-10-31', 300, 25000),
('ChiNhanh2', 'NL00000005', '2023-04-01', '2024-02-28', 180, 18000),
('ChiNhanh2', 'NL00000006', '2023-04-01', '2023-09-30', 250, 22000),
('ChiNhanh2', 'NL00000007', '2023-04-01', '2024-04-30', 120, 12000),
('ChiNhanh2', 'NL00000008', '2023-04-01', '2024-01-31', 280, 28000),
('ChiNhanh2', 'NL00000009', '2023-04-01', '2023-11-30', 160, 16000),
('ChiNhanh2', 'NL00000010', '2023-04-01', '2023-12-31', 220, 24000),
('ChiNhanh2', 'NL00000011', '2023-04-01', '2024-03-31', 100, 10000),
('ChiNhanh2', 'NL00000012', '2023-04-01', '2023-12-31', 200, 20000),
('ChiNhanh2', 'NL00000014', '2023-04-01', '2023-12-31', 200, 24000),
('ChiNhanh2', 'NL00000013', '2023-04-01', '2024-06-30', 150, 15000),
('ChiNhanh2', 'NL00000015', '2023-04-01', '2024-02-28', 180, 18000),
('ChiNhanh2', 'NL00000016', '2023-04-01', '2023-09-30', 250, 22000),
('ChiNhanh2', 'NL00000017', '2023-04-01', '2024-04-30', 120, 12000),
('ChiNhanh2', 'NL00000018', '2023-04-01', '2024-01-31', 280, 28000),
('ChiNhanh2', 'NL00000019', '2023-04-01', '2023-11-30', 160, 16000),
('ChiNhanh2', 'NL00000020', '2023-04-01', '2023-12-31', 220, 24000);