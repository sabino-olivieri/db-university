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

-----------------------------------------------------------------------------------------------------------------

INNER JOIN

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`id`, `students`.`name`, `students`.`surname`
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.*
FROM `degrees`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`level` = "magistrale"
AND `departments`.`name` = "Dipartimento di Neuroscienze";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name` AS `nome_corso`
FROM `courses`
INNER JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento,
--    in ordine alfabetico per cognome e nome
SELECT `students`.`surname`, `students`.`name`, `degrees`.`name` AS `nome_corso`, `departments`.`name` AS `nome_dipartimento`
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `students`.`surname`, `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS `corso_laurea`, `courses`.`name` AS `nome_corso`, `teachers`.`surname` AS `cognome_prof` ,`teachers`.`name` AS `nome_prof` 
FROM `degrees`
INNER JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`  
ORDER BY `corso_laurea` ASC;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`surname`, `teachers`.`name`, `departments`.`name`
FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `degrees`
ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = "Dipartimento di matematica";

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT `students`.`id`,`students`.`surname`, `students`.`name`, `courses`.`id` AS `id_corso`,`courses`.`name` AS `nome_corso`, COUNT(*) AS `tentativi_falliti`
FROM `students`
INNER JOIN `exam_student`
ON `students`.`id` = `exam_student`.`student_id`
INNER JOIN `exams`
ON `exam_student`.`exam_id` = `exams`.`id`
INNER JOIN `courses`
ON `exams`.`course_id` = `courses`.`id`
WHERE `exam_student`.`vote` < 18
GROUP BY `courses`.`id`, `students`.`id`  
ORDER BY `students`.`id` ASC
