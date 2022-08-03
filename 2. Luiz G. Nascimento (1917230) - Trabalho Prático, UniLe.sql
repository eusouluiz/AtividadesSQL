#	Luiz Gustavo de Oliveira Nascimento - 1917230
-- ----------------------------------- --
#		Trabalho Prático - UniLe		#
-- ----------------------------------- --

Use unile;

# Atividade 1

# A.
insert into alunos(cod_aluno,cpf_aluno,nome_aluno,sobrenome_aluno,email_aluno)
values
		(1,'56926648018','Luna','Lovegood','l.lovegood@hogwarts.com'),
        (2,'45000328000','Draco','Malfoy','d.malfoy@hogwarts.com'),
        (3,'60255342098','Hermione','Granger','h.granger@hogwarts.com'),
        (4,'15465007079','Tom','Riddle','l.voldemort@hogwarts.com'),
        (5,'02626459046','Cedrico','Diggory','c.diggory@hogwarts.com');

# B.
insert into professores(cod_professor,cpf_professor,nome_professor,sobrenome_professor,email_professor)
values
		(1,'40891404040','Alvo','Dumbledore','a.dumbledore@hogwarts.com'),
        (2,'46454047091','Minerva','McGonagall','m.mcgonagall@hogwarts.com'),
        (3,'85061089006','Severo','Snape','s.snape@hogwarts.com');

# C.
insert into disciplinas(cod_disciplina,nome_disciplina,carga_horaria)
values
		(1,'Feitiços',100),
        (2,'Defesa Contra as Artes das Trevas',75),
        (3,'Transfiguração',90),
        (4,'Poções',80);

# D.
insert into professores_disciplinas(cod_professor,cod_disciplina)
values
		(1,2),
        (1,3),
        (2,1),
        (3,4);

# E.
insert into disciplinascursadas(matricula,cod_aluno,cod_professor,cod_disciplina,data_matricula)
values
		(1,1,2,1,'2020/02/02'),
        (2,1,1,2,'2020/02/02'),
        (3,1,1,3,'2020/02/02'),
        (4,4,1,2,'2020/02/02'),
        (5,4,3,4,'2020/02/02'),
		(6,3,2,1,'2020/02/02'),
        (7,3,1,2,'2020/02/02'),
        (8,2,1,2,'2020/02/02');
        
# F.
insert into provas(cod_prova,cod_disciplina,cod_professor)
values
		(1,2,1),
        (2,3,1);

insert into alunos_notas(matricula,cod_prova,nota)
values
		(2,1,9.4),
        (7,1,10),
        (3,2,9.7),
        (4,2,5.6),
        (8,1,3);

# Atividade 2 - Teste do Stored Procedure

call SP_prof_disc (1,4);

call SP_prof_disc (3,1);

call SP_prof_disc (2,3);

select * from unile.professores_disciplinas;

# Atividade 3 - Teste do Stored Procedure

call SP_matricular_alunos (9,3,1,2,'2020/11/11');

call SP_matricular_alunos (10,3,3,4,'2020/11/11');

call SP_matricular_alunos (11,5,3,1,'2020/11/11');

call SP_matricular_alunos (12,5,1,2,'2020/11/11');

call SP_matricular_alunos (13,5,2,3,'2020/11/11');

call SP_matricular_alunos (14,5,3,4,'2020/11/11');

select * from unile.disciplinascursadas;

# Atividade 4

create view vw_boletins as
	select 	a.cod_aluno,
			concat(a.nome_aluno,' ',a.sobrenome_aluno) as aluno,
            d.cod_disciplina,
			d.nome_disciplina as disciplina,
			concat(p.nome_professor,' ',p.sobrenome_professor) as professor,
			an.cod_prova,
			an.nota
			from alunos a
			inner join disciplinascursadas dc on a.cod_aluno = dc.cod_aluno
			inner join professores p on dc.cod_professor = p.cod_professor
			inner join disciplinas d on dc.cod_disciplina = d.cod_disciplina
			inner join alunos_notas an on dc.matricula = an.matricula
            order by a.cod_aluno asc, d.cod_disciplina;
        
select * from unile.vw_boletins;

# Atividade 5 - Teste do Stored Procedure

call SP_boletim (1);

call SP_boletim (3);

# Atividade 6

DELIMITER $$
create function F_result (cod_aluno int, cod_disciplina int)
	returns char(15)
    DETERMINISTIC
    begin
		if (	select 	avg(bolet.nota)
						from unile.vw_boletins bolet
						where bolet.cod_aluno = cod_aluno and bolet.cod_disciplina = cod_disciplina) >= 7.0 then
			return('Aprovado.');
		elseif (	select 	avg(bolet.nota)
							from unile.vw_boletins bolet
							where bolet.cod_aluno = cod_aluno and bolet.cod_disciplina = cod_disciplina) >= 4.0 then
			return('Exame final.');
		else
			return ('Reprovado.');
		end if;
	
    end $$
    
DELIMITER ;

select F_result(1, 2);

select F_result(4, 2);

select F_result(2, 1);

# Atividade 7

create view vw_boletins_result as
	select 	a.cod_aluno,
			concat(a.nome_aluno,' ',a.sobrenome_aluno) as aluno,
            d.cod_disciplina,
			d.nome_disciplina as disciplina,
			concat(p.nome_professor,' ',p.sobrenome_professor) as professor,
			an.cod_prova,
			cast(avg(an.nota) as float) as nota,
            unile.F_result(a.cod_aluno,d.cod_disciplina) as resultado
			from alunos a
			inner join disciplinascursadas dc on a.cod_aluno = dc.cod_aluno
			inner join professores p on dc.cod_professor = p.cod_professor
			inner join disciplinas d on dc.cod_disciplina = d.cod_disciplina
			inner join alunos_notas an on dc.matricula = an.matricula
            group by a.cod_aluno, d.cod_disciplina
            order by a.cod_aluno asc, d.cod_disciplina;
            
select * from unile.vw_boletins_result;