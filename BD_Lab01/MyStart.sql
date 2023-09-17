create table YNS_t( x number(3), s varchar2(50));

INSERT INTO YNS_t (x, s) VALUES (1, 'First row');
INSERT INTO YNS_t (x, s) VALUES (2, 'Second row');
INSERT INTO YNS_t (x, s) VALUES (3, 'Third row');

COMMIT;

UPDATE YNS_t SET s = 'Modified first row' WHERE x = 1;
UPDATE YNS_t SET s = 'Modified second row' WHERE x = 2;

COMMIT;

SELECT * FROM YNS_t;
SELECT * FROM YNS_t WHERE x > 1;
SELECT * FROM YNS_t WHERE INSTR(s, 'row') > 0;
SELECT COUNT(*) AS row_count FROM YNS_t;
SELECT MAX(x) AS max_x FROM YNS_t;
SELECT MIN(x) AS min_x FROM YNS_t;
SELECT AVG(x) AS avg_x FROM YNS_t;

INSERT INTO YNS_t (x, s) VALUES (4, 'Forth row');

COMMIT;

DELETE FROM YNS_t WHERE x = 4;

COMMIT;

ALTER TABLE YNS_t
ADD CONSTRAINT PK_YNS_t PRIMARY KEY (x);

COMMIT;

CREATE TABLE YNS_t1 (
  id NUMBER PRIMARY KEY,
  YNS_t_id NUMBER,

  CONSTRAINT fk_YNS_t_id
    FOREIGN KEY (YNS_t_id)
    REFERENCES YNS_t(x)
);

COMMIT;

INSERT INTO YNS_t1 (id, YNS_t_id) VALUES (1, 1);
INSERT INTO YNS_t1 (id, YNS_t_id) VALUES (2, 2);
INSERT INTO YNS_t1 (id, YNS_t_id) VALUES (3, 3);

COMMIT;

SELECT *
FROM YNS_t
LEFT JOIN YNS_t1 ON YNS_t.x = YNS_t1.YNS_t_id;

SELECT *
FROM YNS_t
RIGHT JOIN YNS_t1 ON YNS_t.x = YNS_t1.YNS_t_id;

SELECT *
FROM YNS_t
INNER JOIN YNS_t1 ON YNS_t.x = YNS_t1.YNS_t_id;

DROP TABLE YNS_t;
DROP TABLE YNS_t1;


