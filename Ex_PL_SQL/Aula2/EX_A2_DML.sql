SET SERVEROUTPUT ON;

CREATE TABLE
ALUNO
(nr_ra char(9) primary key,
nm_nome varchar(50));

BEGIN
    INSERT INTO ALUNO (NR_RA, NM_NOME) VALUES ('111222333', 'ANTONIO ALVES');
    INSERT INTO ALUNO (NR_RA, NM_NOME) VALUES ('444555666', 'ANTONIO SILVA');
    INSERT INTO ALUNO (NR_RA, NM_NOME) VALUES ('777888999', 'ANTONIO JOSE');
END;
commit;

SET SERVEROUTPUT ON;
DECLARE 
    V_RA CHAR(9) := '444555666';
    V_NOME VARCHAR2(50);
BEGIN
    SELECT NM_NOME INTO V_NOME FROM ALUNO WHERE NR_RA IN V_RA;
    DBMS_OUTPUT.PUT_LINE('O nome do aluno é: '||V_NOME);
    
END;
-----
SET SERVEROUTPUT ON;
DECLARE 
    V_RA CHAR(9) := '010202030';
    V_NOME VARCHAR2(50) := 'BRUNA MARIA';
BEGIN
    INSERT INTO ALUNO (NR_RA, NM_NOME) VALUES (V_RA, V_NOME);
    DBMS_OUTPUT.PUT_LINE('O nome do NOVO aluno é: '||V_NOME);
END;

SET SERVEROUTPUT ON;
DECLARE 
    V_RA CHAR(9) := '444555666';
    V_NOME VARCHAR2(50) := 'OSWALDO MANOELITO';
BEGIN
    UPDATE ALUNO SET NM_NOME = V_NOME WHERE NR_RA IN V_RA;
    DBMS_OUTPUT.PUT_LINE('O novo nome do aluno é: '||V_NOME);
END;


SET SERVEROUTPUT ON;
DECLARE 
    V_RA CHAR(9) := '111222333';

BEGIN
    DELETE FROM ALUNO WHERE NR_RA IN V_RA;
END;
SELECT * FROM ALUNO;
