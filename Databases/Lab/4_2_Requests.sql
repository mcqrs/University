use Session
go

--3
select Title from Directions
go


select NumGroup from Groups
go


select FIO from Students
go


select distinct NumSt from Balls
go


select NumDir from Uplans
go

select distinct NumDir from Uplans
go


select distinct Semestr from Uplans
go


select FIO from Students where NumGroup='13504/1'
go


select NumDisc from Uplans where NumDir='230100' AND Semestr=1
go


select NumGroup, COUNT(FIO) as Quantity from Students group by NumGroup
go


select NumGroup, Count(distinct Students.NumSt) from Students
inner join Balls on Balls.NumSt = Students.NumSt
group by NumGroup
go


select NumGroup, COUNT(Students.NumSt) from Students 
inner join
(
	select NumSt, COUNT(IdDisc) as QuantityOfBalls
	from Balls 
	group by NumSt
	having COUNT(IdDisc) > 1
) as AtLeastOne on AtLeastOne.NumSt = Students.NumSt
group by NumGroup
go	


--4
select distinct FIO from Students
inner join Balls on Students.NumSt = Balls.NumSt
go


select distinct Name from Balls 
inner join Uplans on Balls.IdDisc = Uplans.IdDisc
inner join Disciplines on Disciplines.NumDisc = Uplans.NumDisc
go


select distinct Name from Uplans
inner join Disciplines on Uplans.NumDisc = Disciplines.NumDisc
where NumDir = 230100
go


select FIO from Students 
inner join
(
	select NumSt, COUNT(IdDisc) as AmountOfBalls
	from Balls 
	group by NumSt
	having COUNT(IdDisc) > 1
) as AtLeastTwo on AtLeastTwo.NumSt = Students.NumSt
go


select distinct FIO from Balls
inner join Students on Students.NumSt = Balls.NumSt
where Balls.Ball = (select MIN(Ball) from Balls)
go


select distinct FIO from Balls
inner join Students on Students.NumSt = Balls.NumSt
where Balls.Ball = (select MAX(Ball) from Balls)
go


select NumGroup from 
	(
	select NumSt, Name from 
		(
		select NumSt, NumDisc from Balls
		inner join Uplans on Uplans.IdDisc = Balls.IdDisc
		where Uplans.Semestr = 1 
		) as FirstSemestr
	inner join Disciplines on FirstSemestr.NumDisc = Disciplines.NumDisc
	where Disciplines.Name = 'Физика' 
	) as FS_Physics
inner join Students on FS_Physics.NumSt = Students.NumSt
group by NumGroup
having COUNT(NumGroup) > 1
go


select FIO from 
	(
	select numSt, Sum(MaxBall) as BallSum from 
		(
		select NumSt, Max(Balls.DateEx) as Date, Max(Ball) as MaxBall from Balls
		group by IdDisc, NumSt
		) as StudentsWithHighestScore
	group by NumSt
	) as SudentsWithSum
inner join Students on Students.NumSt = SudentsWithSum.NumSt
where BallSum > 9
go


select Semestr from 
	(
	select Semestr, count(Balls.idBall) as ExamQuantity from Uplans
	inner join Balls on Balls.IdDisc = Uplans.IdDisc
	group by Semestr
	) as ExamQuantityWithUplans
where ExamQuantity > 1
go


select FIO from Students
inner join 
	(
	select NumSt, count(distinct NumDisc) as ExamQuantity from Balls 
	inner join Uplans on Balls.IdDisc = Uplans.IdDisc
	group by NumSt
	having count(distinct NumDisc) > 1
	) as StudentWithExamQuantity on StudentWithExamQuantity.NumSt = Students.NumSt
go