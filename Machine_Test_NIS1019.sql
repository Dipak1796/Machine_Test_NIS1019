Create Table Employee_NIS1019
(
 EmployeeId Int Primary Key Identity,
 EmpName Nvarchar(30),
 Phone Nvarchar(10),
 Email Nvarchar(30)
)

Create Table Manufacturer_NIS1019
(
  MfName Nvarchar(30) Primary key,
  City Nvarchar(30),
  State Nvarchar(30)
)

Create Table Computer_NIS1019
(
  SerialNumber int primary key Identity,
  MfName Nvarchar(30)
        Constraint fk_mfg_comp
		Foreign key (MfName)
		References Manufacturer_NIS1019(MfName)
		On Delete cascade,
  Model Nvarchar(10),
  Weight Decimal(3,2),
  EmployeeId Int 
         Constraint fk_emp_comp
		 Foreign Key (EmployeeId)
		 References Employee_NIS1019(EmployeeId)
		 On Delete Cascade,
)


Insert into Employee_NIS1019 values('Prajyot','8765745687','prayjot@gmail.com'),
                           ('Pratik','8765745765','pratik@gmail.com'),
						   ('Bhushan','7689745687','bhushan@gmail.com'),
						   ('Ajinkya','9345645687','ajinkya@gmail.com')

Insert Into Manufacturer_NIS1019 Values ('Hp','Pune','Maharastra'),
                                        ('Lenovo','Gurgaon','Hariyana'),
										('Asus','Chennai','TamilNadu'),
										('MSI','Trivendrum','Kerla')

Insert Into Computer_NIS1019 values ('Hp','Elite Book',1.42,3),
                                    ('Lenovo','Think Pad',1.56,1),
									('Asus','Zen Book',1.35,2),
									('Hp','Pro Book',1.67,4)

Select * from Computer_NIS1019;
Select * from Employee_NIS1019;
Select * from Manufacturer_NIS1019;


/*
1. List the manufacturers’ names that are located in South Dakota.
*/

Select MfName From Manufacturer_NIS1019
Where City='Pune';

/*
2. Calculate the average weight of the computers in use.
*/

Select Avg(Weight) as Avg_Weight 
From Computer_NIS1019
Where EmployeeId is not null;

/*
3. List the employee names for employees whose area_code starts with 2
*/
Alter Table Employee_NIS1019 Add  area_code Nvarchar(10);
Insert Into Employee_NIS1019 Values ('Dipak','9890342343','dipak@gmail.com','287343');

Select EmpName,Area_code From Employee_NIS1019
Where Area_code Like '2%';



/*
4. List the serial numbers for computers that have a weight below average.
*/

Select SerialNumber,MfName
From Computer_NIS1019
Where Weight <(Select Avg(Weight) From Computer_NIS1019);

/*
5.  List the manufacturer names of companies that do not have any
    computers in use. Use a subquery
*/

Select MfName From Manufacturer_NIS1019
Where MfName Not In (Select MfName From Computer_NIS1019
                     Where EmployeeId is not null);

/*
6. 
*/
Create View vw_emp_comp_mfg
As
 Select e.EmpName,c.SerialNumber,m.City
 From Employee_NIS1019 e
 Join Computer_NIS1019 c
 On e.EmployeeId=c.EmployeeId
 Join Manufacturer_NIS1019 m
 On c.MfName=m.MfName;

 Select * From vw_emp_comp_mfg;

/*
7. Write a Stored Procedure to accept EmployeeId as parameter and
   List the serial number, manufacturer name, model, and weight of
   computer that belong to the specified Employeeid.
*/

Create Procedure sp_comp_details
@EmployeeId Int
As
Begin
   Select SerialNumber,MfName,Model,Weight 
   From Computer_NIS1019
   Where EmployeeId=@EmployeeId
End

Exec sp_comp_details 3;

