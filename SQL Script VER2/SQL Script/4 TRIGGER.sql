

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
------CongDiem
CREATE TRIGGER tr_Tich_diem
ON HoaDon
AFTER UPDATE
AS
BEGIN
			DECLARE @Diem_cong DECIMAL(18,2)
				= 
				(SELECT hd.TongTien
				FROM HoaDon hd
				JOIN inserted i ON i.MaHoaDon = hd.MaHoaDon
				JOIN deleted d ON d.MaHoaDon = hd.MaHoaDon
				WHERE i.ThoiGianXuat IS NOT NULL AND d.ThoiGianXuat IS NULL		
				)
			SET @Diem_cong =
				CASE 
					WHEN @Diem_cong > 1000000 THEN 200
					WHEN @Diem_cong > 500000 THEN 80
					WHEN @Diem_cong > 200000 THEN 30
					WHEN @Diem_cong > 100000 THEN 10
					ELSE 0
				END;
			PRINT @Diem_cong;
				
			UPDATE KhachHangThanhVien
			SET DiemTichLuy = DiemTichLuy + @Diem_cong		
			FROM KhachHangThanhVien tv
			JOIN DonHang dh ON dh.MaKhachHang = tv.MaKhachHang
			JOIN XuatHoaDon ON dh.MaDonHang = XuatHoaDon.MaDonHang
			JOIN inserted i ON i.MaHoaDon = XuatHoaDon.MaHoaDon
			JOIN deleted d ON d.MaHoaDon = XuatHoaDon.MaHoaDon
			WHERE i.ThoiGianXuat IS NOT NULL AND d.ThoiGianXuat IS NULL			
END;
-----------------------------------Test
UPDATE HoaDon SET ThoiGianXuat = '2023-09-11' WHERE MaHoaDon = 'HD00000057'
SELECT *
FROM [dbo].[HoaDon]
--WHERE ThoiGianXuat IS NULL
SELECT *
FROM [dbo].[KhachHangThanhVien]


UPDATE HoaDon
SET TongTien = 500000,
	SoTienDuocGiam = 0,
	ThoiGianXuat = NULL
WHERE MaHoaDon = 'HD00000057';

------------------------------------DROP

DROP TRIGGER tr_Tich_diem
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
-------------------------Test
SELECT *
FROM [dbo].[DonHang_SanPham]
SELECT *
FROM [dbo].[HoaDon]

INSERT INTO DonHang_SanPham
VALUES
	('DH00000057', 'SP00000007', 3);


UPDATE HoaDon
SET TongTien = 0,
	SoTienDuocGiam = 0,
	ThoiGianXuat = NULL
WHERE MaHoaDon = 'HD000057';

delete from DonHang_SanPham
where MaDonHang = 'DH000057';


--------------------------------DROP
DROP TRIGGER tr_DonHang_SanPham_InsertUpdateDelete



---------------------------------
CREATE TRIGGER tr_DonHang_Combo_InsertUpdateDelete
ON DonHang_Combo
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Tạo bảng tạm để lưu trữ dữ liệu từ inserted và deleted
    SELECT i.MaDonHang, i.MaKhuyenMai, i.SoLuong, Combo.Gia, cs.SoLuong AS SoLuongSP, 'INSERT' AS ActionType
    INTO #TempTable
    FROM inserted i
    INNER JOIN Combo ON i.MaKhuyenMai = Combo.MaKhuyenMai
	INNER JOIN Combo_SanPham cs ON Combo.MaKhuyenMai = cs.MaKhuyenMai

    UNION ALL

    SELECT d.MaDonHang, d.MaKhuyenMai, d.SoLuong * (-1), Combo.Gia, cs.SoLuong AS SoLuongSP, 'DELETE' AS ActionType
    FROM deleted d
    INNER JOIN Combo ON d.MaKhuyenMai = Combo.MaKhuyenMai
	INNER JOIN Combo_SanPham cs ON Combo.MaKhuyenMai = cs.MaKhuyenMai

    -- Cập nhật số lượng sản phẩm và tổng tiền cho hóa đơn tương ứng
    UPDATE hd
    SET hd.TongSoLuongSanPham = ISNULL(hd.TongSoLuongSanPham, 0) + ISNULL((
        SELECT SUM(t.SoLuong * t.SoLuongSP)
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
END;

-------------------------Test
SELECT *
FROM [dbo].[Combo_SanPham]
SELECT *
FROM [dbo].[DonHang_Combo]
SELECT *
FROM [dbo].[HoaDon]

INSERT INTO DonHang_Combo
VALUES
	('DH00000017', 'KM00000008', 3);


UPDATE HoaDon
SET TongTien = 0,
	TongSoLuongSanPham = 0,
	SoTienDuocGiam = 0,
	ThoiGianXuat = NULL
WHERE MaHoaDon = 'HD00000017';

delete from DonHang_Combo
where MaDonHang = 'DH00000017';


--------------------------------DROP
DROP TRIGGER tr_DonHang_Combo_InsertUpdateDelete


----------------------------------------------------------------------------
-- CREATE TRIGGER tr_DonHang_KhuyenMai_InsertUpdateDelete
-- ON DonHang
-- AFTER INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     DECLARE @MaHoaDon NVARCHAR(10);
--     DECLARE cursor_MaHoaDon CURSOR
-- 	FOR (SELECT xhd.MaHoaDon, 'INSERT' AS ActionType
--        FROM inserted i
-- 	   INNER JOIN XuatHoaDon xhd ON i.MaDonHang = xhd.MaDonHang

--        UNION ALL

--        SELECT xhd.MaHoaDon, 'DELETE' AS ActionType
--        FROM deleted d
--        INNER JOIN XuatHoaDon xhd ON d.MaDonHang = xhd.MaDonHang
--    );
--     OPEN cursor_MaHoaDon;
--     FETCH NEXT FROM cursor_MaHoaDon INTO
--        @MaHoaDon;
--     WHILE @@FETCH_STATUS = 0
--     BEGIN
--        EXEC SP_XuatTienHoaDon @MaHoaDon;
--        FETCH NEXT FROM cursor_MaHoaDon INTO
--            @MaHoaDon;
--     END;
--     CLOSE cursor_MaHoaDon;
--     DEALLOCATE cursor_MaHoaDon;
-- 	SET @MaHoaDon = ISNULL((SELECT xhd.MaHoaDon
--         FROM inserted i
-- 	    INNER JOIN XuatHoaDon xhd ON i.MaDonHang = xhd.MaDonHang),0);
-- 	IF (@MaHoaDon != '0' AND LEN(@MaHoaDon) = 10 AND @MaHoaDon LIKE 'HD%') 
-- 		EXEC SP_XuatTienHoaDon @MaHoaDon;
-- END;

-- -------------------------Test
-- SELECT *
-- FROM [dbo].[DonHang]
-- SELECT *
-- FROM [dbo].[HoaDon]

-- UPDATE DonHang
-- SET	MaKhuyenMai = 'KM00000001'
-- WHERE MaDonHang = 'DH00000043';


-- --------------------------------DROP
-- DROP TRIGGER tr_DonHang_KhuyenMai_InsertUpdateDelete