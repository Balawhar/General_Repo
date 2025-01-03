/*
owner	table	column	datatype
sdedba vlpdba	REF_CUSTOMER_ASSOCIATION	TECH_CUSTOMER_ASSOCIATION_ID	NUMBER(10)
INSERT INTO REF_SYS_TABLE_SEQUENCE		
TABLE_NAME	COLUMN_NAME	SEQUENCE_NAME
REF_CUSTOMER_ASSOCIATION	TECH_CUSTOMER_ASSOCIATION_ID	S_TECH_CUSTOMER_ASSOCIATION

*/
DECLARE 
NFOUND NUMBER;
BEGIN
    SELECT COUNT(*) INTO NFOUND FROM ALL_TAB_COLUMNS 
    WHERE TABLE_NAME = 'REF_CUSTOMER_ASSOCIATION' 
    AND OWNER = 'SDEDBA' 
    AND COLUMN_NAME = 'TECH_CUSTOMER_ASSOCIATION_ID';
    IF NFOUND = 0 THEN
    EXECUTE IMMEDIATE 'ALTER TABLE SDEDBA.REF_CUSTOMER_ASSOCIATION ADD TECH_CUSTOMER_ASSOCIATION_ID NUMBER(10)';
    END IF;
END;
/

   
   
   DECLARE 
NFOUND NUMBER;
BEGIN
    SELECT COUNT(*) INTO NFOUND FROM ALL_TAB_COLUMNS 
    WHERE TABLE_NAME = 'REF_CUSTOMER_ASSOCIATION' 
    AND OWNER = 'VLPDBA' 
    AND COLUMN_NAME = 'TECH_CUSTOMER_ASSOCIATION_ID';
    IF NFOUND = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE VLPDBA.REF_CUSTOMER_ASSOCIATION ADD TECH_CUSTOMER_ASSOCIATION_ID NUMBER(10)';
        EXECUTE IMMEDIATE '  CREATE SEQUENCE  VLPDBA.S_TECH_CUSTOMER_ASSOCIATION  MINVALUE 0 MAXVALUE 9999999999 INCREMENT BY 1 
        START WITH 128 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL';
    END IF;
END;
/
GRANT SELECT ON  VLPDBA.S_TECH_CUSTOMER_ASSOCIATION TO PUBLIC;

--SELECT * FROM DBA_SEQUENCES WHERE SEQUENCE_NAME = 'S_TECH_CUSTOMER_ASSOCIATION' ;
--SELECT COUNT(*) INTO NFOUND FROM DBA_SEQUENCES WHERE SEQUENCE_NAME = 'S_TECH_CUSTOMER_ASSOCIATION' ;
 /*   INSERT INTO REF_SYS_TABLE_SEQUENCE(OWNER, TABLE_NAME, COLUMN_NAME, SEQUENCE_NAME) 
    VALUES
('VLPDBA' , 'REF_CUSTOMER_ASSOCIATION',	'TECH_CUSTOMER_ASSOCIATION_ID',	'S_TECH_CUSTOMER_ASSOCIATION' );
COMMIT;
*/

INSERT INTO SDEDBA.REF_SYS_TABLE_SEQUENCE
  (OWNER, TABLE_NAME, COLUMN_NAME, SEQUENCE_NAME)
  SELECT 'VLPDBA',
         'REF_CUSTOMER_ASSOCIATION',
         'TECH_CUSTOMER_ASSOCIATION_ID',
         'S_TECH_CUSTOMER_ASSOCIATION'
    FROM DUAL
   WHERE ('REF_CUSTOMER_ASSOCIATION','S_TECH_CUSTOMER_ASSOCIATION') NOT IN
         (SELECT TABLE_NAME, SEQUENCE_NAME
            FROM SDEDBA.REF_SYS_TABLE_SEQUENCE);
COMMIT;

Exec SUITEDBA.STRUCTURE_DIAGNOSTIC.SEQUENCE_INITIALIZATION('VLPDBA','REF_CUSTOMER_ASSOCIATION');

