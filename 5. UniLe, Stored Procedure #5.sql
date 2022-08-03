#	Luiz Gustavo de Oliveira Nascimento
-- ------------------------------------------------------- --
#		Trabalho Prático - UniLe - Stored Procedure #5		#
-- ------------------------------------------------------- --

use unile;

DELIMITER $$
create procedure SP_boletim(IN cod_aluno int)
	begin
    
		select 	cod_aluno,
				aluno,
                disciplina,
                professor,
                cod_prova,
                nota
				from unile.vw_boletins bolet
                where bolet.cod_aluno = cod_aluno;
        
    end $$
    
DELIMITER ;
