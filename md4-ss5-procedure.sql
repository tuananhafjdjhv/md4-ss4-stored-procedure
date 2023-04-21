create database Test2;
use Test2;
create table Mark(
	Mark int ,
    SubjectID int,
    StudentID int,
    foreign key (SubjectID) references Subjects(SubjectID),
    foreign key (StudentID) references Students(StudentID)
);

create table Subjects(
	SubjectID int primary key,
    SubjectName varchar(255)
);
create table Students (
	StudentId int primary key,
    StudentName varchar(255),
    age int,
    email varchar(255)
);
create table Classes (
	ClassId int primary key,
    ClassName varchar(255)
);
create table ClassStudent (
	ClassId int ,
    StudentId int ,
    foreign key (StudentId) references Students(StudentId) ,
    foreign key (ClassId) references Classes(ClassId) 
);
insert into students values
(1,"Nguyen Quang An",18,"an@yahoo.com"),
(2,"Nguyen Cong Vinh",17,"vinh@gmail.com"),
(3,"Nguyen Van Quyen",28,"quyen"),
(4,"Pham Thanh Binh",31,"binh@com"),
(5,"Nguyen Van Tai Em",19,"taiem@sport.vn");
select * from Subjects;
insert into classes values(1,"C0706L"),(2,"C0708G");
insert into ClassStudent values(1,1),(1,2),(2,3),(2,4),(2,5);
insert into Subjects values(1,"SQL"),(2,"Java"),(3,"C"),(4,"Visua Basic");
insert into Mark values(8,1,1),(4,2,1),(9,1,1),(7,1,3),(3,1,4),(5,2,5),(8,3,3),(1,3,5),(3,2,4);

-- 1.	Hien thi danh sach tat ca cac hoc vien 
select * from students;
-- 2.	Hien thi danh sach tat ca cac mon hoc
select * from subjects;
-- 3.	Tinh diem trung binh 
select s.studentName,avg(mark) as 'diem trung binh' from students s join mark m on m.StudentID=s.StudentID group by s.StudentID;
-- 4.	Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select * from subjects s join mark m on s.subjectId=m.subjectId where m.mark = (select max(mark) from mark);
-- 5.	Danh so thu tu cua diem theo chieu giam
select (select @stt:=@stt+1) as `stt`,m.* from (select @stt:=0) r , mark m order by m.mark desc;
-- 6.	Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table Subjects MODIFY SubjectName nvarchar(255);
-- 7.	Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update Subjects set SubjectName = concat("Đây là môn học ",subjectName);
-- 8.	Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE Students ADD CONSTRAINT check_Age CHECK(Age > 15 AND Age < 50);
insert into Students values(6,"nguyen minh quan",40,"quan@gmail.com");
-- 9.	Loai bo tat ca quan he giua cac bang
alter table mark drop foreign key mark_ibfk_1;
alter table mark drop foreign key mark_ibfk_2;
alter table classStudent drop foreign key classstudent_ibfk_1;
alter table classStudent drop foreign key classstudent_ibfk_2;
-- 10.	Xoa hoc vien co StudentID la 1
DELETE FROM students WHERE StudentID = 1;
-- 11.	Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students add `Status` bit default 1;
select*from students;
-- 12.	Cap nhap gia tri Status trong bang Student thanh 0
update students set `status`= 0;


