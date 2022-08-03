#	Luiz Gustavo de Oliveira Nascimento
-- ------------------------------------------------------- --
#		Trabalho Prático - UniLe - Stored Procedure #2		#
-- ------------------------------------------------------- --

use unile;

DELIMITER $$
create procedure SP_prof_disc(IN cod_professor int, IN cod_disciplina int)
	begin
    
		insert into professores_disciplinas (professores_disciplinas.cod_professor,professores_disciplinas.cod_disciplina)
		values	(cod_professor,cod_disciplina);
        
    end $$
    
DELIMITER ;
