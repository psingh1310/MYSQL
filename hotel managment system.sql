===========================DAY-2===========================================
creating table:-

create table Billing
(
BillingId varchar(20) not null,
PaymentMode enum('cash','card'), 
TotalCost float(20) not null,
primary key (BillingId)
);

create table Management
(
EmployeeId varchar(20) not null ,
Firstname varchar(30) not null,
Lastname varchar(30) not null,
Gender enum('male','female'),
Salary float(20) not null,
Designation varchar(20) not null,
primary key(EmployeeId)
);

create table Services
(
ServiceId varchar(20) not null,
ServiceType varchar(20) not null,
EmployeeId varchar(20) not null,
primary key(ServiceId)
);

create table Room
(
RoomNo int(20) not null,
RoomType enum('single','double'),
Cost float(20) not null,
ServiceId varchar(20) not null,
primary key(RoomNo)
);

create table Booking
(
BookingId varchar(20) not null,
CheckinDate date not null,
CheckoutDate date not null,
BookingType enum('online','offline'),
RoomNo int(20) not null,
BillingId varchar(20) not null,
primary key(BookingId)
);

create table Address 
(
ZipCode varchar(10) not null,
City varchar(20) not null,
primary key(ZipCode)
);

create table Customer
(
CustomerId varchar(20) not null,
Firstname varchar(20) not null,
Lastname varchar(20) not null,
Contact varchar(50) not null,
Gender enum('male','female'),
IdProof varchar(20) not null,
BookingId varchar(20) not null,
ZipCode varchar(10) not null,
LuggageCount int(10) null,
primary key(CustomerId) 
);

---------------------------------
genreating foriegn key:-

alter table Customer add constraint fk_bookingid foreign key(BookingId) references Booking(BookingId);

alter table Customer add constraint fk_zipcode foreign key(ZipCode) references address(ZipCode);

alter table Booking add constraint fk_roomno foreign key(RoomNo) references room(RoomNo);

alter table Booking add constraint fk_billingid foreign key(BillingId) references Billing(BillingId);

alter table room add constraint fk_serviceid foreign key(ServiceId) references Services(ServiceId);

alter table services add constraint fk_employeeid foreign key(EmployeeId) references management(EmployeeId);
--------------------------------------------------------
inserting values into table:-
insert into address values('560100','bangalore');
insert into address values('275101','chennai');
insert into address values('560069','mumbai');

insert into billing values('B001','cash',10000.0);
insert into billing values('B002','card',12000.0);
insert into billing values('B003','cash',13000.5);
insert into billing values('B004','cash',16000.0);
insert into billing values('B005','card',14000.0);

insert into management values('E001','viresh','singh','male',10000.0,'manager');
insert into management values('E002','anirudh','thakur','male',20000.0,'chef');
insert into management values('E003','prashant','singh','male',15000.0,'reception');
insert into management values('E004','santoshi','teknur','female',12000.0,'housekeeping');

insert into services values('S001','food','E002');
insert into services values('S002','laundary','E004');
insert into services values('S003','cleaning','E004');
insert into services values('S004','maintainance','E001');
insert into services values('S005','bill','E003');

insert into room values(101,'single',5000.0,'S001');
insert into room values(102,'single',5000.0,'S002');
insert into room values(103,'double',10000.0,'S002');
insert into room values(104,'single',5000.0,'S004');
insert into room values(105,'double',10000.0,'S005');
insert into room values(106,'single',5000.0,'S002');
insert into room values(107,'single',5000.0,'S003');
insert into room values(108,'double',10000.0,'S003');

insert into Booking values('BO001','2019/10/25','2019/10/26','online',104,'B001');
insert into Booking values('BO002','2019/05/13','2019/05/15','online',102,'B002');
insert into Booking values('BO003','2019/07/21','2019/07/24','offline',103,'B003');
insert into Booking values('BO004','2019/07/8','2019/07/10','online',104,'B004');
insert into Booking values('BO005','2019/08/25','2019/08/29','online',101,'B005');

insert into Customer values('C001','Rajesh','Bhatia','9342313132','male','DL12345','BO001','560100',2);
insert into Customer values('C002','Aishwarya','khan','9454544132','female','UID12345','BO002','275101',1);
insert into Customer values('C003','Paresh','Rawal','9341223132','male','DL98765','BO003','560069',3);
insert into Customer values('C004','Deepika','Kaif','9356563132','female','UID98765','BO004','560100',2);
insert into Customer values('C005','Amir','oberoi','9342088132','Male','DL54454','BO005','560069',1);

===============================================DAY 3===========================================
create table newbooking as select * from booking ;
drop table newbooking;
create table newbooking as select * from booking ;
truncate table newbooking;

create table newbooking as select * from booking ;
alter table newbooking add column extracl varchar(10);
alter table newbooking add column extrac2 varchar(10) after BookingType;
alter table newbooking drop column extrac2 varchar(10);

set autocommit = 0;
update newbooking set BookingType='online' where BookingId = 'BO003';
rollback;

create table newcustomer as select * from customer;
select CustomerId,Firstname,gender from newcustomer;
select CustomerId as ID, Firstname as name from newcustomer;
select * from newcustomer where Gender = 'male';

create table newbilling as select * from billing;
select * from newbilling where TotalCost > 13000.0;
 
select * from newcustomer where Firstname like 'A%';

select * from newcustomer where Firstname like '____';
select * from newcustomer where CustomerId = 'C001' or CustomerId = 'C002'; 
select * from newbooking where BookingId = 'BO001' and year(CheckinDate) = 2019; 
select * from newbooking where year(CheckinDate) = 2019; 
select * from newbooking where BookingId NOT IN ('BO001'); 
select * from newbooking where BookingId != 'BO001';

select * from newcustomer order by Firstname;
select * from newcustomer order by Firstname desc;

select count(CustomerId) from newcustomer; //no of employee
select count(CustomerId) as id from newcustomer where Gender = 'male'; //no of male emp

select BillingId , max(TotalCost) from newbilling;

 
select BillingId, TotalCost from newbilling where TotalCost = (select max(TotalCost) from newbilling);

select abs(25);
select abs(-25);
select mod(10,2);
select mod(10,3);

select concat('dear',' ',Firstname) from newcustomer;

select ucase(Firstname) from newcustomer;
select Gender,count(Gender) from newcustomer group by Gender;
select totalcost+100 from newbilling ;
select count(totalcost) from newbilling where totalcost>12000;
select firstname,roomno from newcustomer join newbooking on newcustomer.bookingid = newbooking.bookingid;
select firstname,roomno from newcustomer right join newbooking on newcustomer.bookingid = newbooking.bookingid;
select firstname,city from newcustomer right join address on newcustomer.zipcode = address.zipcode;
select firstname,city from newcustomer left join address on newcustomer.zipcode = address.zipcode;
select employeeid from services union select employeeid from management;
select employeeid from services union all select employeeid from management;
select employeeid from services where employeeid  not in(select employeeid from management);

=====================================DAY 4==================================================

create view vcustomer as select firstname,contact from customer;
show full tables;
update vcustomer set contact='1234567890' where firstname = 'amir';
select firstname,contact from customer limit 2;
select distinct(Gender) from customer;


##### FUNCTIONS AND PROCEDURES


set global log_bin_trust_function_creators=1;

delimiter @
create function countcst1(ctcs varchar(20))
returns int
begin
return(select count(firstname) from newcustomer where firstname = ctcs);
end @
delimiter ;

> select countcst1('rani');

delimiter $
create function countcust(ct varchar(20))
returns int 
begin
declare countcity varchar(20);
select count(*) from newcustomer where zipcode = ct into countcity;
return countcity;
end $
delimiter ;

> select countcust('560069');

delimiter @
create function chkbk(typ varchar(20) , yr int(10))
returns int
begin
return(select count(*) from newbooking where bookingtype=typ and year(checkindate)=yr);
end @
delimiter ;

> select chkbk('online',2019);

delimiter @
create function showbooking(yr int(10))
returns varchar(40)
begin 
declare bk varchar(40);
if(yr=2019) then set bk = 'latest booking';
elseif(yr=2018) then set bk = 'last year booking';
elseif(yr<2018) then set bk = 'old booking';
end if;
return(bk);
end @
delimiter ;

> select year(checkindate),showbooking(year(checkindate)) from newbooking;
>select showbooking(2018);

delimiter @
create function showpayband(sal float(20))
returns varchar(40)
begin 
declare bk varchar(40);
if(sal > 14000.0) then set bk = 'pay scale 8';
else set bk = 'pay scale 6';
end if;
return(bk);
end @
delimiter ;

> select salary,showpayband(salary) from management;

delimiter @
create procedure getaddress()
begin
select * from address;
end @
delimiter ;

>call getaddress;

delimiter @
create procedure getcustroom(in nm varchar(40))
begin
select firstname,roomno from customer,booking where
customer.bookingid=booking.bookingid and customer.firstname = nm;
end @
delimiter ;

> call getcustroom('rajesh');

delimiter @
create procedure getcustroom1(in rm int(10))
begin
select firstname,roomno from customer,booking where
customer.bookingid=booking.bookingid and booking.roomno = rm;
end @
delimiter ;
 >call getcustroom1(104);


delimiter @
create procedure countstatus(in sts varchar(20),out ctn int(10))
begin
select count(bookingtype) from booking where
bookingtype = sts into ctn;
end @
delimiter ;

> call countstatus('online',@ctn);
> select @ctn;

delimiter $
create procedure showbooking(in bid varchar(20),out sts varchar(40))
begin
declare yr int(10);
select year(checkindate) into yr from booking where bookingid = bid;
select showbooking(yr) into sts;
end $

delimiter ; 

>call showbooking('BO001',@sts);
>select @sts;

delimiter @
create procedure getsts(in mbid varchar(20),out sts varchar(20))
begin
declare yr int(10);
select year(checkindate) into yr from newbooking where bookingid = mbid;
case 
when yr=2019 then set sts='latest booking';
when yr=2018 then set sts='old booking';
when yr<2018 then set sts='ancient booking';
end case;
end @
delimiter ;

>call getsts('BO002',@sts);
>select @sts;

=============================================DAY 5===============================================

create index idx_firstname on newcustomer(firstname);
drop index idx_firstname on newcustomer;

delimiter @
create trigger trg1 before insert on chktg 
for each row
begin
if new.nmbr < 1 then set new.nmbr=1;
elseif new.nmbr>100 then set new.nmbr=100;
end if;
end @
delimiter ;

>insert into chktg values(23);
>insert into chktg values(-4);
>insert into chktg values(234);
>select * from chktg;

create table mangebackup(
employeeid varchar(20);
firstname varchar(20);
lastname varchar(20);
designation varchar(20)
);
 
delimiter @
create trigger bkup before update on newmanagement 
for each row
begin
insert into empbackup values(old.employeeid,old.firstname,old.lastname,old.designation,now());
end @
delimiter ;

>update newmangement set firstname = 'jamin' where employeeid = 'E001'; 
>select * from empbackup;

select trigger_name,event_object_table from information_schema.triggers where information_schema.triggers.trigger_schema like '%hms%';


delimiter /
create procedure chkyr(in yr int(10))
begin
if yr < 1900 then
signal sqlstate '45000'
set message_text = 'sorry year cannot be less than 1900';
end if;
if yr > 2019 then 
signal sqlstate '45001'
set message_text = 'year cannot be exit';
end if;
end /
delimiter ;

delimiter /
create trigger trgchkyr before insert on newbooking 
for each row
begin
call chkyr(year(new.checkindate));
end /
delimiter ;     

> insert into newbooking values('BO006','1800/05/10','1800/05/11','online',101,'B006', '');
> insert into newbooking values('BO006','2020/05/10','1800/05/11','online',101,'B006', '');

delimiter /
create trigger trgchkyr1 before update on newbooking 
for each row
begin
call chkyr(year(new.checkindate));
end /
delimiter ;   

>update newbooking set checkindate = '2020/12/14' where booking = 'BO006';\


create table allcustomer(
firstname varchar(30));

delimiter /
create trigger trgaddcust after insert on newcustomer 
for each row
begin
insert into allcustomer values(new.firstname);
end /
delimiter ;   

> select * from newcustomer;

> insert into newcustomer values('C008','disha','patni','7087065472','female','DL2544','BO009','56000',2); 

> select * from allcustomer;


////////////////////////////////////////////////day 6////////////////////////////////////////////////


delimiter /
create procedure chkwhile()
begin
declare a int;
declare name varchar(50);
set name='';
set a=1;
while(a<=10) do
set name=concat(name,',',a);
set a=a+1;
end while;
select name;
end /
delimiter ;

>call chkwhile;

delimiter /
create procedure chkwhile2()
begin
declare a int;
declare name varchar(1000);
set name='';
set a=50;
while(a>=1) do
set name=concat(name,',',a);
set a=a-1;
end while;
select name;
end /
delimiter ;

>call chkwhile2;


delimiter /
create procedure chkLOOP2()
begin
declare a int;
declare name varchar(200);
set name='';
set a=1;
printNum : LOOP
	if a=50 then
		LEAVE printNum;
	end if;
	
	set a=a+1;
if((a mod 2)=0) then
	ITERATE printNum;
	else
	set name=concat(name,a,',');
end if;
end LOOP;	

select name;
end /
delimiter ;

delimiter /
create procedure chkLOOP3()
begin
declare a int;
declare name varchar(200);
set name='';
set a=1;
printNum : LOOP
	if a=50 then
		LEAVE printNum;
	end if;
	
	set a=a+1;
if((a mod 2) then
	ITERATE printNum;
	else
	set name=concat(name,a,',');
end if;
end LOOP;	

select name;
end /
delimiter ;

delimiter /
create procedure chkwhile3()
begin
declare a int;
declare name varchar(1000);
set name='';
set a=1;
repeat
set name=concat(name,',',a);
set a=a+1;
until a=10
end repeat;
select name;
end /
delimiter ;

delimiter @
create procedure getcustomername(inout custlist varchar(1000))
begin
declare cname varchar(100) default '';
declare complt integer default 0;
declare custname_cursor CURSOR FOR select firstname from newcustomer;
DECLARE CONTINUE HANDLER
FOR NOT FOUND set complt = 1;
OPEN custname_cursor ;
get_custname:loop
FETCH custname_cursor into cname;
if complt = 1 then 
leave get_custname;
end if;
set custlist=concat(custlist,'|',cname);
end loop get_custname;
close custname_cursor;
end @
delimiter;

>set @custlist = '';
>call getcustomername(@custlist);
>select @custlist;















