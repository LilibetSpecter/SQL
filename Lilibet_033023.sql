--Question1
--How can you produce a list of the start times for bookings by members named 'David Farrell'?

Select * from cd.members
Select * from cd.bookings
Select* from cd.facilities

--1
Select memid from cd.members where firstname='David' and surname='Farrell'
Select starttime from cd.bookings where memid='28'

--2
Select starttime from cd.bookings where memid=(Select memid from cd.members where firstname='David' and surname='Farrell')

--PGEX SOLUTION1
select bks.starttime 
	from 
		cd.bookings bks
		inner join cd.members mems
			on mems.memid = bks.memid
	where 
		mems.firstname='David' 
		and mems.surname='Farrell'; 

--PGEX SOLUTION2
select bks.starttime
    from
          cd.bookings bks,
          cd.members mems
    where
          mems.firstname='David'
          and mems.surname='Farrell'
          and mems.memid = bks.memid;
		  



--Question2
--How can you produce a list of the start times for bookings for tennis courts, 
--for the date '2012-09-21'? 
--Return a list of start time and facility name pairings, ordered by the time.


Select cd.bookings.starttime, cd.facilities.name from cd.bookings, cd.facilities
where cd.bookings.facid=cd.facilities.facid 
and cd.facilities.name in ('Tennis Court 1', 'Tennis Court 2')
and cd.bookings.starttime>='2012-09-21' and cd.bookings.starttime<'2012-09-22' 

order by cd.bookings.starttime

--'2012-09-21' tarihi saatlerle verildigi icin tabloda, '2012-09-21' tarihinden buyuk esit olanlari alirsam gece 00'da baslar, 
--'2012-09-22' tarihten kucuk dersem de, '2012-09-21' tarihinin 23:59'una kadar olan tum saatleri alir.

--"Tennis Court" istedigi zaman benden, 'Tennis Court 1' ve 'Tennis Court 2' seklinde 2 tane Tennis Court oldugu icin 
-- in ('Tennis Court 1', 'Tennis Court 2') seklinde yazarim.

--From ile table ismi yazarak table sectigimde, virgul ile yanina o tabloya kisaltma atayip, onu kullanabilirim.

Select BKS.starttime, FCL.name 
			from cd.bookings BKS, cd.facilities FCL
			
			WHERE BKS.facid=FCL.facid and
				  FCL.name in('Tennis Court 2','Tennis Court 1') and
				  BKS.starttime >= '2012-09-21' and
				  BKS.starttime < '2012-09-22'
order by BKS.starttime			  

--Ben iki tabloyu iliskilendirmek icin, where cd.bookings.facid=cd.facilities.facid kullandim, 
--ama daha cok inner join ile iliskilendiriliyor. Bundan sonra inner join kullanilacak.
				  
--PGEX SOLUTION
select bks.starttime as start, facs.name as name
	from 
		cd.facilities facs
		inner join cd.bookings bks
			on facs.facid = bks.facid
	where 
		facs.name in ('Tennis Court 2','Tennis Court 1') and
		bks.starttime >= '2012-09-21' and
		bks.starttime < '2012-09-22'
order by bks.starttime; 

--inner join yapinca iki tabloyu eslestirmis oluyorum. INNER JOIN---- ON. (on the condition that anlaminda)
--Yani hangi sart uzerinden iliskilendiriyorsam ON'dan sonra onu yaziyorum. 
--Yukaridaki ornekte, on facs.facid = bks.facid demekle, facs table'daki facid ile, bks table'daki facid'in esit olmasi halinde,
--facs table ile bks table'i birlestirerek bana datalari getir demis oldum.
				  
--Question3
--How can you output a list of all members who have recommended another member? 
--Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

select distinct recs.firstname as firstname, recs.surname as surname
	from 
		cd.members mems
		inner join cd.members recs
			on recs.memid = mems.recommendedby
order by surname, firstname;   

--you can join a table to itself! 
--This is really useful if you have columns that reference data in the same table, like we do with recommendedby in cd.members.
--burda mems tablosunun aynisindan bir tablo daha olusturdugumuzu adina da recs dedigimizi varsayalim.hepsindeki data ayni
--bu iki ayni tabloyu birbiri ile inner join ile iliskilendiriyorum yine.
--ON (the condition that:) memid ile recommendedby'in ayni olmasi kosulu ile
	
--Question4
--How can you output a list of all members, including the individual who recommended them (if any)? 
--Ensure that results are ordered by (surname, firstname).

select mems.firstname as memfname, mems.surname as memsname, recs.firstname as recfname, recs.surname as recsname
	from 
		cd.members mems
		left outer join cd.members recs
			on recs.memid = mems.recommendedby
order by memsname, memfname; 

--Inner joins take a left and a right table, and look for matching rows based on a join condition (ON). 
--When the condition is satisfied, a joined row is produced. 
--A LEFT OUTER JOIN operates similarly, except that if a given row on the left hand table doesn't match anything, 
--it still produces an output row. 
--That output row consists of the left hand table row, and a bunch of NULLS in place of the right hand table row.

--Burda da, 3.sorudaki ile ayni mantikla yapiyorum. tek farki, kimse tarafindan onerilmemis memberlari da getirsin istiyor. 
--Yani recommended by sutununda null olsa bile getirsin istiyor.bu tarz durumlarda LEFT OUTER JOIN kullaniyormusum, 
--INNER JOIN'den farki da buymus.

--Question5

--How can you produce a list of all members who have used a tennis court? Include in your output the name of the court,
--and the name of the member formatted as a single column. 
--Ensure no duplicate data, 
--and order by the member name followed by the facility name.


select distinct MEMS.firstname || ' ' || MEMS.surname as member, FCL.name as facility

	from 
		cd.members MEMS
		inner join cd.bookings BKS
			on MEMS.memid = BKS.memid
		inner join cd.facilities FCL
			on BKS.facid = FCL.facid
	where
		FCL.name in ('Tennis Court 2','Tennis Court 1')
order by member, facility   



