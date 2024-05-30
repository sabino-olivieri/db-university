GROUP BY

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`students`.`enrolment_date`) AS `anno_iscrizione`, COUNT(*) AS `numero_iscritti`
FROM `students`
GROUP BY YEAR(`students`.`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `teachers`.`office_address`, COUNT(*) AS `num_of_teachers`
FROM `teachers`
GROUP BY `teachers`.`office_address`  
ORDER BY `num_of_teachers` ASC;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_student`.`exam_id`, AVG(`exam_student`.`vote`) AS `media_appello`, COUNT(*) AS `esami_sostenuti`
FROM `exam_student`
GROUP BY `exam_student`.`exam_id`  
ORDER BY `esami_sostenuti`  DESC;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `degrees`.`department_id`, COUNT(*) AS `num_degrees`
FROM `degrees`
GROUP BY `degrees`.`department_id`;