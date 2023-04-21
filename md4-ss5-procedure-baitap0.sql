create database product;
create table products (
	Id int primary key auto_increment,
	productCode int ,
	productName varchar(255),
	productPrice float,
	productAmount int,
	productDescription varchar(255),
	productStatus bit default(0)
);
insert into products(productCode, productName, productPrice, productAmount, productDescription) 
values 
(1, "Iphone X", 200, 5, "hàng mới về"), 
(2, "Iphone 11", 300, 6, "bị vỡ màn"), 
(3, "Iphone 7", 100, 7, "hỏng pin"), 
(4, "samsung s1", 250, 8, "ko có dây sạc");
select * from products;
use product;
-- •	Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
-- •	Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
-- •	Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
-- •	So sánh câu truy vấn trước và sau khi tạo index

alter table products add index idx_ProductCode(productCode);
alter table products add index idx_NameAndPrice(productName, productPrice);
 select * from products where productCode = 2;
 
--  •	Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
-- •	Tiến hành sửa đổi view
-- •	Tiến hành xoá view
create view productView as select productCode, productName, productPrice, productStatus from products;
select * from productView;
create or replace view productView as  select productCode, productName, productPrice, productStatus from products where productCode in (2,4);
drop view productView;
-- •	Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure Pro_getProduct()
begin
select * from products;
end 
//delimiter ;
call Pro_getProduct();
-- •	Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure Pro_CreateNewProduct(
id int ,
productCode varchar(255),
productName varchar(255), 
productPrice float ,
productAmount int ,
productDescription varchar(255) ,
productStatus bit(1))
begin
insert into products values(id,productCode,productName,productPrice,productAmount,productDescription,productStatus);
end 
//delimiter ;
call Pro_CreateNewProduct(5,"5","samsung s22",500,9,"đẹp long lanh",0);
call Pro_CreateNewProduct(6,"6","iphone s22",500,10,"hơi đẹp long lanh",0);

-- •	Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure Pro_UpdateProduct(
newId int ,
newProductCode int,
newProductName varchar(255), 
newProductPrice float ,
newProductAmount int ,
newProductDescription varchar(255),
newProductStatus bit(1))
begin
update products
set productCode = newProductCode,
productName=newProductName,
productPrice = newProductPrice,
productAmount = newProductAmount,
productDescription=newProductDescription,
productStatus = newProductStatus where id = newId;
end 
//delimiter ;
call Pro_UpdateProduct(1,"3","iphone 9",500,9,"đẹp nhu moi",0);
select * from products;
-- •	Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure Pro_deleteProduct(idDel int)
begin
	delete from products
    where id=idDel;
end 
//delimiter ;
call Pro_deleteProduct(14)