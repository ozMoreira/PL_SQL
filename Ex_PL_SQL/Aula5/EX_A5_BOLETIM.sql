/*
Criado por Oswaldo Moreira - 12/03/2022 17:12
Exercicio Aula 5 PL_SQL
Condições do Exercicio:

Tabela: Historico
cd_aluno - numérico - 2 - PK
nome_aluno - alfanumérico - 20 - Nn
nome_disciplina - alfanumérico - 20 - Nn, Uk
nota1 - numérico - 4,2
nota2 - numérico - 4,2
nota3 - numérico - 4,2
media - numérico - 4,2
carga_hora - numérico - 3
num_faltas - numérico - 3
situacao - alfanumérico - 40

Dados
10 - Marcel - Database and Data Science - 10 - 10 - 10 - null - 100 - 0 - null - Aprovado
20 - Marcel - Database and Data Science - 0 - 0 - 0 - null - 100 - 100 - null - Repr.Nota e Falta
30 - Marcel - Database and Data Science - 7 - 7 - 7 - null - 100 - 80 - null - Repr. Faltas
40 - Marcel - Database and Data Science - 4 - 4 - 4 - null - 100 - 0 - null - Repr. Notas
50 - Marcel - Database and Data Science - 5,5 - 5,5 - 5,5 - null - 100 - 40 - null - Repescagem

criar um bloco pl que leia os dados do aluno, calcule a média, 
insira o valor calculado na tabela, analise a sua nota e falta e preencha a coluna situação, de acordo com as regras a seguir:

aprovado: média >= 7 e faltas menor que 25% da carga horária da disciplina.
reprovado por nota e faltas: média menor que 5 e faltas maior que 25% da carga horária.
reprovado por faltas: média >= 7 e faltas maior que 25% da carga horária.
reprovado por nota: média < 5.
repescagem: média >= 5 e menor que 7, faltas menor que 25% da carga horária.
*/

------------------ Cria Tabela TB_HISTORICO ------------------ 
SET SERVEROUTPUT ON;

DROP TABLE TB_HISTORICO;
CREATE TABLE TB_HISTORICO(
cd_aluno            number primary key,
nm_aluno            varchar2(20) not null,
nm_disciplina       varchar2(25) not null,
nr_nota1            number(4,2),
nr_nota2            number(4,2),
nr_nota3            number(4,2),
nr_media               number(4,2),
nr_carga_horaria    number(3),
nr_faltas           number(3),
ds_situacao         varchar2(40)
);

--------------------------------------------------------------

BEGIN
    INSERT INTO TB_HISTORICO
        (cd_aluno, nm_aluno, nm_disciplina, nr_nota1, nr_nota2, nr_nota3, nr_media, nr_carga_horaria, nr_faltas, ds_situacao)
    VALUES
        (10, 'Marcel', 'Database and Data Science', 10, 10, 10, NULL, 100, 0, NULL  );
        
    INSERT INTO TB_HISTORICO
        (cd_aluno, nm_aluno, nm_disciplina, nr_nota1, nr_nota2, nr_nota3, nr_media, nr_carga_horaria, nr_faltas, ds_situacao)
    VALUES
        (20, 'Marcel', 'Database and Data Science', 0, 0, 0, NULL, 100, 100, NULL  );
        
    INSERT INTO TB_HISTORICO
        (cd_aluno, nm_aluno, nm_disciplina, nr_nota1, nr_nota2, nr_nota3, nr_media, nr_carga_horaria, nr_faltas, ds_situacao)
    VALUES
        (30, 'Marcel', 'Database and Data Science', 7, 7, 7, NULL, 100, 80, NULL  );
        
    INSERT INTO TB_HISTORICO
        (cd_aluno, nm_aluno, nm_disciplina, nr_nota1, nr_nota2, nr_nota3, nr_media, nr_carga_horaria, nr_faltas, ds_situacao)
    VALUES
        (40, 'Marcel', 'Database and Data Science', 4, 4, 4, NULL, 100, 0, NULL  );
        
    INSERT INTO TB_HISTORICO
        (cd_aluno, nm_aluno, nm_disciplina, nr_nota1, nr_nota2, nr_nota3, nr_media, nr_carga_horaria, nr_faltas, ds_situacao)
    VALUES
        (50, 'Marcel', 'Database and Data Science', 5.5, 5.5, 5.5, NULL, 100, 40, NULL  );
    
    COMMIT;
END;

--------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;
    
DECLARE 
    V_N1 NUMBER(4,2);
    V_N2 NUMBER(4,2);
    V_N3 NUMBER(4,2);
    V_MEDIA NUMBER(4,2);
    V_ID NUMBER := 10;
    V_TOTAL_REG NUMBER;
    V_FALTAS NUMBER;
    V_PERCENT_FALTAS NUMBER;
    V_SITUACAO VARCHAR2(40);
    V_CARGA_HORARIA CONSTANT NUMBER := 100;
    
BEGIN 
    
    SELECT COUNT(*) 
        CD_ALUNO 
    INTO 
        V_TOTAL_REG 
    FROM TB_HISTORICO;
    
    FOR V_CONTADOR IN 1..V_TOTAL_REG
    LOOP
        SELECT 
            NR_NOTA1, 
            NR_NOTA2, 
            NR_NOTA3,
            NR_FALTAS
        INTO 
            V_N1, 
            V_N2, 
            V_N3,
            V_FALTAS
        FROM TB_HISTORICO 
        WHERE CD_ALUNO IN V_ID;
        
        V_MEDIA := (v_n1+v_n2+v_n3) / 3;
        V_PERCENT_FALTAS := (V_FALTAS / V_CARGA_HORARIA)*100;

        IF V_PERCENT_FALTAS < 25 AND V_MEDIA >= 7 THEN
            V_SITUACAO := 'APROVADO';
        ELSIF V_PERCENT_FALTAS < 25 AND V_MEDIA  >= 5 AND V_MEDIA < 7 THEN
               V_SITUACAO := 'REPESCAGEM';   
        ELSIF V_PERCENT_FALTAS > 25 AND V_MEDIA  >= 7 THEN
            V_SITUACAO := 'REPROVADO POR FALTAS';
        ELSIF V_PERCENT_FALTAS > 25 AND V_MEDIA < 5 THEN
            V_SITUACAO := 'REPROVADO POR NOTAS E FALTAS';
        ELSIF V_MEDIA  < 5 THEN
            V_SITUACAO := 'REPROVADO POR NOTA';
        ELSE
            V_SITUACAO :='ERRO';
        END IF;
       
        UPDATE TB_HISTORICO SET NR_MEDIA = V_MEDIA, DS_SITUACAO = V_SITUACAO  WHERE CD_ALUNO IN V_ID;
        
        V_ID := V_ID + 10;

    END LOOP;
    COMMIT;
END;
