/*
Group members:Cai, Xiaoman; Yu, Jiajie; Zhang, Yuteng
*/
--Problem 1.1
select distinct name
from student natural join takes natural join course
where course.dept_name = 'Comp. Sci.';
--Problem 1.2
select id, name from student where id not in (select id from takes where year<2009);
--Problem 1.3
select name,dept_name,salary from instructor where salary in (
select max(salary) from instructor group by dept_name);
--Problem 1.4
select name,dept_name,salary from instructor where salary in(
select min(salary) from instructor where salary in 
(select max(salary)as salary from instructor group by dept_name));
--Problem 1.5
insert into course values('CS-001','Weekly Seminar','Comp. Sci.',0);
--Problem 1.6
insert into section
values ('CS-001', 1, 'Fall', 2009);
--Problem 1.7
insert into takes
select id, 'CS-001', '1', 'Fall', 2009
from student
where dept_name = 'Comp. Sci.';
--Problem 1.8
delete from takes
where course_id = 'CS-001' and sec_id = '1' and semester = 'Fall' and year = 2009
and id in (select id
			from student
			where name = 'Chavez');
--Problem 1.9			
delete from course
where course_id = 'CS-001';
/*If we try to delete the 'CS-001' from 'course' directly, usually
there should be a foreign key violation because 
'section' and 'takes' also this tuple, which the foreign key of 
'takes' reference to 'section' and 'section' reference to the 'course'. 
so we need to delete the tuple in the order of 'takes','section' and 'course'.
However, in this case, the foreign key of these 3 tables 
above have 'on delete cascade' constraints while creating, which we could 
directly delete "CS-001" from 'course' table without error.*/
--Problem 1.10
delete from takes
where course_id in(select course_id
				   from course
				   where lower(title) like '%database%');
--Problem 1.11a				   
select ID,
	case
		when score < 40 then 'F'
		when score < 60 then 'C'
		when score < 80 then 'B'
		else 'A'
	end
from marks;
--Problem 1.11b	
with all_grades as(select ID,
				case
					when score < 40 then 'F'
					when score < 60 then 'C'
					when score < 80 then 'B'
					else 'A'
				end 
			   as std_grade
			from marks)
select std_grade, count(ID)
from all_grades
group by std_grade;
--Problem 1.12
select dept_name
from department
where lower(dept_name) like '%sci%';
