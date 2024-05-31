CREATE FUNCTION F_TinhLuongNhanVien
(
    @MaNV			CHAR(12),
    @Thang			INT, 
    @Nam			INT
)
RETURNS VARCHAR(50) AS 
BEGIN 
	IF (NOT EXISTS(SELECT * FROM NhanVien WHERE NhanVien.MaNhanVien = @MaNV) OR LEN(@MaNV) != 10)
		RETURN 'Nhan Vien Khong Ton Tai';
    DECLARE @Luong	DECIMAL(18, 2);

	SELECT
        @Luong = ISNULL(
            SUM(
                DATEDIFF(HOUR, GioBatDau, GioKetThuc) * LuongTheoGio
            ),
            0
        )
    FROM
        CaLamViec JOIN PhucVuTheoGio ON CaLamViec.MaNhanVien = PhucVuTheoGio.MaNhanVien
    WHERE
        CaLamViec.MaNhanVien = @MaNV
        AND MONTH(CaLamViec.NgayLamViec) = @Thang
        AND YEAR(CaLamViec.NgayLamViec) = @Nam;

    IF @Luong = 0 BEGIN
		SELECT
			@Luong = ISNULL(Luong, 0)
		FROM
			QuanLy
		WHERE
			MaNhanVien = @MaNV;

		IF @Luong = 0 BEGIN
		SELECT
			@Luong = ISNULL(Luong, 0)
		FROM
			PhucVuToanThoiGian
		WHERE
			MaNhanVien = @MaNV;
		END;
	END;
	IF (@Luong = 0) 
		Return 'Nhan vien chua di lam hoac Thang/Nam khong hop le';

	RETURN @Luong;
END;

--------------Test TinhLuong
SELECT
    NhanVien.*, dbo.F_TinhLuongNhanVien(MaNhanVien, 01, 2024) AS Luong FROM NhanVien;
SELECT
    dbo.F_TinhLuongNhanVien('NV00000025', 01, 2024) AS Luong;



---------------Drop TinhLuong
DROP FUNCTION F_TinhLuongNhanVien;


--------------------------------------------------------------------------------------------------------------------------





------------------------------------------------
---------------------------------------------------------------------------------------------
CREATE FUNCTION F_Top1ChiTieu
(   
    @Thang              INT,
    @Nam                INT
)
RETURNS @TopCustomers TABLE
(
    MaKhachHang NVARCHAR(20),
    TongChiTieu DECIMAL(18,2)
)
AS
BEGIN
    DECLARE 
    @MaKhachHang        NVARCHAR(20),
    @TongChiTieu        DECIMAL(18,2);
    DECLARE cursor_customer CURSOR
    FOR SELECT KhachHangThanhVien.MaKhachHang, SUM(TongTien) as TongTien 
        FROM KhachHangThanhVien JOIN DonHang   ON KhachHangThanhVien.MaKhachHang = DonHang.MaKhachHang
        JOIN XuatHoaDon                        ON DonHang.MaDonHang = XuatHoaDon.MaDonHang
        JOIN HoaDon                            ON XuatHoaDon.MaHoaDon = HoaDon.MaHoaDon
        WHERE   MONTH(HoaDon.ThoiGianXuat)    = @Thang
        AND         YEAR(HoaDon.ThoiGianXuat) = @Nam
        GROUP BY KhachHangThanhVien.MaKhachHang;
    OPEN cursor_customer;
    FETCH NEXT FROM cursor_customer INTO 
        @MaKhachHang,
        @TongChiTieu;
    DECLARE 
        @TopCustomer    NVARCHAR(20) = NULL,
        @TopChiTieu     DECIMAL(18,2) = @TongChiTieu;
    IF (@TopChiTieu > 50000)
        INSERT INTO @TopCustomers (MaKhachHang, TongChiTieu) VALUES (@MaKhachHang, @TongChiTieu);
    ELSE 
        SET @TopChiTieu = 50000;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            FETCH NEXT FROM cursor_customer INTO 
                @MaKhachHang,
                @TongChiTieu;
            IF (@TopChiTieu < @TongChiTieu)
            BEGIN
                DELETE FROM @TopCustomers;
                INSERT INTO @TopCustomers (MaKhachHang, TongChiTieu) VALUES (@MaKhachHang, @TongChiTieu);
                SET @TopCustomer = @MaKhachHang;
                SET @TopChiTieu = @TongChiTieu;
            END
			ELSE IF (@TopChiTieu = @TongChiTieu)
			BEGIN
                INSERT INTO @TopCustomers (MaKhachHang, TongChiTieu) VALUES (@MaKhachHang, @TongChiTieu);
                SET @TopCustomer = @MaKhachHang;
                SET @TopChiTieu = @TongChiTieu;
            END
        END;
    CLOSE cursor_customer;
    DEALLOCATE cursor_customer;
    RETURN;
END;


CREATE PROCEDURE SP_TangDiem
    @Thang          INT, 
    @Nam            INT
AS
BEGIN
    DECLARE @TopCustomers TABLE
    (
        MaKhachHang NVARCHAR(20),
        TongChiTieu DECIMAL(18,2)
    );

    INSERT INTO @TopCustomers SELECT * FROM dbo.F_Top1ChiTieu (@Thang, @Nam);

    IF NOT EXISTS (SELECT * FROM @TopCustomers)
    BEGIN
        PRINT 'Kiểm tra lại Tháng/Năm hoặc không có khách hàng nào tiêu hơn 50000';
    END
    ELSE 
    BEGIN
        UPDATE KhachHangThanhVien 
        SET 
            DiemTichLuy += 200 
        WHERE
            MaKhachHang IN (SELECT MaKhachHang FROM @TopCustomers);
    END
END;


--------------Test TinhTop1ChiTieu

SELECT * FROM dbo.F_Top1ChiTieu(1,2024);
EXEC SP_TangDiem 1,2024;

UPDATE [dbo].[HoaDon]
SET TongTien = 360000
WHERE MaHoaDon = 'HD00000001'

SELECT * FROM [dbo].[HoaDon]
SELECT * FROM [dbo].[DonHang]
SELECT * FROM [dbo].[XuatHoaDon]
SELECT * FROM [dbo].[KhachHangThanhVien]
-----------------DROP
DROP PROCEDURE SP_TangDiem;
DROP FUNCTION F_Top1ChiTieu;

-------------------------------------------------------------------------------

CREATE FUNCTION F_TinhTien 
(
	@MaDonHang 		CHAR(20)
)
RETURNS DECIMAL(18,2)
AS 
BEGIN
    DECLARE @TongTien 	DECIMAL(18,2);

    SET @TongTien = 
	(
		SELECT ISNULL(SUM(sp.Gia * gs.SoLuong), 0)
		FROM DonHang_SanPham gs
		JOIN SanPham sp ON gs.MaSanPham = sp.MaSanPham	
		WHERE gs.MaDonHang = @MaDonHang
	)
	+
	(
		SELECT ISNULL(SUM(c.Gia * gc.SoLuong), 0)
		FROM DonHang_Combo gc JOIN Combo c 
		ON gc.MaKhuyenMai = c.MaKhuyenMai
		WHERE gc.MaDonHang = @MaDonHang
	);

	RETURN @TongTien;
END;


CREATE FUNCTION F_TinhTienGiam
(
	@MaDonHang		CHAR(20)
) 
RETURNS DECIMAL(18,2)
AS 
BEGIN
	DECLARE @TienGiam DECIMAL(18,2) = 0;
	DECLARE @TongTien DECIMAL(18,2) = dbo.F_TinhTien (@MaDonHang);

	SET @TienGiam = 
		ISNULL((SELECT (@TongTien * kmtl.TiLe / 100)
			FROM DonHang dh
			JOIN KhuyenMaiTheoDon kmdh ON dh.MaKhuyenMai = kmdh.MaKhuyenMai
			JOIN KhuyenMaiTheoTiLe kmtl ON kmtl.MaKhuyenMai = kmdh.MaKhuyenMai
			WHERE dh.MaDonHang = @MaDonHang AND kmdh.GiaToiThieu <=	@TongTien
		), 0);
	IF (@TienGiam > 0)
	BEGIN
		DECLARE @GiamToiDa DECIMAL(18,2) = ISNULL ((SELECT kmtl.GiamToiDa
													FROM DonHang dh
													JOIN KhuyenMaiTheoDon kmdh ON dh.MaKhuyenMai = kmdh.MaKhuyenMai
													JOIN KhuyenMaiTheoTiLe kmtl ON kmtl.MaKhuyenMai = kmdh.MaKhuyenMai
													WHERE dh.MaDonHang = @MaDonHang), 0);
		IF (@TienGiam > @GiamToiDa)
			SET @TienGiam = @GiamToiDa;
	END;

	SET @TienGiam = @TienGiam +
		ISNULL((SELECT kmst.SoTienGiam
			FROM DonHang dh
			JOIN KhuyenMaiTheoDon kmdh ON dh.MaKhuyenMai = kmdh.MaKhuyenMai
			JOIN KhuyenMaiTheoSoTien kmst ON kmst.MaKhuyenMai = kmdh.MaKhuyenMai
			WHERE dh.MaDonHang = @MaDonHang AND kmdh.GiaToiThieu <=	@TongTien
		), 0)

		+ 
		ISNULL((SELECT ggd.SoTien
			FROM DonHang dh
			JOIN MaGiamGiaBangDiem ggd ON dh.MaDonHang = ggd.MaDonHang
			WHERE dh.MaDonHang = @MaDonHang
		), 0);
	RETURN @TienGiam;
END;



CREATE FUNCTION F_ThanhToan 
(
	@MaDonHang 		CHAR(20)
)
RETURNS DECIMAL(18,2)
AS 
BEGIN
    DECLARE @TongTien 	DECIMAL(18,2) = dbo.F_TinhTien(@MaDonHang);
	DECLARE @TienGiam 	DECIMAL(18,2) = dbo.F_TinhTienGiam(@MaDonHang);

	IF (@TienGiam > @TongTien)
		RETURN 0;
	RETURN @TongTien - @TienGiam;
END;


CREATE PROCEDURE SP_XuatTienHoaDon
(
	@MaHoaDon	VARCHAR(20)
)
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM HoaDon WHERE HoaDon.MaHoaDon = @MaHoaDon))
		THROW 5000, 'Hoa Don Khong Ton Tai', 1;
	DECLARE @MaDonHang VARCHAR(20);
	SET @MaDonHang =	ISNULL((SELECT XuatHoaDon.MaDonHang 
								FROM XuatHoaDon
								WHERE MaHoaDon = @MaHoaDon)
						,0);
	IF (@MaDonHang = '0')
		THROW 5000, 'Don Hang Khong Ton Tai', 1;
	UPDATE HoaDon
	SET TongTien = dbo.F_ThanhToan(@MaDonHang),
		SoTienDuocGiam = dbo.F_TinhTienGiam(@MaDonHang)
	WHERE MaHoaDon = @MaHoaDon;
END;


------------Test TinhTien
SELECT dbo.F_TinhTien('DH00000001') AS TinhTien
SELECT dbo.F_TinhTienGiam('DH00000001') AS TinhTienGiam
SELECT dbo.F_ThanhToan('DH00000001') AS ThanhToan


EXEC SP_XuatTienHoaDon 'HD00000001';

UPDATE HoaDon
SET TongTien = 0,
	SoTienDuocGiam = 0
WHERE MaHoaDon = 'HD00000001';

SELECT *
FROM [dbo].[HoaDon];

---------------DROP

DROP PROCEDURE SP_XuatTienHoaDon;

DROP FUNCTION F_TinhTien;
DROP FUNCTION F_TinhTienGiam;
DROP FUNCTION F_ThanhToan;