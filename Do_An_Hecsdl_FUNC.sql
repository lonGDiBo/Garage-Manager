USE QLSuaChuaXe3
GO
---Thêm, xóa, sửa, xuất bảng NHÂN VIÊN
-----Xuât thông tin
CREATE PROC XUAT_NV
as
	SELECT * FROM VIEW_NV
-----Tìm nhân viên theo tên
GO
CREATE FUNCTION TIM_TEN_NV(@name NVARCHAR(50)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VIEW_NV
		WHERE Hoten LIKE N'%' + @name + '%')
GO
-----Tìm nhân viên theo mã số
CREATE FUNCTION TIM_MS_NV(@maNV CHAR(6)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VIEW_NV
		WHERE NV_NguoiID LIKE '%' + @maNV + '%')
GO
-----Lấy các nhân viên cùng một chức vụ
CREATE FUNCTION XUAT_NV_CHUCVU(@machucvu CHAR(6)) RETURNS table
as
	RETURN (SELECT * FROM VIEW_NV WHERE NV_NguoiID in (SELECT NV_NguoiID FROM NHANVIEN WHERE MaCV=@machucvu))
-----thêm
go
CREATE proc THEM_NV
@nguoiid CHAR(6),@hoten nvarchar(30),@diachi nvarchar(30),@dienthoai CHAR(11),
@ngaysinh date,@cccd CHAR(11),@gioitinnh bit,@macv CHAR(6),@luong int,@result int output
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO dbo.TT_NGUOI(NguoiID,Hoten,DiaChi,DienThoai,NgaySinh,CCCD,GioiTinh)
			VALUES(@nguoiid, @hoten, @diachi, @dienthoai,@ngaysinh,@cccd,@gioitinnh)
			INSERT INTO dbo.NHANVIEN(NV_NguoiID,MaCV,Luong)
			VALUES(@nguoiid,@macv,@luong)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
-----sửa
go
CREATE PROC SUA_NV
@nguoiid CHAR(6),@hoten nvarchar(30),@diachi nvarchar(30),@dienthoai CHAR(11),@ngaysinh date,
@cccd CHAR(11),@gioitinh bit,@macv CHAR(6),@luong INT,@result int output
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE dbo.TT_NGUOI
			SET Hoten=@hoten,DiaChi=@diachi,DienThoai=@dienthoai,NgaySinh=@ngaysinh,CCCD=@cccd,GioiTinh=@gioitinh
			WHERE NguoiID = @nguoiid;
			UPDATE dbo.NHANVIEN
			SET Luong=@luong, MaCV=@macv
			WHERE NV_NguoiID=@nguoiid;
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
-----XÓA
go
CREATE PROC XOA_NV
@nguoiid CHAR(6),
@result int output
as
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM dbo.TT_NGUOI WHERE NguoiID = @nguoiid;
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO

CREATE PROC XUAT_CHUCVU
as
	SELECT * FROM CHUCVU
GO
---Thêm, xóa, sửa, xuất bảng KHÁCH HÀNG
-----XUẤT
CREATE PROC XUAT_KH
as
	SELECT * FROM VIEW_KH

GO
-----Tìm khách hàng theo tên
GO
CREATE FUNCTION TIM_TEN_KH(@name NVARCHAR(50)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VIEW_KH
		WHERE Hoten LIKE N'%' + @name + '%')
GO
-----Tìm khách hàng theo mã số
CREATE FUNCTION TIM_MS_KH(@maKH CHAR(6)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VIEW_KH
		WHERE KH_NguoiID LIKE N'%' + @maKH + '%')
GO
-----THÊM
CREATE PROC THEM_KH 
@nguoiid CHAR(6),@hoten nvarchar(30),@diachi nvarchar(30),@dienthoai CHAR(11),
@ngaysinh date,@cccd CHAR(11),@gioitinh bit,@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO TT_NGUOI VALUES (@nguoiid,@hoten,@diachi,@dienthoai,@ngaysinh,@cccd,@gioitinh)
			INSERT INTO KHACHHANG VALUES(@nguoiid)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- SỬA
CREATE PROC SUA_KH
@nguoiid CHAR(6),@hoten nvarchar(30),@diachi nvarchar(30),@dienthoai CHAR(11),
@ngaysinh date,@cccd CHAR(11),@gioitinh bit,@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE TT_NGUOI
			SET HoTen=@hoten,DiaChi=@DiaChi,DienThoai=@dienthoai,NgaySinh=@ngaysinh,CCCD=@cccd,GioiTinh=@gioitinh
			WHERE NguoiID=@nguoiid
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- Xóa
CREATE PROC XOA_KH
@nguoiid CHAR(6),
@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM TT_Nguoi
			WHERE NguoiID=@nguoiid
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
---Thêm, xóa, sửa, xuất bảng VẬT LIỆU
CREATE PROC XUAT_VL
as
	SELECT * FROM VATLIEU

GO
-----Tìm vật liệu theo tên
GO
CREATE FUNCTION TIM_TEN_VL(@name NVARCHAR(50)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VATLIEU
		WHERE TenVL LIKE N'%' + @name + '%')
GO
-----Tìm vật liệu theo mã số
CREATE FUNCTION TIM_MS_VL(@maVL CHAR(6)) RETURNS TABLE
AS
	RETURN(SELECT * FROM VATLIEU
		WHERE MaVL LIKE N'%' + @maVL + '%')
GO
-----THÊM
CREATE PROC THEM_VL 
@mavl CHAR(6),@tenvl nvarchar(20),@soluong int,@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO VATLIEU VALUES (@mavl,@tenvl,@soluong)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- SỬA
CREATE PROC SUA_VL
@mavl CHAR(6),@tenvl nvarchar(20),@soluong int,@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE VATLIEU
			SET TenVL=@tenvl,SoLuong=@soluong
			WHERE MaVL=@mavl
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- Xóa
CREATE PROC XOA_VL
@mavl CHAR(6),
@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM VATLIEU
			WHERE MaVL=@mavl
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
---Thêm, xóa, sửa, xuất bảng NHÀ CUNG CẤP
-----XUẤT
CREATE PROC XUAT_NCC
as
	SELECT * FROM NHACUNGCAP
GO
-----Tìm vật liệu theo tên
CREATE FUNCTION TIM_TEN_NCC(@name NVARCHAR(50)) RETURNS TABLE
AS
	RETURN(SELECT * FROM NHACUNGCAP
		WHERE TenNhaCC LIKE N'%' + @name + '%')
GO
-----Tìm khách hàng theo mã số
CREATE FUNCTION TIM_MS_NCC(@maNCC CHAR(6)) RETURNS TABLE
AS
	RETURN(SELECT * FROM NHACUNGCAP
		WHERE MaNhaCC LIKE N'%' + @maNCC + '%')
GO
-----THÊM
CREATE PROC THEM_NCC
@manhacc CHAR(6),@tennhacc nvarchar(30),@dienthoai CHAR(11),
@diachi nvarchar(30),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO NHACUNGCAP VALUES (@manhacc,@tennhacc,@dienthoai,@diachi)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
----- SỬA
go
CREATE PROC SUA_NCC
@manhacc CHAR(6),@tennhacc nvarchar(30),@dienthoai CHAR(11),
@diachi nvarchar(30),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE NHACUNGCAP
			SET TenNhaCC=@tennhacc,DienThoai=@dienthoai,DiaChi=@diachi
			WHERE MaNhaCC=@manhacc
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
----- Xóa
go
CREATE PROC XOA_NCC
@manhacc CHAR(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM NHACUNGCAP
			WHERE MaNhaCC=@manhacc
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
---Thêm, xóa, sửa, xuất bảng CONGVIEC
CREATE FUNCTION XUAT_CVIEC() RETURNS table
as
RETURN (SELECT * FROM VIEW_CVIEC)
go
-----THÊM
CREATE PROC THEM_CVIEC
@macv CHAR(6),@noidungcv nvarchar(40),@tiencong int,
@vatlieu char(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO CONGVIEC VALUES (@macv,@noidungcv,@tiencong,@vatlieu)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- SỬA
CREATE PROC SUA_CViec
@macv CHAR(6),@noidungcv nvarchar(40),@tiencong int,
@vatlieu char(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE CONGVIEC
			SET NoiDungCV=@noidungcv,TienCong=@tiencong,VatLieu=@vatlieu
			WHERE MaCViec=@macv
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
----- Xóa
CREATE PROC XOA_CViec
@macv CHAR(6),
@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM DBO.CONGVIEC
			WHERE MaCViec=@macv
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
go
---Thêm xóa sửa bảng USERS
-----Thêm
CREATE PROC THEM_USER
@Username VARCHAR(20),@Pass VARCHAR(20),@Chucvu NVARCHAR(30),@manv CHAR(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO USERS
			VALUES(@Username,@Pass,@Chucvu,@result)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Sửa
CREATE PROC SUA_USERS
@Username VARCHAR(20),@Pass VARCHAR(20),@Chucvu NVARCHAR(30),@manv CHAR(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE USERS
			SET Username=@Username, Pass=@Pass, Chucvu=@Chucvu ,MaNV = @manv
			WHERE Username=@Username
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Xác minh
CREATE FUNCTION XACMINH_USERS(@username NCHAR(20), @pass NCHAR(20),@chucvu NVARCHAR(30)) RETURNS int
AS
	BEGIN
		DECLARE @result int
		IF EXISTS(SELECT 1 FROM USERS WHERE Username=@username AND Pass = @pass AND ChucVu=@chucvu)
			BEGIN
				SELECT @result=0
				return @result
			END
		ELSE IF EXISTS(SELECT 1 FROM USERS WHERE Username=@username AND ChucVu=@chucvu)
			BEGIN
				SELECT @result=1
				return @result
			END
		SELECT @result=2
		RETURN @result
	END
GO
---Chỉnh sửa hợp đồng
-----Xuất
CREATE FUNCTION XUAT_HDONG() RETURNS table
as
RETURN (SELECT * FROM HOPDONG)
go
-----Thêm
CREATE PROC THEM_HDONG
@SoHD CHAR(15),@KH_NguoiID CHAR(6),@SoXe CHAR(10),
@NgayGiaoDuKien DATE,@result int output 
AS
		BEGIN TRY
			BEGIN TRAN
				INSERT INTO HOPDONG VALUES(@SoHD,DEFAULT,@KH_NguoiID,@SoXe,DEFAULT,@NgayGiaoDuKien,NULL)
				IF(@NgayGiaoDuKien<GETDATE())
				BEGIN 
					ROLLBACK TRAN
					set @result=0
				END
				ELSE
				BEGIN
					set @result=1
					COMMIT TRAN 
				END
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Xóa 
CREATE PROC XOA_HDONG
@SoHD CHAR(15),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE
			FROM HOPDONG
			WHERE SoHD=@SoHD
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH

GO
-----Tìm kiếm
CREATE FUNCTION TIMKIEM_HDONG(@SoHD CHAR(15)) RETURNS table
as
RETURN (SELECT *
	FROM HOPDONG
	WHERE SoHD = @SoHD)
GO
---Chỉnh sửa Chi tiết hợp đồng
-----Lấy chi tiết công việc cho xem hợp đồng
CREATE FUNCTION CONGVIEC_CHITIET_HD(@SoHD CHAR(15)) RETURNS
@congviec table(MaCV CHAR(6),TenCV NVARCHAR(40),MaTho CHAR(6),TenTho NVARCHAR(30))
AS
BEGIN
	INSERT @congviec SELECT CHITIET_HD.MaCV,CONGVIEC.NoiDungCV,CHITIET_HD.MaNV,TT_NGUOI.Hoten
	FROM CHITIET_HD, TT_NGUOI, CONGVIEC
	WHERE CHITIET_HD.MaNV=TT_NGUOI.NguoiID AND CHITIET_HD.MaCV=CONGVIEC.MaCViec AND CHITIET_HD.SoHD=@SoHD
	return
END
go
CREATE FUNCTION CONGVIEC_HD(@SoHD CHAR(15)) RETURNS
@congviec table(TenCV NVARCHAR(40),TenTho NVARCHAR(30),TriGiaCV int)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM HOPDONG WHERE SoHD= @soHD)
		BEGIN
			INSERT @congviec SELECT CONGVIEC.NoiDungCV,TT_NGUOI.Hoten,CHITIET_HD.TriGiaCV
			FROM CHITIET_HD, TT_NGUOI, CONGVIEC
			WHERE CHITIET_HD.MaNV=TT_NGUOI.NguoiID AND CHITIET_HD.MaCV=CONGVIEC.MaCViec AND CHITIET_HD.SoHD=@SoHD
		END
	ELSE
		BEGIN
			INSERT @congviec SELECT CONGVIEC.NoiDungCV,TT_NGUOI.Hoten,CHITIET_HD_BACKUP.TriGiaCV
			FROM CHITIET_HD_BACKUP, TT_NGUOI, CONGVIEC
			WHERE CHITIET_HD_BACKUP.MaNV=TT_NGUOI.NguoiID AND CHITIET_HD_BACKUP.MaCV=CONGVIEC.MaCViec AND CHITIET_HD_BACKUP.SoHD=@SoHD
		END
	return
END
go
-----Thêm
CREATE PROC THEM_CHITIET_HD
@SoHD CHAR(15),@MaCV CHAR(6),@MaNV CHAR(6),@result int output 
AS
	BEGIN TRAN 
		BEGIN TRY
			DECLARE @TriGiaCV INT
			SELECT @TriGiaCV=TienCong FROM CONGVIEC WHERE MaCViec=@MaCV
			INSERT INTO CHITIET_HD VALUES(@SoHD,@MaCV,@TriGiaCV,@MaNV)
			DECLARE @MaVL CHAR(6),@SoLuong INT
			SELECT @MAVL=VatLieu FROM CONGVIEC WHERE MaCViec=@MaCV
			SELECT @SoLuong=SoLuong FROM VATLIEU WHERE MaVL=@MaVL
			IF(@SoLuong<0)
			BEGIN
				ROLLBACK TRAN
				set @result=2
			END
			ELSE
			BEGIN
				set @result=1
				COMMIT TRAN
			END
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----XÓA 
CREATE PROC XOA_CHITIET_HD(@SoHD CHAR(15),@MaCV CHAR(6))
AS
	DELETE
	FROM CHITIET_HD
	WHERE SoHD=@SoHD AND MaCV=@MaCV
GO
---Chỉnh sửa nhập kho
-----Xuất
CREATE FUNCTION XUAT_NHAPKHO() RETURNS table
as
RETURN (SELECT * FROM VIEW_NHAPKHO)
GO
-----Tìm kiếm trong một khoảng thời gian
CREATE FUNCTION TIM_TG_NHAPKHO(@ngaydautien date,@ngaycuoicung date) RETURNS table
as
RETURN (SELECT * FROM VIEW_NHAPKHO WHERE NgayNhap >= @ngaydautien AND NgayNhap <= @ngaycuoicung)
go
-----Tìm kiếm theo vật liệu
CREATE FUNCTION TIM_VL_NHAPKHO(@tenVL NVARCHAR(20)) RETURNS table
as
RETURN (SELECT * FROM VIEW_NHAPKHO WHERE TenVL = @tenVL)
GO
-----Xuất nhập kho backup
CREATE FUNCTION XUAT_NHAPKHO_BACKUP(@ngaydautien date,@ngaycuoicung date) RETURNS
@table TABLE(MaNKho CHAR(15),MaVL CHAR(6),MaNhaCC CHAR(6),SoLuong INT,GiaTri DECIMAL,NgayNhap DATE,MaNV CHAR(6))
AS
	BEGIN
		INSERT @table SELECT *
		FROM NHAPKHO_BACKUP 
		WHERE NgayNhap>=@ngaydautien AND NgayNhap<=@ngaycuoicung
		RETURN
	END
-----Thêm
GO 
CREATE PROC THEM_NHAPKHO
@MaNKho CHAR(15),@MaVL CHAR(6),@MaNhaCC CHAR(6),
@SoLuong INT,@GiaTri DECIMAL,@MaNV CHAR(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO NHAPKHO VALUES(@MaNKho,@MaVL,@MaNhaCC,@SoLuong,@GiaTri,DEFAULT,@MaNV)
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Sửa
CREATE PROC SUA_NHAPKHO
@MaNKho CHAR(15),@MaVL CHAR(6),@MaNhaCC CHAR(6),
@SoLuong INT,@GiaTri DECIMAL,@MaNV CHAR(6),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE NHAPKHO
			SET MaVL=@MaVL,MaNhaCC=@MaNhaCC,SoLuong=@SoLuong,GiaTri=@GiaTri,MaNV=@MaNV
			WHERE MaNKho=@MaNKho
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Xóa
CREATE PROC XOA_NHAPKHO
@mankho CHAR(15),@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM NHAPKHO
			WHERE MaNKho=@mankho
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
-----Xóa nhập kho theo tháng
CREATE PROC XOA_MONTH_NHAPKHO
@ngaydautien date,@ngaycuoicung date,@result int output 
AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO NHAPKHO_BACKUP
			SELECT *
			FROM NHAPKHO
			WHERE NgayNhap>=@ngaydautien AND NgayNhap<=@ngaycuoicung 

			DELETE 
			FROM NHAPKHO
			WHERE NgayNhap>=@ngaydautien AND NgayNhap<=@ngaycuoicung
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
GO
CREATE FUNCTION TONGTIEN_NHAPKHO(@ngaydautien date,@ngaycuoicung date) RETURNS INT 
AS
	BEGIN
		DECLARE @doanhthu int
		SELECT @doanhthu=sum(GiaTri*SoLuong) FROM NHAPKHO_BACKUP WHERE NgayNhap>=@ngaydautien AND NgayNhap<=@ngaycuoicung
		return @doanhthu 
	END
GO 
------Tính tổng tiền nhập khoa của 1 tháng

---Doanh thu
-----Tính toán doanh thu 
CREATE FUNCTION DOANHTHU(@ngaydautien date,@ngaycuoicung date) RETURNS INT 
AS
	BEGIN
		DECLARE @doanhthu int
		SELECT @doanhthu=sum(TriGiaHD) FROM HOPDONG_BACKUP WHERE NgayNghiemThu>=@ngaydautien AND NgayNghiemThu<=@ngaycuoicung
		return @doanhthu 
	END
GO 
-----Tìm hợp đồng trong doanh thu
CREATE FUNCTION XUAT_HOPDONG_BACKUP(@soHD CHAR(15)) RETURNS
@table TABLE(SoHD CHAR(15),NgayHD DATE,KH_NguoiID CHAR(6),SoXE CHAR(10),TriGiaHD INT,NgayGiaoDuKien DATE, NgayNghiemThu DATE)
AS
	BEGIN
		IF EXISTS(SELECT 1 FROM HOPDONG WHERE SoHD= @soHD)
		BEGIN
			INSERT @table SELECT * FROM HOPDONG WHERE SoHD= @soHD
		END
		ELSE
		BEGIN
			INSERT @table SELECT * FROM HOPDONG_BACKUP WHERE SoHD= @soHD
		END
		RETURN
	END
go
-----Xuất doanh thu
CREATE FUNCTION XUAT_DOANHTHU(@ngaydautien date,@ngaycuoicung date) 
RETURNS 
@doanhthu table(sohd CHAR(15),ngayHD date,ngaynghiemthu date,giatriHD int)
AS
	BEGIN
		INSERT @doanhthu SELECT SoHD,NgayHD,NgayNghiemThu,TriGiaHD 
		FROM HOPDONG_BACKUP 
		WHERE NgayNghiemThu>=@ngaydautien AND NgayNghiemThu<=@ngaycuoicung
		return
	END
	go
---Xóa doanh thu 
CREATE PROC XOA_DOANHTHU
@ngaydautien date,@ngaycuoicung date
AS
BEGIN
	DELETE 
	FROM HOPDONG_BACKUP
	WHERE NgayNghiemThu>= @ngaydautien AND NgayNghiemThu<=@ngaycuoicung

	DELETE 
	FROM NHAPKHO_BACKUP 
	WHERE NgayNhap>=@ngaydautien AND NgayNhap<=@ngaycuoicung
END
go
-----Chỉnh sửa hóa đơn
---Tìm hóa đơn theo mã Hợp đồng 
CREATE FUNCTION XUAT_HOADON(@soHD CHAR(15)) RETURNS TABLE
AS
	RETURN(SELECT * FROM HOADON WHERE MaHopDong=@soHD)
	go
---Xác định số tiền phải nộp
CREATE FUNCTION TIEN_HOADON(@soHD CHAR(15)) RETURNS int
AS
	BEGIN
		DECLARE @giatriHD int, @tiendathu int
		SELECT @giatriHD=TriGiaHD FROM HOPDONG WHERE SoHD = @soHD
		SELECT @tiendathu = SUM(SoTienThu) FROM HOADON WHERE MaHopDong=@soHD
		if(@tiendathu IS NULL)
			set @tiendathu=0
		RETURN @giatriHD -@tiendathu
	END
---Thêm phiếu thu 
go
CREATE PROC THEM_HOADON 
@mahoadon CHAR(15),@mahdong CHAR(15),@hoten NVARCHAR(40),
@sotienthu INT,@result int output
AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @idkh CHAR(6),@tiendu int
			SELECT @idkh=KH_NguoiID FROM HOPDONG WHERE SoHD=@mahdong
			INSERT INTO HOADON VALUES(@mahoadon,DEFAULT,@mahdong,@idkh,@hoten,@sotienthu)
			EXEC @tiendu=TIEN_HOADON @mahdong
			if(@tiendu < 0)
			BEGIN
				set @result=2
				ROLLBACK TRAN
			END
			ELSE
			BEGIN
				set @result=1
				COMMIT TRAN
			END
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH
---Xóa phiếu thu
go
CREATE PROC XOA_HOADON
@mahoadon char(15) ,@result int output
AS
	BEGIN TRAN
		BEGIN TRY
			DELETE 
			FROM HOADON
			WHERE MaHoaDon = @mahoadon
			set @result=1
			COMMIT TRAN
		END TRY 
		BEGIN CATCH
		ROLLBACK TRAN
		set @result=0
		END CATCH