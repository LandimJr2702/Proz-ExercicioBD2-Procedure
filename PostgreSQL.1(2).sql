CREATE TABLE produto (
  id serial PRIMARY KEY,
  produto_data date NOT NULL,
  produto_nome varchar(100) NOT NULL,
  quantidade int NOT NULL
);

INSERT INTO produto (produto_data, produto_nome, quantidade)
VALUES ('2022-12-01', 'Notebook Dell', 2),
       ('2022-12-02', 'Teclado Logitech', 5),
       ('2022-12-03', 'Mouse Microsoft', 10),
       ('2022-12-04', 'Impressora HP', 7);

CREATE OR REPLACE FUNCTION relatorio_diario(p_data date)
RETURNS TABLE (temp_produto_name varchar(100), temp_quantidade int) AS $$
BEGIN
  RETURN QUERY
  SELECT produto_nome, SUM(quantidade)::integer as total_quantidade
  FROM produto
  WHERE produto_data = p_data
  GROUP BY produto_nome;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM relatorio_diario('2022-12-01');

