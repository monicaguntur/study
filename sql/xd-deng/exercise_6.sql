-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
select s.name as scientist, p.name as project, p.hours from scientists as s, assignedto as a, projects as p where s.ssn=a.scientist and a.project = p.code order by project, scientist;
-- 6.2 Select the project names which are not assigned yet
select name from projects where code not in (select project from assignedto);
