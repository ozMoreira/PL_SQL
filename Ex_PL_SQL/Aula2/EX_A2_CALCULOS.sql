--Criar um bloco PL-SQL para calcular o valor de cada parcela de uma compra de um carro, nas seguintes condições:

-- - Parcelas para aquisição em 6 pagamentos.

-- - Parcelas para aquisição em 12 pagamentos.

-- - Parcelas para aquisição em 18 pagamentos.

-- OBSERVAÇÃO:

-- 1 - Deverá ser dada uma entrada de 20% do valor da compra.

-- 2 – Deverá ser aplicada uma taxa juros, no saldo restante, nas seguintes condições:

--3 – No final informar o valor das parcelas para as 3 formas de pagamento, com o Valor de aquisição de 10.000 e o mesmo com entrada de dados via teclado (em tempo de execução).

-- A – Pagamento em 6 parcelas: 10%.

-- B – Pagamento em 12 parcelas: 15%.

-- C – Pagamento em 18 parcelas: 20%.
------


SET SERVEROUTPUT ON;
DECLARE

    vl_total NUMBER(10,2) := 10000.00;
    vl_entrada NUMBER(10,2) := 0;
    vl_saldo_entrada NUMBER(10,2) := 0;
    vl_saldo_corrigido NUMBER(10,2) := 0;
    vl_parcela NUMBER(10,2) := 0;
    vl_total_prazo NUMBER(10,2) := 0;
    op_parcelamento CHAR(1) := 'A';
    --A = 6x
    --B = 12x
    --C = 18x
BEGIN
    vl_entrada := vl_total * 0.2;
    vl_saldo_entrada := vl_total * 0.8;
    
    IF op_parcelamento = 'A' OR op_parcelamento = 'a' THEN
        vl_saldo_corrigido := vl_saldo_entrada * 1.1;
        vl_parcela := vl_saldo_corrigido / 6;
        vl_total_prazo := vl_saldo_entrada +  vl_saldo_corrigido;
        DBMS_OUTPUT.PUT_LINE('Valor da parcela >>>' || vl_parcela );
        DBMS_OUTPUT.PUT_LINE('Valor a prazo >>>' || vl_total_prazo );
    ELSIF op_parcelamento = 'B' OR op_parcelamento = 'b' THEN
        vl_saldo_corrigido := vl_saldo_entrada * 1.15;
        vl_parcela := vl_saldo_corrigido / 12;
        vl_total_prazo := vl_saldo_entrada +  vl_saldo_corrigido;
        DBMS_OUTPUT.PUT_LINE('Valor da parcela >>>' || vl_parcela );
        DBMS_OUTPUT.PUT_LINE('Valor a prazo >>>' || vl_total_prazo );
    ELSIF op_parcelamento = 'C' OR op_parcelamento = 'c' THEN
        vl_saldo_corrigido := vl_saldo_entrada * 1.18;
        vl_parcela := vl_saldo_corrigido / 18;
        vl_total_prazo := vl_saldo_entrada +  vl_saldo_corrigido;
        DBMS_OUTPUT.PUT_LINE('Valor da parcela >>>' || vl_parcela );
        DBMS_OUTPUT.PUT_LINE('Valor a prazo >>>' || vl_total_prazo );
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Opção de Parcelamento Inválido!');
    END IF;

END;

