-- 2.1 Ở ĐÂY (CHINHANH HAY NHANVIEN ĐỀU ĐƯỢC) --
----------------------------------------------------------------------
-- PROCEDURE FOR CHINHANH
GO
CREATE PROCEDURE in_ChiNhanh
    @Ten NVARCHAR(50),
    @SDT VARCHAR(10),
    @SoNha NVARCHAR(20),
    @Duong NVARCHAR(50),
    @Phuong NVARCHAR(50),
    @Quan NVARCHAR(50),
    @ThanhPho NVARCHAR(50),
    @ThoiGianHoatDong NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
	IF (EXISTS (SELECT * FROM ChiNhanh WHERE ChiNhanh.Ten = @Ten))
    BEGIN
		PRINT ('Chi nhanh da ton tai');
        RETURN;
    END
    IF NOT (LEN(@SDT) = 10 AND @SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
		PRINT ('So dien thoai khong dung dinh dang 10 chu so');    
        RETURN;
    END
    INSERT INTO ChiNhanh VALUES (@Ten, @SDT, @SoNha, @Duong, @Phuong, @Quan, @ThanhPho, @ThoiGianHoatDong)
    PRINT 'Them chi nhanh thanh cong'
END
-- Drop in_ChiNhanh procedure
----------------------------------------------------------------------

GO
CREATE PROCEDURE de_ChiNhanh
    @Ten NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (SELECT * FROM ChiNhanh WHERE Ten = @Ten)
    BEGIN
        PRINT ('Chi nhanh khong ton tai');
        RETURN;
    END
    ELSE
    BEGIN
        DELETE FROM ChiNhanh WHERE Ten = @Ten
        PRINT 'Xoa chi nhanh thanh cong';
        RETURN;
    END
END
-- Drop de_ChiNhanh procedure
CREATE PROCEDURE up_ChiNhanh
    @Ten NVARCHAR(50),
    @SDT VARCHAR(10),
    @SoNha NVARCHAR(20),
    @Duong NVARCHAR(50),
    @Phuong NVARCHAR(50),
    @Quan NVARCHAR(50),
    @ThanhPho NVARCHAR(50),
    @ThoiGianHoatDong NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
	IF (NOT EXISTS (SELECT * FROM ChiNhanh WHERE ChiNhanh.Ten = @Ten))
    BEGIN
		PRINT 'Chi nhanh khong ton tai';
        RETURN;
    END
    IF NOT (LEN(@SDT) = 10 AND @SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
		PRINT 'So dien thoai khong dung dinh dang 10 chu so';  
        RETURN;
    END
    UPDATE ChiNhanh SET SDT = @SDT, SoNha = @SoNha, Duong = @Duong, Phuong = @Phuong, Quan = @Quan, ThanhPho = @ThanhPho, ThoiGianHoatDong = @ThoiGianHoatDong WHERE Ten = @Ten
    PRINT 'Cap nhat chi nhanh thanh cong';
END
-- Drop up_ChiNhanh procedure

--Test---------------------------------------
EXEC in_ChiNhanh
	@Ten				= 'Chi Nhanh X',
	@SDT				= '0000000000',
	@SoNha				= '000',
	@Duong				= '000',
	@Phuong				= '000',
	@Quan				= '000',
	@ThanhPho			= '000',
	@ThoiGianHoatDong	= '000';

EXEC up_ChiNhanh
	@Ten				= 'Chi Nhanh X',
	@SDT				= '0000000001',
	@SoNha				= '001',
	@Duong				= '000',
	@Phuong				= '000',
	@Quan				= '000',
	@ThanhPho			= '000',
	@ThoiGianHoatDong	= '8:00:00 - 22:00:00';

EXEC de_ChiNhanh 'Chi Nhanh X';

SELECT * 
FROM [dbo].[ChiNhanh]

DROP PROCEDURE in_ChiNhanh
DROP PROCEDURE up_ChiNhanh
DROP PROCEDURE de_ChiNhanh
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------

-- PROCEDURE FOR NHANVIEN
GO
CREATE PROCEDURE sp_InsertNhanVien
    @HoVaTen            NVARCHAR(100),
    @MaNhanVien         VARCHAR(10),
    @CCCD               CHAR(12),
    @NgaySinh           DATE,
    @DiaChi             NVARCHAR(255),
    @GioiTinh           NVARCHAR(10),
    @Email              NVARCHAR(100),
    @SoTaiKhoan         VARCHAR(20),
    @NgayVaoLam         DATE,
    @TenChiNhanh        NVARCHAR(50),
    @IsQuanLy           BIT,
    @IsPVFT             BIT,
    @Luong              DECIMAL(18, 2)
AS
BEGIN
    IF (EXISTS(SELECT * FROM NhanVien WHERE NhanVien.MaNhanVien = @MaNhanVien))
    BEGIN
            PRINT 'Ma so nhan vien da ton tai';
            RETURN;
    END
    IF NOT (LEN(@CCCD) = 12 AND @CCCD LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
            PRINT 'Can cuoc cong dan khong dung dinh dang 12 chu so';
            RETURN;
    END
    IF (EXISTS (SELECT * FROM NhanVien WHERE NhanVien.CCCD = @CCCD))
    BEGIN
            PRINT 'CCCD nhan vien da ton tai';
            RETURN;
    END
    IF NOT (@NgaySinh LIKE '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]')
    BEGIN
            PRINT 'Ngay sinh khong dung dinh dang';
            RETURN;
    END
    IF NOT (DATEDIFF(YEAR, @NgaySinh, GETDATE()) > 18)
    BEGIN
            PRINT 'Chua du 18 tuoi';
            RETURN;
    END
    IF NOT (@GioiTinh IN ('Nam', 'Nu'))
    BEGIN
            PRINT 'Gioi Tinh khong dung dinh dang';
            RETURN;
    END
    IF NOT (@Email LIKE '%@%')
    BEGIN
            PRINT 'Email khong dung dinh dang';
            RETURN;
    END
    IF (EXISTS (SELECT * FROM NhanVien WHERE NhanVien.Email = @Email))
    BEGIN
            PRINT 'Email nhan vien da ton tai';
            RETURN;
    END
    IF (NOT EXISTS (SELECT * FROM ChiNhanh WHERE ChiNhanh.Ten = @TenChiNhanh))
    BEGIN
            PRINT 'Chi nhanh khong ton tai'; 
            RETURN;
    END  

        -- Thực hiện insert nhân viên
    INSERT INTO NhanVien (HoVaTen, MaNhanVien, CCCD, NgaySinh, DiaChi, GioiTinh, Email, SoTaiKhoan, NgayVaoLam, TenChiNhanh)
    VALUES (@HoVaTen, @MaNhanVien, @CCCD, @NgaySinh, @DiaChi, @GioiTinh, @Email, @SoTaiKhoan, @NgayVaoLam, @TenChiNhanh)
    IF @IsQuanLy = 1 
    BEGIN
        IF (EXISTS ( SELECT * FROM ChiNhanh_QuanLy WHERE TenChiNhanh = @TenChiNhanh))
        BEGIN
            PRINT ('Chi nhanh nay da co quan ly')
            RETURN;
        END
        INSERT INTO QuanLy (MaNhanVien, Luong) VALUES (@MaNhanVien, @Luong)
        INSERT INTO ChiNhanh_QuanLy (TenChiNhanh, MaNhanVien, NgayBatDauQuanLi) VALUES (@TenChiNhanh, @MaNhanVien, @NgayVaoLam)
    END

    ELSE IF @IsPVFT = 1
    BEGIN
        INSERT INTO PhucVu (MaNhanVien) VALUES (@MaNhanVien)
        INSERT INTO PhucVuToanThoiGian VALUES (@MaNhanVien, @Luong)
    END

    ELSE 
    BEGIN
        INSERT INTO PhucVu (MaNhanVien) VALUES (@MaNhanVien)
        INSERT INTO PhucVuTheoGio VALUES (@MaNhanVien, @Luong)
    END

    PRINT ('Thêm nhân viên thành công')
END
-- Drop sp_InsertNhanVien procedure
----------------------------------------------------------------------

GO
CREATE PROCEDURE sp_UpdateNhanVien
    @MaNhanVien VARCHAR(10),
    @HoVaTen NVARCHAR(100),
    @CCCD CHAR(12),
    @DiaChi NVARCHAR(255),
    @Email NVARCHAR(100),
    @SoTaiKhoan VARCHAR(20)
AS
BEGIN
    -- Kiểm tra định dạng CCCD
    IF NOT (LEN(@CCCD) = 12 AND @CCCD LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
		PRINT 'Can cuoc cong dan khong dung dinh dang 12 chu so';
        RETURN;
    END
    IF (EXISTS (SELECT * FROM NhanVien WHERE (NhanVien.MaNhanVien != @MaNhanVien AND NhanVien.CCCD = @CCCD)))
    BEGIN
		PRINT 'CCCD nhan vien da ton tai';
        RETURN;
    END

    -- Kiểm tra định dạng email
    IF NOT (@Email LIKE '%@%')
    BEGIN
        PRINT 'Email khong dung dinh dang';
        RETURN;
    END

        -- Thực hiện cập nhật thông tin nhân viên
    UPDATE NhanVien
    SET HoVaTen = @HoVaTen,
        CCCD = @CCCD,
        DiaChi = @DiaChi,
        Email = @Email,
        SoTaiKhoan = @SoTaiKhoan
    WHERE MaNhanVien = @MaNhanVien
    PRINT ('Cap nhat nhan vien thanh cong')
END
-- Drop sp_UpdateNhanVien procedure
----------------------------------------------------------------------

GO
CREATE PROCEDURE sp_DeleteNhanVien
    @MaNhanVien VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM NhanVien WHERE MaNhanVien = @MaNhanVien)
    BEGIN
        PRINT 'Ma so nhan vien khong ton tai';
        RETURN;
    END

    DELETE FROM PhucVuTheoGio WHERE MaNhanVien = @MaNhanVien
    DELETE FROM PhucVuToanThoiGian WHERE MaNhanVien = @MaNhanVien
    DELETE FROM PhucVu WHERE MaNhanVien = @MaNhanVien
    DELETE FROM ChiNhanh_QuanLy WHERE MaNhanVien = @MaNhanVien
    DELETE FROM QuanLy WHERE MaNhanVien = @MaNhanVien
    DELETE FROM XuatHoaDon WHERE MaNhanVien = @MaNhanVien
    DELETE FROM NhanVien WHERE MaNhanVien = @MaNhanVien

    PRINT ('Xoa nhan vien thanh cong')
END
-- Drop sp_DeleteNhanVien procedure
-------------------------------------------------------------
--TEST
EXEC sp_InsertNhanVien
    @HovaTen			= 'Nguyen Van Test',
    @MaNhanVien         = 'NV00000000',
    @CCCD				= '000000000000',
    @NgaySinh			= '2000-01-01',
    @DiaChi				= '123 Pham Van Dong, Ha Noi',
    @GioiTinh			= 'Nam',
    @Email				= 'nguyenvanTest@example.com',
    @SoTaiKhoan         = '000000000',
    @NgayVaoLam			= '2023-01-15',
	@IsQuanLy			= 0,
    @IsPVFT				= 0,
    @TenChiNhanh		= 'Chi Nhanh A',
	@Luong				= 0;

EXEC sp_UpdateNhanVien
    @HovaTen			= 'Nguyen Van Tester',
    @MaNhanVien         = 'NV00000000',
    @CCCD				= '000000000000',
    @DiaChi				= 'HCM',
    @Email				= 'nguyenvanTest@example.com',
    @SoTaiKhoan         = '000000000';



EXEC sp_DeleteNhanVien 'NV00000000';



select *
from [dbo].[NhanVien]
select *
from [dbo].[QuanLy]
select *
from [dbo].[PhucVu]

----DROP PROCEDURE
DROP PROCEDURE sp_InsertNhanVien
DROP PROCEDURE sp_UpdateNhanVien
DROP PROCEDURE sp_DeleteNhanVien
----------------------------------------------------------------------
----------------------------------------------------------------------


-- 2.3 Ở ĐÂY --
----------------------------------------------------------------------

-- Thủ tục 1: Lấy thông tin nhân viên và chi nhánh họ làm việc, sắp xếp theo tên nhân viên
CREATE PROCEDURE sp_GetEmployeeAndBranch
    @TenChiNhanh NVARCHAR(50) = NULL
AS
BEGIN
    IF ((@TenChiNhanh IS NOT NULL) AND (NOT EXISTS (SELECT * FROM ChiNhanh WHERE ChiNhanh.Ten = @TenChiNhanh)))
            THROW 50000, 'Chi nhanh khong ton tai',1;  
    SELECT nv.HoVaTen, nv.MaNhanVien, nv.Email, cn.Ten AS TenChiNhanh, cn.ThanhPho
    FROM NhanVien nv
    INNER JOIN ChiNhanh cn ON nv.TenChiNhanh = cn.Ten
    WHERE (@TenChiNhanh IS NULL OR cn.Ten = @TenChiNhanh)
    ORDER BY nv.HoVaTen;
END
-- Drop sp_GetEmployeeAndBranch procedure
----------------------------------------------------------------------

-- Minh họa gọi thủ tục
EXEC sp_GetEmployeeAndBranch @TenChiNhanh = 'Chi Nhanh A';
EXEC sp_GetEmployeeAndBranch; -- Không truyền tham số để lấy tất cả

DROP PROCEDURE sp_GetEmployeeAndBranch
----------------------------------------------------------------------
----------------------------------------------------------------------

-- Thủ tục 2: 
CREATE PROCEDURE sp_XuatHoaDonTheoChiNhanhVaNgay
    @TenChiNhanh NVARCHAR(50) = NULL,
    @NgayBatDau DATE = NULL,
    @NgayKetThuc DATE = NULL
AS
BEGIN
    -- Truy vấn xuất hóa đơn theo chi nhánh và ngày

    SELECT
        hd.MaHoaDon,
        hd.ThoiGianXuat,
        hd.TongSoLuongSanPham,
        hd.TongTien,
        hd.SoTienDuocGiam,
        cn.Ten AS TenChiNhanh,
        nv.HoVaTen AS NguoiXuatDon,
        dh.MaDonHang,
		dh.ThoiGianTao
    FROM HoaDon hd
    INNER JOIN ChiNhanh cn ON hd.TenChiNhanh = cn.Ten
    INNER JOIN XuatHoaDon xhd ON hd.MaHoaDon = xhd.MaHoaDon
    INNER JOIN NhanVien nv ON xhd.MaNhanVien = nv.MaNhanVien
    INNER JOIN DonHang dh ON xhd.MaDonHang = dh.MaDonHang
    WHERE
        (@TenChiNhanh IS NULL OR cn.Ten = @TenChiNhanh)
        AND (@NgayBatDau IS NULL OR hd.ThoiGianXuat >= @NgayBatDau)
        AND (@NgayKetThuc IS NULL OR hd.ThoiGianXuat <= @NgayKetThuc)
    ORDER BY
        hd.ThoiGianXuat DESC;

    -- Truy vấn tổng hợp doanh thu theo chi nhánh và nhân viên
    SELECT
        cn.Ten AS TenChiNhanh,
        nv.HoVaTen AS NhanVien,
        SUM(hd.TongTien) AS TongDoanhThu
    FROM HoaDon hd
    INNER JOIN ChiNhanh cn ON hd.TenChiNhanh = cn.Ten
    INNER JOIN XuatHoaDon xhd ON hd.MaHoaDon = xhd.MaHoaDon
    INNER JOIN NhanVien nv ON xhd.MaNhanVien = nv.MaNhanVien
    WHERE
        (@TenChiNhanh IS NULL OR cn.Ten = @TenChiNhanh)
        AND (@NgayBatDau IS NULL OR hd.ThoiGianXuat >= @NgayBatDau)
        AND (@NgayKetThuc IS NULL OR hd.ThoiGianXuat <= @NgayKetThuc)
    GROUP BY
        cn.Ten, nv.HoVaTen
    HAVING
        SUM(hd.TongTien) > 0
    ORDER BY
        TongDoanhThu DESC;
END
-- drop sp_XuatHoaDonTheoChiNhanhVaNgay procedure
----------------------------------------------------------------------

-- Minh họa gọi thủ tục
EXEC sp_XuatHoaDonTheoChiNhanhVaNgay
    @TenChiNhanh = 'Chi Nhanh A',
    @NgayBatDau = '2024-01-01',
    @NgayKetThuc = '2024-01-31';

DROP PROCEDURE sp_XuatHoaDonTheoChiNhanhVaNgay