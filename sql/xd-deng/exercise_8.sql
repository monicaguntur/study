-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
select name from physician where employeeid in (select mp.physician from (select p.*, t.* from trained_in as t right join (select procedures, physician from undergoes) as
p on t.physician = p.physician and p.procedures = t.treatment) as mp  where mp.treatment is null);
-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
select p.name from undergoes as u 
join procedures as pr on u.procedures = pr.code 
join trained_in as t on t.treatment = pr.code
join physician as p on p.employeeid = t.physician
where u.dateundergoes > t.CertificationExpires;
-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
select p.name, pr.name, u.dateundergoes, pa.name, t.CertificationExpires from undergoes as u 
join procedures as pr on u.procedures = pr.code 
join trained_in as t on t.treatment = pr.code
join physician as p on p.employeeid = t.physician
join patient as pa on pa.ssn = u.patient
where u.dateundergoes > t.CertificationExpires;
-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
select og.*, p.name from (select pa.name as patient, n.name as nurse, p.name as physician_name, pa.pcp as pcp , a.start_time, a.end_time, a.examinationroom from patient as pa
join appointment as a on pa.ssn = a.patient 
join physician as p on p.employeeid = a.physician
join nurse as n on n.employeeid  = a.prepnurse
where pa.pcp != a.physician) as og
join physician as p on p.employeeid = og.pcp;
-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
select u.* from undergoes as u
join stay as s on s.stayid = u.stay
where u.patient != s.patient;
-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
select n.name from stay as s
join room as r on s.room = r.roomnumber 
join block as b on r.blockFloor = b.blockfloor and r.blockCode = b.blockcode
join on_call as o on o.blockFloor = b.blockfloor and o.blockCode = b.blockcode
join nurse as n on o.nurse = n.employeeid
where s.room  = 123;
-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
select examinationroom, count(*) from appointment group by examinationroom;
-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

select pa.name, p.name from patient as pa, physician as p, (select ssn, count(prepnurse) from (select pa.ssn, a.prepnurse from patient as pa
join prescribes as pr on pa.ssn = pr.patient
join undergoes as u on pa.ssn = u.patient
join procedures as pro on u.procedures = pro.code
join appointment as a on a.patient = pa.ssn
where pro.cost > 5000
 and  pa.pcp not in (select head from department)
 and a.prepNurse in (select employeeid from nurse where registered =1)) as og
group by prepnurse,ssn) as agg
where pa.pcp = p.employeeid and pa.ssn  = agg.ssn and agg.count>1;

