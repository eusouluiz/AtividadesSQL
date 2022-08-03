#	Luiz Gustavo de Oliveira Nascimento
#	Script de criação do banco de dados UniLE

Create database UniLE;

Use UniLE;

Create table Alunos_RespFinanceiro (
	cpf_respfinanceiro char(11),
	nome_respfinanceiro varchar(25),
    sobrenome_respfinanceiro varchar(25),
    email_respfinanceiro varchar(30),
    primary key (cpf_respfinanceiro)
);

Create table Alunos (
	cod_aluno int,
	cpf_aluno char(11),
	nome_aluno varchar(25),
	sobrenome_aluno varchar(25),
	email_aluno varchar(30),
	cpf_respfinanceiro char(11),
	primary key (cod_aluno),
    foreign key (cpf_respfinanceiro) references Alunos_RespFinanceiro (cpf_respfinanceiro)
);

Create table Alunos_Contratos (
	numero_contrato int,
    cod_aluno int,
    data_assinatura date,
    data_vigencia date,
	primary key (numero_contrato),
	foreign key (cod_aluno) references Alunos (cod_aluno)
);

Create table Alunos_Enderecos (
	cod_aluno int,
    pais varchar(30),
    estado char(2),
    cidade varchar(30),
    bairro varchar(30),
    rua varchar(50),
    numero int,
    primary key (cod_aluno, pais, estado, cidade, bairro, rua, numero),
    foreign key (cod_aluno) references Alunos (cod_aluno)
);

Create table Alunos_Telefones (
	cod_aluno int,
    ddi char(5),
    ddd char(5),
    numero char(12),
    operadora char(10),
    descricao varchar(20),
    primary key (cod_aluno, ddi, ddd, numero),
    foreign key (cod_aluno) references Alunos (cod_aluno)
);

Create table Professores (
	cod_professor int,
    cpf_professor char(11),
    nome_professor varchar(25),
    sobrenome_professor varchar(25),
    email_professor varchar(30),
    primary key (cod_professor)
);

Create table Disciplinas (
	cod_disciplina int,
    nome_disciplina varchar(35),
    carga_horaria int,
    primary key (cod_disciplina)
);

Create table Professores_Disciplinas (
	cod_professor int,
    cod_disciplina int,
    primary key (cod_professor, cod_disciplina),
    foreign key (cod_professor) references Professores (cod_professor),
    foreign key (cod_disciplina) references Disciplinas (cod_disciplina)
);

Create table Livros (
	cod_livro int,
    titulo varchar(30),
    nome_autor varchar(25),
    sobrenome_autor varchar(25),
    primary key (cod_livro)
);

Create table Disciplinas_Livros (
	cod_disciplina int,
    cod_professor int,
    cod_livro int,
	primary key (cod_disciplina, cod_professor),
    foreign key (cod_disciplina) references Disciplinas (cod_disciplina),
    foreign key (cod_professor) references Professores (cod_professor),
    foreign key (cod_livro) references Livros (cod_livro)
);

Create table DisciplinasCursadas (
	matricula int,
    cod_aluno int,
    cod_professor int,
    cod_disciplina int,
    data_matricula date,
	primary key (matricula),
    foreign key (cod_aluno) references Alunos (cod_aluno),
    foreign key (cod_professor) references Professores (cod_professor),
    foreign key (cod_disciplina) references Disciplinas (cod_disciplina)
);

Create table Provas (
	cod_prova int,
    cod_disciplina int,
    cod_professor int,
    data_prova date,
    descricao varchar(50),
    primary key (cod_prova),
    foreign key (cod_disciplina) references Disciplinas (cod_disciplina),
    foreign key (cod_professor) references Professores (cod_professor)
);

Create table Alunos_Notas (
	matricula int,
    cod_prova int,
    nota float,
    primary key (matricula, cod_prova),
    foreign key (matricula) references DisciplinasCursadas (matricula),
    foreign key (cod_prova) references Provas (cod_prova)
);
