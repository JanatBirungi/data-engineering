-- total passengers that boarded the titanic
SELECT COUNT(*) AS total_passengers FROM passenger;

-- list of all survivors with their names,age and sex
SELECT name, age, sex FROM passenger 
LEFT JOIN survival ON passenger.survival_id = survival.id 
WHERE survived = 'Yes';

-- how many passengers survived?
 SELECT COUNT(*) AS total_passengers_survived FROM passenger 
 LEFT JOIN survival ON passenger.survival_id = survival.id 
 WHERE survived = 'Yes';

-- survival rate by passenger class

SELECT CASE WHEN survived = 'Yes' THEN 'Survived' ELSE 'Died' END AS survival, passenger_class, COUNT(*) AS total_passengers
FROM passenger
LEFT JOIN survival ON passenger.survival_id = survival.id
LEFT JOIN payments ON passenger.id = payments.passenger_id
INNER JOIN passenger_class ON payments.passenger_class_id = passenger_class.id
GROUP BY survived, passenger_class ORDER BY passenger_class;

--  survival rate by gender

SELECT CASE WHEN survived = 'Yes' THEN 'Survived' ELSE 'Died' END AS survival, sex AS gender, COUNT(*) AS total_passengers
FROM passenger
LEFT JOIN survival ON passenger.survival_id = survival.id
GROUP BY survived, sex ORDER BY sex;

-- survival rate by age

WITH details AS(
SELECT CASE WHEN survived = 'Yes' THEN 'Survived' ELSE 'Died' END AS survival, 
CASE WHEN age < 12 THEN 'child' 
     WHEN age BETWEEN 12 AND 19 THEN 'teenager' 
     WHEN age BETWEEN 20 AND 35 THEN '20-35' 
     WHEN age BETWEEN 36 AND 45 THEN '36-45' 
     ELSE 'older_than_45' 
END AS age_bracket, 
name
FROM passenger
INNER JOIN survival ON passenger.survival_id = survival.id
)
SELECT
    survival,
    age_bracket,
    COUNT(*) AS total_passengers
FROM details
GROUP BY survival, age_bracket ORDER BY age_bracket;

-- where did most people board from?
SELECT port_of_embarkation,COUNT(passenger_id) AS passengers_from_port 
FROM payments
LEFT JOIN embarked ON payments.embarked_id = embarked.id
GROUP BY port_of_embarkation ORDER BY COUNT(passenger_id);

-- average fare for tickets, and average fare by class
 SELECT AVG(fare) FROM payments; -- 35.63 pounds

SELECT passenger_class, AVG(fare) FROM payments
LEFT JOIN passenger_class ON payments.passenger_class_id = passenger_class.id
GROUP BY passenger_class;

-- did people share cabins? Which cabin had the most people and how many were they?
SELECT cabin_name, COUNT(passenger_id) AS passengers_in_cabin FROM payments
INNER JOIN cabin ON payments.cabin_id = cabin.id
GROUP BY cabin_name ORDER BY COUNT(passenger_id) DESC;

-- which cabins belonged to which passenger class
SELECT passenger_class, STRING_AGG(cabin_name,',') AS cabins_in_class FROM payments
INNER JOIN passenger_class ON payments.passenger_class_id = passenger_class.id
INNER JOIN cabin ON payments.cabin_id = cabin.id
GROUP BY passenger_class,passenger_class.id ORDER BY passenger_class.id;

-- correlation between port of embarkation and passenger_class
 SELECT port_of_embarkation, passenger_class, count(passenger_id) AS passengers_who_embarked FROM payments
INNER JOIN embarked ON payments.embarked_id = embarked.id
INNER JOIN passenger_class ON payments.passenger_class_id = passenger_class.id
GROUP BY port_of_embarkation, passenger_class ORDER BY passenger_class;

-- how many people had a sibsp/ parch on board? Did this affect whether they survived or died?
SELECT COALESCE(survival_id::VARCHAR, 'total') survival_status, passengers_with_sibsp_or_parch,  
FROM(
SELECT survival_id, COUNT(*) AS passengers_with_sibsp_or_parch FROM passenger WHERE (parch > 0 or sibsp >0) GROUP BY ROLLUP(survival_id))sub;





