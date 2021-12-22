Create database QLKH
On Primary
(
Name = QLKH_data,
FileName = 'c:\TH HQTCSDL\QLKH.mdf',
Size = 10MB,
MaxSize = 50 MB, 
FileGrowth = 2MB
)
Log On
(
Name = QLKH_log,
FileName = 'c:\TH HQTCSDL\QLKH_log.ldf',
Size = 5MB,
MaxSize = 20 MB, 
FileGrowth = 1MB
)


use QLKH
go
Create table KhachHang(
IDKhachHang int not null identity(1,1),
HoTen nvarchar(50) not null,
GioiTinh nvarchar(3) not null,
DiaChi nvarchar(50),
Email nvarchar(30)not null,
SoDienThoai nvarchar(15),
Primary key(IDKhachHang)
);

-- Thiết lập ràng buộc UNIQUE cho trường Email.
Alter table KhachHang
Add Unique(Email);

--Thiết lập ràng buộc CHECK cho trường GioiTinh sao cho GioiTinh chỉ có thể nhận giá trị ‘Nam’ hoặc ‘Nữ’
Alter table KhachHang
Add Check(GioiTinh = N'Nam' or GioiTinh = N'Nữ'); 

-- Thiết lập ràng buộc bắt buộc khi nhập địa chỉ email phải có dấu @

Alter table KhachHang
Add check (Email like ('%@%'));

Insert into KhachHang
values(N'Nguyễn Tuyết Nhung', N'Nữ', N'Phú Thọ', 'tuyetnhung@gmail.com', '0375556173'),
(N'Nguyễn Văn A', N'Nam', N'Hà Nội', 'Nhung@gmail.com', '0382184747'),
(N'Nguyễn Thị Tuyết Nhung', N'Nữ', N'Hà Nội', 'thinhung@gmail.com', '0375556484'),
(N'Đỗ Trung Kiên', N'Nam', N'Hà Nam', 'trungkien@gmail.com', '0384545612'),
(N'Nguyễn Văn B', N'Nam', N'Bắc Ninh', 'tungphong@gmail.com', '0212368686');



-- i. Thêm bảng SanPham
Create table SanPham(
IDSanPham int not null identity(1,1),
TenSP nvarchar(50) not null,
MoTa nvarchar(100),
DonGia float not null,
Primary key(IDSanPham)
);
-- Thiết lập ràng buộc UNIQUE cho trường TenSP.
Alter table SanPham
Add Unique(TenSP);
-- Thiết lập khóa chính cho bảng là trường IDSanPham bằng lệnh ALTER TABLE.


Insert into SanPham 
values(N'Áo', N'Đây là áo', '120000'),
(N'Váy', N'Đây là váy', '500000'),
(N'Áo khoác', N'Đây là áo khoác', '300000'),
(N'Mũ', N'Đây là mũ', '200000'),
(N'Giày', N'Đây là giày', '1000000');



-- j. Thêm bảng DonHang
Create table DonHang(
IDDonHang int not null identity(1,1),
IDKhachHang int not null,
NgayDatHang date not null,
TongTien float,
Primary key(IDDonHang)
);


--Thiết lập khóa phụ cho IDKhachHang tham chiếu đến IDKhachHang của bảng KhachHang bằng lệnh ALTER TABLE.
alter table DonHang 
add foreign key (IDKhachHang) references KhachHang(IDKhachHang);


Insert into DonHang (IDKhachHang, NgayDatHang)
values('2', '02/12/2021'),
('1', '01/12/2020'),
('1', '11/11/2021'),
('2', '10/10/2020'),
('3', '02/1/2020');



--Thêm bảng SP_DonHang(IDDonHang, IDSanPham, SoLuong, ThanhTien)
create table SP_DonHang
(
idDonHang int foreign key (idDonHang) references DonHang(idDonHang),
idSanPham int foreign key (idSanPham) references SanPham(idSanPham),
SoLuong int default 1,
ThanhTien float,
primary key (idDonHang,idSanPham)
)

insert into SP_DonHang values 
(1,1,5,0),
(1,2,2,0),
(1,3,4,0),
(1,4,10,0),
(2,2,7,0),
(2,3,8,0),
(4,1,9,0),
(4,5,13,0),
(3,4,6,0),
(5,1,9,0);

