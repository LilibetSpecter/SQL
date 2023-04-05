-- 20230404 Joins and Subqueries Execises
--
-- https://pgexercises.com/questions/joins/
-----------------------------------------------------------------------------
--
Select * from cd.members
Select * from cd.bookings
Select* from cd.facilities
-- Question-6
-- How can you produce a list of bookings on the day of 2012-09-14
-- which will cost the member (or guest) more than $30?
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'),
-- and the guest user is always ID 0. Include in your output the name of the facility,
-- the name of the member formatted as a single column, and the cost.
-- Order by descending cost, and do not use any subqueries.
select
	from
	where
	
	
	
	
order by
-- Question-8
-- The Produce a list of costly bookings exercise contained some messy logic:
-- we had to calculate the booking cost in both the WHERE clause and
-- the CASE statement. Try to simplify this calculation using subqueries.
-- For reference, the question was:
select
	from
		
		(select
			
		
		
		
		 		from
		
		
		
		 		where
		
		
		 )
	where
order by
	
-- Question-7
-- How can you output a list of all members, including the individual
-- who recommended them (if any), without using any joins?
-- Ensure that there are no duplicates in the list, and
-- that each firstname + surname pairing is formatted as a column and ordered.
select
	(select
		from
		where
	)
	from
	where
	
	
order by
