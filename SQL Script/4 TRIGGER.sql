

-- TRIGGER FOR CHINHANH
CREATE TRIGGER trg_Insert_ChiNhanh
ON ChiNhanh
AFTER INSERT
AS
BEGIN
    DECLARE @Ten NVARCHAR(50)

    SELECT @Ten = Ten FROM inserted

    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000001', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000002', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000003', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000004', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000005', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000006', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000007', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000008', 'Con Cho')
    INSERT INTO BAN(TenChiNhanh, MaBan, TinhTrang) VALUES (@Ten, 'BAN0000009', 'Con Cho')
END
-- Drop trg_Insert_ChiNhanh trigger

----------------------------------------------------------------------
----------------------------------------------------------------------

-- 2.2 Ở ĐÂY --
----------------------------------------------------------------------
CREATE TRIGGER trg_Delete_ChiNhanh
ON ChiNhanh
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @Ten NVARCHAR(50)
    DECLARE @MaNhanVien VARCHAR(10)

    SELECT @Ten = Ten FROM deleted

    -- Lấy danh sách mã nhân viên trong chi nhánh
    DECLARE cur_NhanVien CURSOR
    FOR SELECT MaNhanVien FROM NhanVien WHERE TenChiNhanh = @Ten

    OPEN cur_NhanVien

    FETCH NEXT FROM cur_NhanVien INTO @MaNhanVien

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Gọi procedure để xóa nhân viên
        EXEC sp_DeleteNhanVien @MaNhanVien

        FETCH NEXT FROM cur_NhanVien INTO @MaNhanVien
    END

    CLOSE cur_NhanVien
    DEALLOCATE cur_NhanVien

    -- Xóa bàn trong chi nhánh
    DELETE FROM HoaDon
    WHERE TenChiNhanh = @Ten

    -- Xóa bàn trong chi nhánh
    DELETE FROM BAN
    WHERE TenChiNhanh = @Ten

    -- Xóa chi nhánh
    DELETE FROM ChiNhanh
    WHERE Ten = @Ten
END
-- Drop trg_Delete_ChiNhanh trigger

----------------------------------------------------------------------
----------------------------------------------------------------------

-- TRIGGER FOR DONHANG_SANPHAM
CREATE TRIGGER tr_DonHang_SanPham_InsertUpdateDelete
ON DonHang_SanPham
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Tạo bảng tạm để lưu trữ dữ liệu từ inserted và deleted
    SELECT i.MaDonHang, i.MaSanPham, i.SoLuong, sp.Gia, 'INSERT' AS ActionType
    INTO #TempTable
    FROM inserted i
    INNER JOIN SanPham sp ON i.MaSanPham = sp.MaSanPham

    UNION ALL

    SELECT d.MaDonHang, d.MaSanPham, d.SoLuong * (-1), sp.Gia, 'DELETE' AS ActionType
    FROM deleted d
    INNER JOIN SanPham sp ON d.MaSanPham = sp.MaSanPham

    -- Cập nhật số lượng sản phẩm và tổng tiền cho hóa đơn tương ứng
    UPDATE hd
    SET hd.TongSoLuongSanPham = ISNULL(hd.TongSoLuongSanPham, 0) + ISNULL((
        SELECT SUM(t.SoLuong)
        FROM #TempTable t
        WHERE hd.MaHoaDon = (
            SELECT XuatHoaDon.MaHoaDon
            FROM XuatHoaDon
            WHERE XuatHoaDon.MaDonHang = t.MaDonHang
        )
    ), 0),
    hd.TongTien = ISNULL(hd.TongTien, 0) + ISNULL((
        SELECT SUM(t.SoLuong * t.Gia)
        FROM #TempTable t
        WHERE hd.MaHoaDon = (
            SELECT XuatHoaDon.MaHoaDon
            FROM XuatHoaDon
            WHERE XuatHoaDon.MaDonHang = t.MaDonHang
        )
    ), 0)
    FROM HoaDon hd

    DROP TABLE #TempTable
END
-- Drop tr_DonHang_SanPham_InsertUpdateDelete trigger