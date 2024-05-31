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
    
    IF EXISTS (SELECT * FROM ChiNhanh WHERE Ten = @Ten)
    BEGIN
        PRINT 'Chi nhanh da ton tai'
        RETURN;
    END
    ELSE IF @SDT NOT LIKE '0[0-9]%' OR LEN(@SDT) != 10
    BEGIN
        PRINT 'SDT khong hop le'
        RETURN;
    END    
    ELSE
    BEGIN
        INSERT INTO ChiNhanh VALUES (@Ten, @SDT, @SoNha, @Duong, @Phuong, @Quan, @ThanhPho, @ThoiGianHoatDong)
        PRINT 'Them chi nhanh thanh cong'
        RETURN;
    END
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
        RAISERROR ('Chi nhanh khong ton tai', 16, 1);
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
----------------------------------------------------------------------

GO
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
    
    IF @SDT NOT LIKE '0[0-9]%' OR LEN(@SDT) != 10
    BEGIN
        PRINT 'SDT khong hop le';
        RETURN;
    END    
    ELSE
    BEGIN
        UPDATE ChiNhanh SET SDT = @SDT, SoNha = @SoNha, Duong = @Duong, Phuong = @Phuong, Quan = @Quan, ThanhPho = @ThanhPho, ThoiGianHoatDong = @ThoiGianHoatDong WHERE Ten = @Ten
        PRINT 'Cap nhat chi nhanh thanh cong';
        RETURN;
    END
END
-- Drop up_ChiNhanh procedure
----------------------------------------------------------------------

----------------------------------------------------------------------
----------------------------------------------------------------------

-- PROCEDURE FOR NHANVIEN
GO
CREATE PROCEDURE sp_InsertNhanVien
    @HoVaTen NVARCHAR(100),
    @MaNhanVien VARCHAR(10),
    @CCCD CHAR(12),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(255),
    @GioiTinh NVARCHAR(10),
    @Email NVARCHAR(100),
    @SoTaiKhoan VARCHAR(20),
    @NgayVaoLam DATE,
    @TenChiNhanh NVARCHAR(50),
    @IsQuanLy BIT,
    @Luong DECIMAL(18, 2)
AS
BEGIN
    BEGIN TRY
        -- Kiểm tra định dạng CCCD
        IF NOT (LEN(@CCCD) = 12 AND @CCCD LIKE '[0-9]%')
        BEGIN
            print ('CCCD không đúng định dạng')
            RETURN
        END

        -- Kiểm tra định dạng SDT
        IF NOT ((DATEDIFF(YEAR, @NgaySinh, GETDATE()) > 18))
        BEGIN
            print ('Chua đủ 18 tuổi')
            RETURN
        END

        -- Kiểm tra định dạng email
        IF NOT (@Email LIKE '%@%')
        BEGIN
            PRINT ('Email không đúng định dạng')
            RETURN
        END

        -- Kiểm tra nếu là quản lý thì không được trùng chi nhánh
        IF @IsQuanLy = 1 AND EXISTS (
            SELECT 1
            FROM ChiNhanh_QuanLy
            WHERE TenChiNhanh = @TenChiNhanh
        )
        BEGIN
            PRINT ('Chi nhánh này đã có quản lý')
            RETURN
        END

        -- Thực hiện insert nhân viên
        INSERT INTO NhanVien (HoVaTen, MaNhanVien, CCCD, NgaySinh, DiaChi, GioiTinh, Email, SoTaiKhoan, NgayVaoLam, TenChiNhanh)
        VALUES (@HoVaTen, @MaNhanVien, @CCCD, @NgaySinh, @DiaChi, @GioiTinh, @Email, @SoTaiKhoan, @NgayVaoLam, @TenChiNhanh)

        IF @IsQuanLy = 1
        BEGIN
            INSERT INTO QuanLy (MaNhanVien, Luong) VALUES (@MaNhanVien, @Luong)
            INSERT INTO ChiNhanh_QuanLy (TenChiNhanh, MaNhanVien, NgayBatDauQuanLi) VALUES (@TenChiNhanh, @MaNhanVien, @NgayVaoLam)
        END
        ELSE
        BEGIN
            INSERT INTO PhucVu (MaNhanVien) VALUES (@MaNhanVien)
            PRINT ('Thêm nhân viên thành công')
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE()
    END CATCH
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
    BEGIN TRY
        -- Kiểm tra định dạng CCCD
        IF NOT (LEN(@CCCD) = 12 AND @CCCD LIKE '[0-9]%')
        BEGIN
            print ('CCCD không đúng định dạng')
            RETURN
        END

        -- Kiểm tra định dạng email
        IF NOT (@Email LIKE '%@%')
        BEGIN
            PRINT ('Email không đúng định dạng')
            RETURN
        END

        -- Thực hiện cập nhật thông tin nhân viên
        UPDATE NhanVien
        SET HoVaTen = @HoVaTen,
            CCCD = @CCCD,
            DiaChi = @DiaChi,
            Email = @Email,
            SoTaiKhoan = @SoTaiKhoan
        WHERE MaNhanVien = @MaNhanVien
        PRINT ('Cập nhật nhân viên thành công')
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE()
    END CATCH
END
-- Drop sp_UpdateNhanVien procedure
----------------------------------------------------------------------

GO
CREATE PROCEDURE sp_DeleteNhanVien
    @MaNhanVien VARCHAR(10)
AS
BEGIN
    BEGIN TRY
        -- Kiểm tra mã nhân viên tồn tại
        IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNhanVien = @MaNhanVien)
        BEGIN
            RAISERROR ('Mã nhân viên không tồn tại', 16, 1)
            RETURN
        END

        -- Thực hiện xóa nhân viên
        DELETE FROM PhucVu WHERE MaNhanVien = @MaNhanVien
        DELETE FROM ChiNhanh_QuanLy WHERE MaNhanVien = @MaNhanVien
        DELETE FROM QuanLy WHERE MaNhanVien = @MaNhanVien
        DELETE FROM XuatHoaDon WHERE MaNhanVien = @MaNhanVien
        DELETE FROM NhanVien WHERE MaNhanVien = @MaNhanVien

        PRINT ('Xóa nhân viên thành công')
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE()
    END CATCH
END
-- Drop sp_DeleteNhanVien procedure

----------------------------------------------------------------------
----------------------------------------------------------------------


-- 2.3 Ở ĐÂY --
----------------------------------------------------------------------

-- Thủ tục 1: Lấy thông tin nhân viên và chi nhánh họ làm việc, sắp xếp theo tên nhân viên
CREATE PROCEDURE sp_GetEmployeeAndBranch
    @TenChiNhanh NVARCHAR(50) = NULL
AS
BEGIN
    SELECT nv.HoVaTen, nv.MaNhanVien, nv.Email, cn.Ten AS TenChiNhanh, cn.ThanhPho
    FROM NhanVien nv
    INNER JOIN ChiNhanh cn ON nv.TenChiNhanh = cn.Ten
    WHERE (@TenChiNhanh IS NULL OR cn.Ten = @TenChiNhanh)
    ORDER BY nv.HoVaTen;
END
-- Drop sp_GetEmployeeAndBranch procedure
----------------------------------------------------------------------

-- Minh họa gọi thủ tục
EXEC sp_GetEmployeeAndBranch @TenChiNhanh = 'ChiNhanh1';
EXEC sp_GetEmployeeAndBranch; -- Không truyền tham số để lấy tất cả

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
        dh.NgayTao,
        dh.GioTao
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
    @TenChiNhanh = 'ChiNhanh1',
    @NgayBatDau = '2023-05-01',
    @NgayKetThuc = '2024-05-31';