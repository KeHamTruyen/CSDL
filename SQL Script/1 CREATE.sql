CREATE DATABASE BT4;
GO

USE BT4;
GO

CREATE TABLE ChiNhanh (
    Ten NVARCHAR(50),
    SDT VARCHAR(10) NOT NULL,
    SoNha NVARCHAR(20) NOT NULL,
    Duong NVARCHAR(50) NOT NULL,
    Phuong NVARCHAR(50) NOT NULL,
    Quan NVARCHAR(50) NOT NULL,
    ThanhPho NVARCHAR(50) NOT NULL,
    ThoiGianHoatDong NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_ChiNhanh PRIMARY KEY (Ten),
    CONSTRAINT CHK_SDT CHECK (LEN(SDT) = 10 AND SDT LIKE '0[0-9]%')
);
-- Drop ChiNhanh table

CREATE TABLE ChiNhanh_QuanLy
(
    TenChiNhanh NVARCHAR(50),
    MaNhanVien VARCHAR(10),
    NgayBatDauQuanLi DATE NOT NULL,

    CONSTRAINT PK_ChiNhanh_QuanLy PRIMARY KEY (TenChiNhanh, MaNhanVien)
);

CREATE TABLE DoanhThu
(
    TenChiNhanh NVARCHAR(50),
    NgayChotSo DATE,
    TongDoanhThu DECIMAL(18, 2) NOT NULL DEFAULT 0,
    SoLuongDon INT NOT NULL DEFAULT 0,

	CONSTRAINT PK_Doanhthu PRIMARY KEY (TenChiNhanh, NgayChotSo)
);
-- Drop DoanhThu table

CREATE TABLE NhanVien
(
    HoVaTen NVARCHAR(100) NOT NULL,
    MaNhanVien VARCHAR(10),
    CCCD CHAR(12) NOT NULL,
    NgaySinh DATE NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    SoTaiKhoan VARCHAR(20),
    NgayVaoLam DATE NOT NULL,
    TenChiNhanh NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_NhanVien PRIMARY KEY (MaNhanVien),
	CONSTRAINT CHK_CCCD_Format CHECK (LEN(CCCD) = 12 AND CCCD LIKE '[0-9]%'),
    CONSTRAINT CHK_Age CHECK (DATEDIFF(YEAR, NgaySinh, GETDATE()) > 18),
	CONSTRAINT CHK_MaNhanVien_Format CHECK (MaNhanVien LIKE 'NV%' AND LEN(MaNhanVien) = 10),
	CONSTRAINT CHK_Email_Format CHECK (Email LIKE '%@%'),
	CONSTRAINT CHK_GioiTinh CHECK (GioiTinh IN ('Nam', 'Nu')),
);
-- Drop NhanVien table

CREATE TABLE NhanVien_NhanVien
(
    MaNhanVien VARCHAR(10),
    MaNhanVienGiamSat VARCHAR(10),

    CONSTRAINT PK_NhanVien_NhanVien PRIMARY KEY (MaNhanVien, MaNhanVienGiamSat),
);

CREATE TABLE SdtNhanVien
(
    MaNhanVien VARCHAR(10),
    SDT VARCHAR(10),

    CONSTRAINT PK_SdtNhanVien PRIMARY KEY (MaNhanVien, SDT),
    CONSTRAINT CHK_SDT_Format CHECK (LEN(SDT) = 10 AND SDT LIKE '0[0-9]%')
);
-- Drop SDT_NhanVien table

CREATE TABLE QuanLy
(
    MaNhanVien VARCHAR(10),
    Luong DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_QuanLy PRIMARY KEY (MaNhanVien)
);
-- Drop QuanLy table

CREATE TABLE PhucVu
(
    MaNhanVien VARCHAR(10),

    CONSTRAINT PK_PhucVu PRIMARY KEY (MaNhanVien)
)
-- Drop Phucvu table

CREATE TABLE PhucVuToanThoiGian
(
    MaNhanVien VARCHAR(10),
    Luong DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_PhucVuToanThoiGian PRIMARY KEY (MaNhanVien)
);
-- Drop PhucvuToanthoigian table

CREATE TABLE PhucVuTheoGio
(
    MaNhanVien VARCHAR(10),
    LuongTheoGio DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_PhucVuTheoGio PRIMARY KEY (MaNhanVien)
);
-- Drop PhucvuTheogio table

CREATE TABLE CaLamViec
(
    MaNhanVien VARCHAR(10),
    Ngaylamviec VARCHAR(10),
    GioBatDau TIME,
    GioKetThuc TIME,

    CONSTRAINT PK_Calamviec PRIMARY KEY (MaNhanVien, Ngaylamviec, Giobatdau, Gioketthuc),
    CONSTRAINT CHK_Ngaylamviec CHECK (Ngaylamviec IN ('Thu 2', 'Thu 3', 'Thu 4', 'Thu 5', 'Thu 6', 'Thu 7', 'Chu Nhat'))
);
-- Drop Calamviec table

CREATE TABLE NguyenLieu
(
    MaNguyenLieu NVARCHAR(10),
    TenNguyenLieu NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_NguyenLieu PRIMARY KEY (MaNguyenLieu),
    CONSTRAINT CHK_MaNguyenLieu_Format CHECK (MaNguyenLieu LIKE 'NL%' AND LEN(MaNguyenLieu) = 10)
);
-- Drop NguyenLieu table

CREATE TABLE NguyenLieuTaiChiNhanh
(
    TenChiNhanh NVARCHAR(50),
    MaNguyenLieu NVARCHAR(10),
    SoLuong INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_NguyenLieuTaiChiNhanh PRIMARY KEY (MaNguyenLieu, TenChiNhanh)
);
-- Drop NguyenLieuMoiChiNhanh table

CREATE TABLE NhapNguyenLieu
(
    TenChiNhanh NVARCHAR(50),
    MaNguyenLieu NVARCHAR(10),

    CONSTRAINT PK_NhapNguyenLieu PRIMARY KEY (TenChiNhanh, MaNguyenLieu)
);
-- Drop NhapNguyenLieu table

CREATE TABLE LoNguyenLieu
(
    TenChiNhanh NVARCHAR(50),
    MaNguyenLieu NVARCHAR(10),
    NgayNhap DATE,
    HanSuDung DATE NOT NULL,
    SoLuong INT NOT NULL DEFAULT 0,
    GiaNhap DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_LoNguyenLieu PRIMARY KEY (TenChiNhanh, MaNguyenLieu, NgayNhap)
);
-- Drop LoNguyenLieu table

CREATE TABLE BAN
(
    TenChiNhanh NVARCHAR(50),
    MaBan NVARCHAR(10),
    TinhTrang NVARCHAR(20) NOT NULL DEFAULT 'Con Cho',

    CONSTRAINT PK_BAN PRIMARY KEY (MaBan, TenChiNhanh),
    CONSTRAINT CHK_MaBan_Format CHECK (MaBan LIKE 'BAN%' AND LEN(MaBan) = 10),
    CONSTRAINT CHK_TinhTrang CHECK (TinhTrang IN ('Con Cho', 'Het Cho'))
);
-- Drop BAN table

CREATE TABLE DonHang
(
    MaDonHang NVARCHAR(10),
    NgayTao DATE NOT NULL,
    GioTao TIME NOT NULL,
    MaKhuyenMai NVARCHAR(10) NOT NULL,
    MaKhachHang NVARCHAR(10) NOT NULL,

    CONSTRAINT PK_DonHang PRIMARY KEY (MaDonHang),
    CONSTRAINT CHK_MaDonHang_Format CHECK (MaDonHang LIKE 'DH%' AND LEN(MaDonHang) = 10)
);
-- Drop DonHang table

CREATE TABLE SuDungBan
(
    MaBan NVARCHAR(10),
    MaDonHang NVARCHAR(10),
    TenChiNhanh NVARCHAR(50),

    CONSTRAINT PK_SuDungBan PRIMARY KEY (MaBan, MaDonHang, TenChiNhanh)
);
-- Drop SuDungBan table

CREATE TABLE SanPham
(
    MaSanPham NVARCHAR(10),
    TenSanPham NVARCHAR(100) NOT NULL,
    KichThuoc NVARCHAR(50) NOT NULL,
    Gia DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_SanPham PRIMARY KEY (MaSanPham),
    CONSTRAINT CHK_MaSanPham_Format CHECK (MaSanPham LIKE 'SP%' AND LEN(MaSanPham) = 10),
    CONSTRAINT CHK_KichThuoc CHECK (KichThuoc IN ('L', 'M', 'S'))
);
-- Drop SanPham table

CREATE TABLE HoaDon
(
    MaHoaDon NVARCHAR(10),
    ThoiGianXuat DATE NOT NULL,
    TongSoLuongSanPham INT NOT NULL DEFAULT 0,
    TongTien DECIMAL(18, 2) NOT NULL DEFAULT 0,
    SoTienDuocGiam DECIMAL(18, 2) NOT NULL DEFAULT 0,
    TenChiNhanh NVARCHAR(50) NOT NULL,
    MaGiaoDich NVARCHAR(10) NOT NULL,

    CONSTRAINT PK_HoaDon PRIMARY KEY (MaHoaDon),
    CONSTRAINT CHK_MaHoaDon_Format CHECK (MaHoaDon LIKE 'HD%' AND LEN(MaHoaDon) = 10)
);
-- Drop HoaDon table

CREATE TABLE XuatHoaDon
(
    MaHoaDon NVARCHAR(10),
    MaDonHang NVARCHAR(10),
    MaNhanVien VARCHAR(10),

    CONSTRAINT PK_XuatHoaDon PRIMARY KEY (MaHoaDon, MaDonHang, MaNhanVien)
);
-- Drop XuatHoaDon table

CREATE TABLE NguyenLieu_SanPham
(
    MaSanPham NVARCHAR(10),
    MaNguyenLieu NVARCHAR(10),
    SoLuong INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_NguyenLieu_SanPham PRIMARY KEY (MaSanPham, MaNguyenLieu)
);
-- Drop NguyenLieuSanPham table


CREATE TABLE KhachHang
(
    MaKhachHang NVARCHAR(10),

    CONSTRAINT PK_KhachHang PRIMARY KEY (MaKhachHang),
    CONSTRAINT CHK_MaKhachHang_Format CHECK (MaKhachHang LIKE 'KH%' AND LEN(MaKhachHang) = 10)
);
-- Drop KhachHang table

CREATE TABLE KhachHangThanhVien
(
    MaKhachHang NVARCHAR(10),
    TenKhachHang NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL,
    SDT VARCHAR(10) NOT NULL,
    DiemTichLuy INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_KhachHangThanhVien PRIMARY KEY (MaKhachHang),
    CONSTRAINT CHK_SDT_Format2 CHECK (LEN(SDT) = 10 AND SDT LIKE '0[0-9]%'),
    CONSTRAINT CHK_GioiTinh2 CHECK (GioiTinh IN ('Nam', 'Nu'))
);
-- Drop KhachHangThanhVien table

CREATE TABLE MaGiamGiaBangDiem
(
    MaKhachHang NVARCHAR(10) NOT NULL,
    MaGiamGia NVARCHAR(10),
    MaDonHang NVARCHAR(10) NOT NULL,
    SoDiem INT NOT NULL DEFAULT 0,
    SoTien INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_MaGiamGiaBangDiem PRIMARY KEY (MaGiamGia),
    CONSTRAINT CHK_MaGiamGia_Format CHECK (MaGiamGia LIKE 'GG%' AND LEN(MaGiamGia) = 10)
);
-- Drop MaGiamGiaBangDiem table

CREATE TABLE PhuongThucThanhToan
(
    MaGiaoDich NVARCHAR(10),
    TenPhuongThuc NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_PhuongThucThanhToan PRIMARY KEY (MaGiaoDich),
    CONSTRAINT CHK_MaGiaoDich_Format CHECK (MaGiaoDich LIKE 'GD%' AND LEN(MaGiaoDich) = 10),
    CONSTRAINT CHK_TenPhuongThucThanhToan CHECK (TenPhuongThuc IN ('Tien Mat', 'The Ngan Hang', 'MoMo', 'ZaloPay'))
);
-- Drop PhuongThucThanhToan table

CREATE TABLE DonHang_SanPham
(
    MaDonHang NVARCHAR(10),
    MaSanPham NVARCHAR(10),
    SoLuong INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_DonHang_SanPham PRIMARY KEY (MaDonHang, MaSanPham)
);
-- Drop DonHangSanPham table

CREATE TABLE DonHang_Combo
(
    MaDonHang NVARCHAR(10),
    MaKhuyenMai NVARCHAR(10),
    SoLuong INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_DonHang_Combo PRIMARY KEY (MaDonHang, MaKhuyenMai)
);
-- Drop DonHangCombo table

CREATE TABLE Combo_SanPham
(
    MaKhuyenMai NVARCHAR(10),
    MaSanPham NVARCHAR(10),
    SoLuong INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Combo_SanPham PRIMARY KEY (MaKhuyenMai, MaSanPham)
);
-- Drop ComboSanPham table

CREATE TABLE Combo
(
    MaKhuyenMai NVARCHAR(10),
    Gia DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_Combo PRIMARY KEY (MaKhuyenMai)
);
-- Drop Combo table

CREATE TABLE ChiNhanh_KhuyenMai
(
    TenChiNhanh NVARCHAR(50),
    MaKhuyenMai NVARCHAR(10),

    CONSTRAINT PK_ChiNhanhKhuyenMai PRIMARY KEY (TenChiNhanh, MaKhuyenMai)
);
-- Drop ChiNhanhKhuyenMai table

CREATE TABLE ChuongTrinhKhuyenMai
(
    MaKhuyenMai NVARCHAR(10),
    TenChuongTrinh NVARCHAR(50) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    TheLe NVARCHAR(255) NOT NULL,

    CONSTRAINT PK_KhuyenMai PRIMARY KEY (MaKhuyenMai),
    CONSTRAINT CHK_MaKhuyenMai_Format CHECK (MaKhuyenMai LIKE 'KM%' AND LEN(MaKhuyenMai) = 10)
);
-- Drop ChuongTrinhKhuyenMai table

CREATE TABLE KhuyenMaiTheoDon
(
    MaKhuyenMai NVARCHAR(10),
    GiaToiThieu DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_KhuyenMaiTheoDon PRIMARY KEY (MaKhuyenMai)
);
-- Drop KhuyenMaiTheoDon table

CREATE TABLE KhuyenMaiTheoTiLe
(
    MaKhuyenMai NVARCHAR(10),
    TiLe DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_KhuyenMaiTheoTiLe PRIMARY KEY (MaKhuyenMai),
    CONSTRAINT CHK_TiLe CHECK (TiLe > 0 AND TiLe < 100)
);
-- Drop KhuyenMaiTheoTiLe table

CREATE TABLE KhuyenMaiTheoSoTien
(
    MaKhuyenMai NVARCHAR(10),
    SoTienGiam DECIMAL(18, 2) NOT NULL DEFAULT 0,

    CONSTRAINT PK_KhuyenMaiTheoSoTien PRIMARY KEY (MaKhuyenMai)
);
-- Drop KhuyenMaiTheoSoTien table

-- Foreign key

ALTER TABLE DoanhThu ADD CONSTRAINT FK_ChiNhanh_DoanhThu FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);

ALTER TABLE NhanVien ADD CONSTRAINT FK_ChiNhanh_NhanVien FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);

ALTER TABLE NhanVien_NhanVien ADD CONSTRAINT FK_NhanVien_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);
ALTER TABLE NhanVien_NhanVien ADD CONSTRAINT FK_NhanVien_NhanVien2 FOREIGN KEY (MaNhanVienGiamSat) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE ChiNhanh_QuanLy ADD CONSTRAINT FK_ChiNhanhQuanLy_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);
ALTER TABLE ChiNhanh_QuanLy ADD CONSTRAINT FK_ChiNhanhQuanLy_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES QuanLy(MaNhanVien);

ALTER TABLE SdtNhanVien ADD CONSTRAINT FK_SdtNhanVien_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE QuanLy ADD CONSTRAINT FK_QuanLy_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE PhucVu ADD CONSTRAINT FK_PhucVu_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE PhucVuToanThoiGian ADD CONSTRAINT FK_PhucVuToanThoiGian_PhucVu FOREIGN KEY (MaNhanVien) REFERENCES PhucVu(MaNhanVien);

ALTER TABLE PhucVuTheoGio ADD CONSTRAINT FK_PhucVuTheoGio_PhucVu FOREIGN KEY (MaNhanVien) REFERENCES PhucVu(MaNhanVien);

ALTER TABLE CaLamViec ADD CONSTRAINT FK_CaLamViec_PhucVuTheoGio FOREIGN KEY (MaNhanVien) REFERENCES PhucVuTheoGio(MaNhanVien);

ALTER TABLE NguyenLieuTaiChiNhanh ADD CONSTRAINT FK_NguyenLieuTaiChiNhanh_NguyenLieu FOREIGN KEY (MaNguyenLieu) REFERENCES NguyenLieu(MaNguyenLieu);
ALTER TABLE NguyenLieuTaiChiNhanh ADD CONSTRAINT FK_NguyenLieuTaiChiNhanh_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);

ALTER TABLE NhapNguyenLieu ADD CONSTRAINT FK_NhapNguyenLieu_NguyenLieu FOREIGN KEY (MaNguyenLieu) REFERENCES NguyenLieu(MaNguyenLieu);
ALTER TABLE NhapNguyenLieu ADD CONSTRAINT FK_NhapNguyenLieu_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);

ALTER TABLE LoNguyenLieu ADD CONSTRAINT FK_LoNguyenLieu_NhapNguyenLieu FOREIGN KEY (TenChiNhanh, MaNguyenLieu) REFERENCES NhapNguyenLieu(TenChiNhanh, MaNguyenLieu);

ALTER TABLE BAN ADD CONSTRAINT FK_BAN_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);

ALTER TABLE SuDungBan ADD CONSTRAINT FK_SuDungBan_BAN FOREIGN KEY (MaBan, TenChiNhanh) REFERENCES BAN(MaBan, TenChiNhanh);
ALTER TABLE SuDungBan ADD CONSTRAINT FK_SuDungBan_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);

ALTER TABLE XuatHoaDon ADD CONSTRAINT FK_XuatHoaDon_HoaDon FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon);
ALTER TABLE XuatHoaDon ADD CONSTRAINT FK_XuatHoaDon_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);
ALTER TABLE XuatHoaDon ADD CONSTRAINT FK_XuatHoaDon_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE NguyenLieu_SanPham ADD CONSTRAINT FK_NguyenLieuSanPham_NguyenLieu FOREIGN KEY (MaNguyenLieu) REFERENCES NguyenLieu(MaNguyenLieu);
ALTER TABLE NguyenLieu_SanPham ADD CONSTRAINT FK_NguyenLieuSanPham_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham);

ALTER TABLE KhachHangThanhVien ADD CONSTRAINT FK_KhachHangThanhVien_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang);

ALTER TABLE MaGiamGiaBangDiem ADD CONSTRAINT FK_MaGiamGiaBangDiem_KhachHangThanhVien FOREIGN KEY (MaKhachHang) REFERENCES KhachHangThanhVien(MaKhachHang);
ALTER TABLE MaGiamGiaBangDiem ADD CONSTRAINT FK_MaGiamGiaBangDiem_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);

ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_GiaoDich FOREIGN KEY (MaGiaoDich) REFERENCES PhuongThucThanhToan(MaGiaoDich);

ALTER TABLE DonHang ADD CONSTRAINT FK_DonHang_KhuyenMai FOREIGN KEY (MaKhuyenMai) REFERENCES ChuongTrinhKhuyenMai(MaKhuyenMai);
ALTER TABLE DonHang ADD CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang);

ALTER TABLE DonHang_SanPham ADD CONSTRAINT FK_DonHangSanPham_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);
ALTER TABLE DonHang_SanPham ADD CONSTRAINT FK_DonHangSanPham_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham);

ALTER TABLE DonHang_Combo ADD CONSTRAINT FK_DonHangCombo_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);
ALTER TABLE DonHang_Combo ADD CONSTRAINT FK_DonHangCombo_KhuyenMai FOREIGN KEY (MaKhuyenMai) REFERENCES Combo(MaKhuyenMai);

ALTER TABLE Combo_SanPham ADD CONSTRAINT FK_ComboSanPham_Combo FOREIGN KEY (MaKhuyenMai) REFERENCES Combo(MaKhuyenMai);
ALTER TABLE Combo_SanPham ADD CONSTRAINT FK_ComboSanPham_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham);

ALTER TABLE ChiNhanh_KhuyenMai ADD CONSTRAINT FK_ChiNhanhKhuyenMai_ChiNhanh FOREIGN KEY (TenChiNhanh) REFERENCES ChiNhanh(Ten);
ALTER TABLE ChiNhanh_KhuyenMai ADD CONSTRAINT FK_ChiNhanhKhuyenMai_KhuyenMai FOREIGN KEY (MaKhuyenMai) REFERENCES ChuongTrinhKhuyenMai(MaKhuyenMai);

ALTER TABLE KhuyenMaiTheoTiLe ADD CONSTRAINT FK_KhuyenMaiTheoTiLe_KhuyenMaiTheoDon FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMaiTheoDon(MaKhuyenMai);

ALTER TABLE KhuyenMaiTheoSoTien ADD CONSTRAINT FK_KhuyenMaiTheoSoTien_KhuyenMaiTheoDon FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMaiTheoDon(MaKhuyenMai);

ALTER TABLE Combo ADD CONSTRAINT FK_Combo_ChuongTrinhKhuyenMai FOREIGN KEY (MaKhuyenMai) REFERENCES ChuongTrinhKhuyenMai(MaKhuyenMai);






