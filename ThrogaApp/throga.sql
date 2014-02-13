
/*
	rm throga.db
	sqlite3 throga.db < throga.sql
*/

CREATE TABLE 'exercise' (
'id' num INTEGER PRIMARY KEY,
'name' text,
'formant' text,
'feature' text,
'pattern' text,
'volume' text,
'tempo' text,
'variable' text,
'flexibility' num,
'breathing' num,
'intonation' num,
'range' num,
'tone' num,
'articulation' num,
'strength' num
);

CREATE TABLE 'exercise_type' (
'id' num INTEGER PRIMARY KEY,
'name' text
);

CREATE TABLE 'exercise_exercise_type' (
'exercise_id' num,
'exercise_type_id' num
);

INSERT INTO 'exercise' VALUES (1,'Me Descending Gliss','E','M/VFO','G81','Q','146','-',45,21,17,19,21,22,0);
INSERT INTO 'exercise' VALUES (2,'KE Sniffs','E','K','I54433221','Q','60','-',40,29,28,20,22,25,5);
INSERT INTO 'exercise' VALUES (3,'LipTrill Glissandos','Lip','-','G181','Q','100','-',39,25,16,23,16,19,5);
INSERT INTO 'exercise' VALUES (4,'O Glissandos','O','-','G5185','Q','98','-',35,23,21,26,20,18,10);
INSERT INTO 'exercise' VALUES (5,'Z Glissandos','Z','-','G151','Q','78','-',33,29,17,29,20,23,12);
INSERT INTO 'exercise' VALUES (6,'Ge Scales','E','G','I54535251m','Q','60','-',32,31,37,16,24,27,13);
INSERT INTO 'exercise' VALUES (7,'M E A Gliss','M E A','-','G1315181','M','120','-',30,17,16,31,25,32,14);
INSERT INTO 'exercise' VALUES (8,'Mum Scales','UH (LL)','M','I13531358531','M','60','-',28,19,24,33,38,24,16);
INSERT INTO 'exercise' VALUES (9,'Ge Interval Jumps','E','G','Is131 I131','M','75','-',25,28,37,23,29,32,20);
INSERT INTO 'exercise' VALUES (10,'AhOoAh Glissandos','Ah OO Ah','-','G181','M','98','-',23,19,18,41,35,20,21);
INSERT INTO 'exercise' VALUES (11,'Alpha Exercise','A E A O U','ALL','I12345m','M','95','-',23,23,29,22,33,42,21);
INSERT INTO 'exercise' VALUES (12,'Z Pulse Scales','Z','-','Is132435m','Q','30','-',23,39,32,27,21,26,23);
INSERT INTO 'exercise' VALUES (13,'Rapid HE Trips','E','H','SPT','Q','120','-',20,37,24,12,11,12,31);
INSERT INTO 'exercise' VALUES (14,'HE HA Legato Scales','E A','H','I14653451m','M','60','-',19,33,36,28,27,27,32);
INSERT INTO 'exercise' VALUES (15,'Ha Staccato Scales','A ','H','Is12131415m','M','78','-',10,37,42,33,32,26,41);
INSERT INTO 'exercise' VALUES (16,'Counting Swells','Numbers','-','S','S','9 sec','-',9,30,22,30,24,24,37);
INSERT INTO 'exercise' VALUES (17,'LA/GA Scales','A','L/G','I12-345m','L','44','-',8,32,33,29,44,40,36);
INSERT INTO 'exercise' VALUES (18,'5 Vowel Static','A E A O U','-','S','L','9 sec','-',5,21,20,22,25,29,36);

INSERT INTO 'exercise_type' VALUES (1,'Warmup');
INSERT INTO 'exercise_type' VALUES (2,'Full Workout');
INSERT INTO 'exercise_type' VALUES (3,'Flexibility');
INSERT INTO 'exercise_type' VALUES (4,'Breathing');
INSERT INTO 'exercise_type' VALUES (5,'Intonation');
INSERT INTO 'exercise_type' VALUES (6,'Range');
INSERT INTO 'exercise_type' VALUES (7,'Tone');
INSERT INTO 'exercise_type' VALUES (8,'Articulation');
INSERT INTO 'exercise_type' VALUES (9,'Strength');

--- Me Descending Gliss

INSERT INTO 'exercise_exercise_type' VALUES (1,1);
INSERT INTO 'exercise_exercise_type' VALUES (1,3);

--- KE Sniffs

INSERT INTO 'exercise_exercise_type' VALUES (2,1);
INSERT INTO 'exercise_exercise_type' VALUES (2,3);

--- LipTrill Glissandos

INSERT INTO 'exercise_exercise_type' VALUES (3,1);
INSERT INTO 'exercise_exercise_type' VALUES (3,3);

--- O Glissandos

INSERT INTO 'exercise_exercise_type' VALUES (4,1);
INSERT INTO 'exercise_exercise_type' VALUES (4,2);
INSERT INTO 'exercise_exercise_type' VALUES (4,3);
INSERT INTO 'exercise_exercise_type' VALUES (4,6);

--- Z Glissandos

INSERT INTO 'exercise_exercise_type' VALUES (5,1);
INSERT INTO 'exercise_exercise_type' VALUES (5,2);
INSERT INTO 'exercise_exercise_type' VALUES (5,3);
INSERT INTO 'exercise_exercise_type' VALUES (5,4);
INSERT INTO 'exercise_exercise_type' VALUES (5,6);


--- Ge Scales
INSERT INTO 'exercise_exercise_type' VALUES (6,1);
INSERT INTO 'exercise_exercise_type' VALUES (6,2);
INSERT INTO 'exercise_exercise_type' VALUES (6,3);
INSERT INTO 'exercise_exercise_type' VALUES (6,4);
INSERT INTO 'exercise_exercise_type' VALUES (6,5);

--- M E A Gliss
INSERT INTO 'exercise_exercise_type' VALUES (7,1);
INSERT INTO 'exercise_exercise_type' VALUES (7,2);
INSERT INTO 'exercise_exercise_type' VALUES (7,3);
INSERT INTO 'exercise_exercise_type' VALUES (7,6);
INSERT INTO 'exercise_exercise_type' VALUES (7,8);

--- Mum Scales
INSERT INTO 'exercise_exercise_type' VALUES (8,1);
INSERT INTO 'exercise_exercise_type' VALUES (8,2);
INSERT INTO 'exercise_exercise_type' VALUES (8,6);
INSERT INTO 'exercise_exercise_type' VALUES (8,7);

--- Ge Interval Jumps
INSERT INTO 'exercise_exercise_type' VALUES (9,1);
INSERT INTO 'exercise_exercise_type' VALUES (9,2);
INSERT INTO 'exercise_exercise_type' VALUES (9,5);
INSERT INTO 'exercise_exercise_type' VALUES (9,8);

--- AhOoAh Glissandos
INSERT INTO 'exercise_exercise_type' VALUES (10,2);
INSERT INTO 'exercise_exercise_type' VALUES (10,6);
INSERT INTO 'exercise_exercise_type' VALUES (10,7);

--- Alpha Exercise
INSERT INTO 'exercise_exercise_type' VALUES (11,2);
INSERT INTO 'exercise_exercise_type' VALUES (11,7);
INSERT INTO 'exercise_exercise_type' VALUES (11,8);

--- Z Pulse Scales
INSERT INTO 'exercise_exercise_type' VALUES (12,2);
INSERT INTO 'exercise_exercise_type' VALUES (12,4);
INSERT INTO 'exercise_exercise_type' VALUES (12,5);

--- Rapid HE Trips
INSERT INTO 'exercise_exercise_type' VALUES (13,2);
INSERT INTO 'exercise_exercise_type' VALUES (13,4);
INSERT INTO 'exercise_exercise_type' VALUES (13,9);

--- HE HA Legato Scales
INSERT INTO 'exercise_exercise_type' VALUES (14,2);
INSERT INTO 'exercise_exercise_type' VALUES (14,4);
INSERT INTO 'exercise_exercise_type' VALUES (14,5);
INSERT INTO 'exercise_exercise_type' VALUES (14,9);

--- Ha Staccato Scales
INSERT INTO 'exercise_exercise_type' VALUES (15,2);
INSERT INTO 'exercise_exercise_type' VALUES (15,4);
INSERT INTO 'exercise_exercise_type' VALUES (15,5);
INSERT INTO 'exercise_exercise_type' VALUES (15,9);

--- Counting Swells
INSERT INTO 'exercise_exercise_type' VALUES (16,2);
INSERT INTO 'exercise_exercise_type' VALUES (16,4);
INSERT INTO 'exercise_exercise_type' VALUES (16,6);
INSERT INTO 'exercise_exercise_type' VALUES (16,9);

--- LA/GA Scales
INSERT INTO 'exercise_exercise_type' VALUES (17,2);
INSERT INTO 'exercise_exercise_type' VALUES (17,7);
INSERT INTO 'exercise_exercise_type' VALUES (17,8);

--- 5 Vowel Static
INSERT INTO 'exercise_exercise_type' VALUES (18,2);
INSERT INTO 'exercise_exercise_type' VALUES (18,7);
INSERT INTO 'exercise_exercise_type' VALUES (18,8);
INSERT INTO 'exercise_exercise_type' VALUES (18,9);

