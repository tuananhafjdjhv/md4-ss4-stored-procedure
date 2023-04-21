create database StudentTest;
use StudentTest;
create table Test(
	testId int primary key ,
    `Name` varchar(20)
);
create table studentTest(
	RN int ,
    testId int,
   `date` date ,
   mark float,
   foreign key (RN) references Student(RN),
   foreign key (TestId) references Test(TestId)
);

create table student(
	RN int primary key,
    name varchar(255),
    age int,
    `status`  Varchar(10) 
);
insert into student values
(1,"Nguyen Hong Ha",20,"young"),
(2,"Truong Ngoc Anh",30,""),
(3,"Tuan Minh",25,""),
(4,"Dan Truong",22,"");
insert into Test values(1,"EPC"),(2,"DWMX"),(3,"SQL1"),(4,"SQL2");
insert into studentTest values
(1,1,"2006-7-17",8),
(1,2,"2006-7-18",5),
(1,3,"2006-7-19",7),
(2,1,"2006-7-17",7),
(2,2,"2006-7-18",4),
(2,3,"2006-7-19",2),
(3,1,"2006-7-17",10),
(3,3,"2006-7-18",1);
-- 2.a	Thêm ràng buộc dữ liệu cho cột age với giá trị thuộc khoảng: 15-55
ALTER TABLE Student ADD CONSTRAINT check_Age CHECK(Age > 15 AND Age < 55);
-- 2.b.	Thêm giá trị mặc định cho cột mark trong bảng StudentTest là 0
select * from studenttest;
update StudentTest set mark=0 ;
-- 2.c.	Thêm khóa chính cho bảng studenttest là (RN,TestID)
ALTER TABLE studentTest ADD PRIMARY KEY (RN, TestId);
-- 2.d.	Thêm ràng buộc duy nhất (unique) cho cột name trên bảng Test
ALTER TABLE Test ADD CONSTRAINT `name` UNIQUE (`name`);
-- 2.e.	Xóa ràng buộc duy nhất (unique) trên bảng Test
ALTER TABLE Test drop CONSTRAINT `name`;
-- 3.
select (select @stt:=@stt+1) as ` `, s.name as "Student Name",t.name as 'Test Name', st.mark as 'Mark',st.date 
from (select @stt:=0) stt, student s join studenttest st on s.RN=st.RN 
join test t on st.testId=t.testId ;
-- 4	Hiển thị danh sách các bạn học viên chưa thi môn nào như hình sau:
select * from student where rn=4;
-- 5.	Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5) 
select (select @stt:=@stt+1) as ` `, s.name as "Student Name",t.name as 'Test Name', st.mark as 'Mark',st.date 
from (select @stt:=0) stt, student s join studenttest st on s.RN=st.RN 
join test t on st.testId=t.testId where st.mark<5;
-- 6.	Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi.
--  Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần
select (select @stt:=@stt+1) as ` `, s.name as "Student Name", avg(st.mark) as 'Average'
 from (select @stt:=0) stt, student s join studenttest st on s.RN=st.RN group by s.RN order by avg(st.mark) desc;
--  7.	Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất 
select s.name as "Student Name", max(avg(st.mark)) as 'Average'
 from student s join studenttest st on s.RN=st.RN  where  max(avg(st.mark));
select Student.Name, avg(Mark) as Average from Student
 join StudentTest on Student.RN = StudentTest.RN 
 join Test on StudentTest.TestID = Test.TestID group by Student.Name 
 having avg(Mark) >= all (select avg(Mark) from StudentTest group by RN);
-- 8.	Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học 
select Test.Name, max(Mark) from Test join StudentTest on Test.TestID = StudentTest.TestID group by Test.Name order by Test.Name asc;
-- 9.	Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi
--  nếu học viên chưa thi môn nào thì phần tên môn học để Null 
select Student.Name, Test.Name
 from Student left join StudentTest on Student.RN = StudentTest.RN 
 left join Test on StudentTest.TestID = Test.TestID;
-- 10.	Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi. 
update Student set Age = Age + 1;
-- 11.	Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.
alter table Student
add column `Status` varchar(10);
-- 12.	Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, 
-- trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student lên
-- update Student set `Status` = 
-- case
--  	when Age < 30 then "young"
-- 	when Age >= 30 then "old"
--  end;
 update Student set `Status` = if(age<30,"young",'old');
 select * from Student;
--  13.	Hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi 
select (select @stt:=@stt+1) as ` `, s.name as "Student Name",t.name as 'Test Name', st.mark as 'Mark',st.date 
from (select @stt:=0) stt, student s join studenttest st on s.RN=st.RN 
join test t on st.testId=t.testId order by st.date asc;
-- 14.	 Hiển thị các thông tin sinh viên có tên bắt đầu bằng ký tự ‘T’ và điểm thi trung bình >4.5.
--  Thông tin bao gồm Tên sinh viên, tuổi, điểm trung bình
select s.`name`, avg(st.Mark), s.age
 from Student s join StudentTest st on s.RN = st.RN  group by s.RN
 having avg(st.Mark) > 4.5 and s.`name` like 't%';
 -- 15.	Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng). 
-- Trong đó, xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1.
select s.RN as 'Ma', s.`name` as 'Ten',s.age as 'tuoi', avg(st.Mark) as 'diem trung binh', rank()
 over(order by avg(st.Mark) desc) as 'Xep Hang' from Student s
join studenttest st on s.RN = st.RN group by s.RN order by avg(st.Mark) desc;
-- 16.	Sủa đổi kiểu dữ liệu cột name trong bảng student thành nvarchar(max)
alter table student modify `name` varchar(255);
-- 17.	Cập nhật (sử dụng phương thức write) cột name trong bảng student với yêu cầu sau:
-- a.	Nếu tuổi >20 -> thêm ‘Old’ vào trước tên (cột name)
-- b.	Nếu tuổi <=20 thì thêm ‘Young’ vào trước tên (cột name)
update student set `name` = if(age>20,concat("Old ",`name`),concat("Young ",`name`)) ;
select * from studenttest;
-- 18.	 Xóa tất cả các môn học chưa có bất kỳ sinh viên nào thi
delete from Test where testId not in (select TestID from studenttest);
-- 19.	Xóa thông tin điểm thi của sinh viên có điểm <5. 
delete from Studenttest where Mark < 5;
