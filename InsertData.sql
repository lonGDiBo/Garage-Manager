use  QLSuaChuaXe3
go
insert into VATLIEU VALUES('VL01',N'Nhớt loại 1',10),
						('VL02',N'Nhớt loại 2',10),
						('VL03',N'Bánh xe hơi loại 1',10),
						('VL04',N'Vỏ xe máy',10)
GO
insert into CONGVIEC VALUES('V01',N'Thay nhớ loại 1',300000,'VL01'),
						('V02',N'Thay nhớ loại 2',200000,'VL02'),
						('V03',N'Thay bánh xe hơi',5000000,'VL03'),
						('V04',N'Thay vỏ bánh xe máy',500000,'VL04')
GO
insert into NHACUNGCAP VALUES('NCC01','Company A','015156166','City A'),
					('NCC05','Company B','015156166','City B'),
					('NCC02','Company C','015156166','City C'),
					('NCC03','Company D','015156166','City D'),
					('NCC04','Company E','015156166','City E')
