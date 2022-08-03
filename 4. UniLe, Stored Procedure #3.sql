#	Luiz Gustavo de Oliveira Nascimento
-- ------------------------------------------------------- --
#		Trabalho Prático - UniLe - Stored Procedure #3		#
-- ------------------------------------------------------- --

use unile;

DELIMITER $$
create procedure SP_matricular_alunos(IN matricula int, IN cod_aluno int, IN cod_professor int, IN cod_disciplina int, IN data_matricula date)
	begin

        insert into disciplinascursadas(disciplinascursadas.matricula,disciplinascursadas.cod_aluno,disciplinascursadas.cod_professor,disciplinascursadas.cod_disciplina,disciplinascursadas.data_matricula)
		values (matricula,cod_aluno,cod_professor,cod_disciplina,data_matricula);
        
    end $$
    
DELIMITER ;
